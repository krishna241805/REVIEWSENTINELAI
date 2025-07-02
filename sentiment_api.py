# Improved Sentiment Analysis API using Multiple Models
# This module provides enhanced sentiment analysis with better accuracy

from flask import Flask, request, jsonify
from transformers import pipeline, AutoTokenizer, AutoModelForSequenceClassification
import logging
import numpy as np
from typing import List, Dict, Any
import torch

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Initialize Flask app
app = Flask(__name__)

class SentimentAnalyzer:
    def __init__(self):
        self.models = {}
        self.load_models()
    
    def load_models(self):
        """Load multiple sentiment analysis models for better accuracy"""
        try:
            # Model 1: RoBERTa-based model (more accurate for general sentiment)
            logger.info("Loading RoBERTa sentiment model...")
            self.models['roberta'] = pipeline(
                "sentiment-analysis",
                model="cardiffnlp/twitter-roberta-base-sentiment-latest",
                return_all_scores=True
            )
            
            # Model 2: DistilBERT (faster, good baseline)
            logger.info("Loading DistilBERT sentiment model...")
            self.models['distilbert'] = pipeline(
                "sentiment-analysis",
                model="distilbert-base-uncased-finetuned-sst-2-english",
                return_all_scores=True
            )
            
            # Model 3: VADER-like model for social media text
            logger.info("Loading VADER-style model...")
            self.models['vader_style'] = pipeline(
                "sentiment-analysis",
                model="nlptown/bert-base-multilingual-uncased-sentiment",
                return_all_scores=True
            )
            
            logger.info("All models loaded successfully.")
            
        except Exception as e:
            logger.error(f"Error loading models: {str(e)}")
            # Fallback to basic model if others fail
            self.models['basic'] = pipeline(
                "sentiment-analysis",
                model="distilbert-base-uncased-finetuned-sst-2-english",
                return_all_scores=True
            )
    
    def preprocess_text(self, text: str) -> str:
        """Enhanced text preprocessing"""
        import re
        
        # Remove extra whitespace
        text = re.sub(r'\s+', ' ', text.strip())
        
        # Handle common abbreviations
        text = re.sub(r'\bu\b', 'you', text, flags=re.IGNORECASE)
        text = re.sub(r'\bur\b', 'your', text, flags=re.IGNORECASE)
        text = re.sub(r'\bdont\b', "don't", text, flags=re.IGNORECASE)
        text = re.sub(r'\bcant\b', "can't", text, flags=re.IGNORECASE)
        text = re.sub(r'\bwont\b', "won't", text, flags=re.IGNORECASE)
        
        # Handle repeated punctuation
        text = re.sub(r'[!]{2,}', '!', text)
        text = re.sub(r'[?]{2,}', '?', text)
        text = re.sub(r'[.]{3,}', '...', text)
        
        return text
    
    def normalize_labels(self, results: List[Dict], model_name: str) -> Dict[str, float]:
        """Normalize different model outputs to consistent labels"""
        normalized = {"Positive": 0.0, "Neutral": 0.0, "Negative": 0.0}
        
        for result in results:
            label = result['label'].upper()
            score = result['score']
            
            # Handle different label formats from different models
            if model_name == 'roberta':
                if 'POSITIVE' in label or 'POS' in label:
                    normalized["Positive"] = score
                elif 'NEGATIVE' in label or 'NEG' in label:
                    normalized["Negative"] = score
                elif 'NEUTRAL' in label or 'NEU' in label:
                    normalized["Neutral"] = score
            
            elif model_name == 'distilbert':
                if 'LABEL_1' in label or 'POSITIVE' in label:
                    normalized["Positive"] = score
                elif 'LABEL_0' in label or 'NEGATIVE' in label:
                    normalized["Negative"] = score
                else:
                    normalized["Neutral"] = score
            
            elif model_name == 'vader_style':
                # This model uses star ratings, convert to sentiment
                if '4' in label or '5' in label:
                    normalized["Positive"] = score
                elif '1' in label or '2' in label:
                    normalized["Negative"] = score
                else:
                    normalized["Neutral"] = score
            
            else:  # basic model
                if 'LABEL_1' in label or 'POSITIVE' in label:
                    normalized["Positive"] = score
                elif 'LABEL_0' in label or 'NEGATIVE' in label:
                    normalized["Negative"] = score
                else:
                    normalized["Neutral"] = score
        
        return normalized
    
    def ensemble_predict(self, text: str) -> Dict[str, Any]:
        """Use ensemble of models for better accuracy"""
        text = self.preprocess_text(text)
        
        if len(text.strip()) < 3:
            return {
                "sentiment": "Neutral",
                "confidence_percentages": {"Positive": 33.33, "Neutral": 33.33, "Negative": 33.33},
                "model_agreement": 0.0
            }
        
        all_predictions = {}
        model_scores = {"Positive": [], "Neutral": [], "Negative": []}
        
        # Get predictions from all available models
        for model_name, model in self.models.items():
            try:
                results = model(text)
                normalized = self.normalize_labels(results, model_name)
                all_predictions[model_name] = normalized
                
                # Collect scores for ensemble
                for sentiment, score in normalized.items():
                    model_scores[sentiment].append(score)
                    
            except Exception as e:
                logger.warning(f"Model {model_name} failed: {str(e)}")
                continue
        
        if not all_predictions:
            logger.error("All models failed!")
            return {
                "sentiment": "Neutral",
                "confidence_percentages": {"Positive": 33.33, "Neutral": 33.33, "Negative": 33.33},
                "model_agreement": 0.0
            }
        
        # Calculate ensemble averages
        ensemble_scores = {}
        for sentiment in ["Positive", "Neutral", "Negative"]:
            if model_scores[sentiment]:
                ensemble_scores[sentiment] = np.mean(model_scores[sentiment]) * 100
            else:
                ensemble_scores[sentiment] = 0.0
        
        # Determine final sentiment
        final_sentiment = max(ensemble_scores, key=ensemble_scores.get)
        
        # Calculate model agreement (how much models agree)
        agreement_scores = []
        sentiments = list(ensemble_scores.keys())
        for i, model_pred in enumerate(all_predictions.values()):
            model_sentiment = max(model_pred, key=model_pred.get)
            agreement_scores.append(1 if model_sentiment == final_sentiment else 0)
        
        model_agreement = np.mean(agreement_scores) if agreement_scores else 0.0
        
        # Log detailed results
        logger.info(f"Input text: {text}")
        logger.info(f"Individual model predictions: {all_predictions}")
        logger.info(f"Ensemble scores: {ensemble_scores}")
        logger.info(f"Final sentiment: {final_sentiment}")
        logger.info(f"Model agreement: {model_agreement:.2f}")
        
        # Enhanced confidence detection
        max_score = ensemble_scores[final_sentiment]
        second_max = sorted(ensemble_scores.values(), reverse=True)[1]
        confidence_gap = max_score - second_max
        
        if confidence_gap < 10:  # If top two scores are very close
            logger.warning(f"⚠️ Low confidence prediction - scores are close: {ensemble_scores}")
        
        if final_sentiment == "Negative" and max_score < 50:
            logger.warning(f"⚠️ Weak negative classification: {ensemble_scores}")
        
        return {
            "sentiment": final_sentiment,
            "confidence_percentages": {k: round(v, 2) for k, v in ensemble_scores.items()},
            "model_agreement": round(model_agreement, 2),
            "confidence_gap": round(confidence_gap, 2),
            "individual_predictions": all_predictions
        }

# Initialize the analyzer
analyzer = SentimentAnalyzer()

@app.route('/analyze', methods=['POST'])
def analyze():
    """Analyze sentiment of a single text with improved accuracy."""
    data = request.json
    if not data or 'text' not in data:
        return jsonify({'error': 'Text field is required'}), 400

    try:
        result = analyzer.ensemble_predict(data['text'])
        
        return jsonify({
            'result': {
                'text': data['text'],
                'sentiment': result['sentiment'],
                'confidence_percentages': result['confidence_percentages'],
                'model_agreement': result['model_agreement'],
                'confidence_gap': result['confidence_gap'],
                'prediction_quality': 'High' if result['model_agreement'] > 0.7 and result['confidence_gap'] > 15 else 'Medium' if result['model_agreement'] > 0.5 else 'Low'
            }
        })
    except Exception as e:
        logger.error(f"Error analyzing text: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/analyze_batch', methods=['POST'])
def analyze_batch():
    """Analyze sentiment of multiple texts with improved accuracy."""
    data = request.json
    if not data or 'texts' not in data or not isinstance(data['texts'], list):
        return jsonify({'error': 'Texts field must be a list of strings'}), 400

    try:
        results = []
        sentiment_counts = {"Positive": 0, "Neutral": 0, "Negative": 0}
        
        for i, text in enumerate(data['texts']):
            result = analyzer.ensemble_predict(text)
            sentiment_counts[result['sentiment']] += 1
            
            logger.info(f"[Batch Item {i}] Sentiment: {result['sentiment']} (Agreement: {result['model_agreement']:.2f})")
            
            results.append({
                'text': text,
                'sentiment': result['sentiment'],
                'confidence_percentages': result['confidence_percentages'],
                'model_agreement': result['model_agreement'],
                'prediction_quality': 'High' if result['model_agreement'] > 0.7 and result['confidence_gap'] > 15 else 'Medium' if result['model_agreement'] > 0.5 else 'Low'
            })
        
        return jsonify({
            'results': results,
            'summary': {
                'total_reviews': len(data['texts']),
                'distribution': sentiment_counts,
                'overall_sentiment': max(sentiment_counts, key=sentiment_counts.get)
            }
        })
    except Exception as e:
        logger.error(f"Error analyzing batch: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/health', methods=['GET'])
def health_check():
    """Enhanced health check with model status."""
    model_status = {}
    for name, model in analyzer.models.items():
        try:
            # Test with a simple phrase
            test_result = model("This is good")
            model_status[name] = "healthy"
        except Exception as e:
            model_status[name] = f"error: {str(e)}"
    
    return jsonify({
        'status': 'healthy',
        'models': model_status,
        'total_models': len(analyzer.models)
    })

@app.route('/model_info', methods=['GET'])
def model_info():
    """Get information about loaded models."""
    return jsonify({
        'available_models': list(analyzer.models.keys()),
        'model_count': len(analyzer.models),
        'ensemble_method': 'weighted_average'
    })

# Run the API server
if __name__ == '__main__':
    print("=== Starting Enhanced Sentiment Analysis API ===")
    print("API available at http://127.0.0.1:5000")
    print("Endpoints:")
    print("  POST /analyze - Single text analysis")
    print("  POST /analyze_batch - Batch text analysis")
    print("  GET  /health - Health check with model status")
    print("  GET  /model_info - Model information")
    app.run(debug=True)