import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter1/widget/app_bar.dart';
import 'package:flutter1/result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _textController = TextEditingController();
  File? selectedFile;
  bool isLoading = false;
  final FocusNode _textFocusNode = FocusNode();
  bool _showTextBox = false;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        // Clear text input when file is selected
        _textController.clear();
        // Hide text box when file is selected
        _showTextBox = false;
      });
    }
  }

  Future<void> analyzeData() async {
    // Don't proceed if both text and file are empty
    if (_textController.text.isEmpty && selectedFile == null) {
      showError("Please enter text or select a file to analyze.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // For demo purposes, if no server is available, we'll create a mock response
      if (selectedFile != null) {
        // Process file
        try {
          var uri = Uri.parse('http://127.0.0.1:8000/analyze/');
          var request = http.MultipartRequest('POST', uri);
          request.files.add(await http.MultipartFile.fromPath('file', selectedFile!.path));

          var response = await request.send();
          var responseBody = await response.stream.bytesToString();

          if (response.statusCode == 200) {
            final data = json.decode(responseBody);
            navigateToResultPage(data);
          } else {
            // If server fails, still show demo result
            _showDemoResult();
          }
        } catch (e) {
          // If error occurs, show demo result
          _showDemoResult();
        }
      } else {
        // Process text input
        try {
          var uri = Uri.parse('http://127.0.0.1:8000/analyze/');
          var request = http.MultipartRequest('POST', uri);
          request.fields['text'] = _textController.text;

          var response = await request.send();
          var responseBody = await response.stream.bytesToString();

          if (response.statusCode == 200) {
            final data = json.decode(responseBody);
            navigateToResultPage(data);
          } else {
            // If server fails, still show demo result
            _showDemoResult();
          }
        } catch (e) {
          // If error occurs, show demo result
          _showDemoResult();
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showDemoResult() {
    // Create a mock result for demonstration
    final demoData = {
      'sentiment': _textController.text.contains('good') ? 'Positive' : 'Neutral',
      'positive_score': _textController.text.contains('good') ? 0.75 : 0.25,
      'neutral_score': _textController.text.contains('good') ? 0.20 : 0.65,
      'negative_score': _textController.text.contains('good') ? 0.05 : 0.10,
      'text': _textController.text.isEmpty ? 'Sample file content' : _textController.text,
      'review_count': 1,
      'distribution': null,
    };

    navigateToResultPage(demoData);
  }

  void navigateToResultPage(dynamic data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          sentiment: data['sentiment'] ?? 'Unknown',
          positiveScore: data['positive_score'] ?? 0.0,
          neutralScore: data['neutral_score'] ?? 0.0,
          negativeScore: data['negative_score'] ?? 0.0,
          reviewText: data['text'] ?? '',
          reviewCount: data['review_count'],
          distribution: data['distribution'],
        ),
      ),
    );
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6DFD8), // Light brown/beige color like in screenshot
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "HELLO!!  Welcome",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Glad to have you here. I hope you're doing well!!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "To provide a comprehensive and tailored analysis, please share your product review. Once I have access to your feedback, I can utilize advanced techniques to extract valuable insights, identify sentiment trends and categorize them into 'POSITIVE', 'NEUTRAL', and 'NEGATIVE' categories.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Visibility(
                visible: _showTextBox,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    focusNode: _textFocusNode,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter your review here...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      // Clear selected file when text is entered
                      if (value.isNotEmpty && selectedFile != null) {
                        setState(() {
                          selectedFile = null;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Show text field and set focus to it
                      setState(() {
                        _showTextBox = true;
                        selectedFile = null;
                      });

                      // Use a post-frame callback to ensure the widget is built before focusing
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        FocusScope.of(context).requestFocus(_textFocusNode);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF664B46), // Brown color from screenshot
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Enter Text"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: pickFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF664B46), // Brown color from screenshot
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Import File"),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (selectedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Selected: ${selectedFile!.path.split('/').last}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: isLoading ? null : analyzeData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF664B46), // Brown color from screenshot
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(120, 50),
                ),
                child: isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
                    : const Text(
                  "Analyze",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}