import 'package:flutter/material.dart';
import 'package:flutter1/widget/app_bar.dart';
import 'package:pie_chart/pie_chart.dart';


class ResultPage extends StatefulWidget {
  final String sentiment;
  final double positiveScore;
  final double neutralScore;
  final double negativeScore;
  final String reviewText;
  final int? reviewCount;
  final Map<String, dynamic>? distribution;

  const ResultPage({
    Key? key,
    required this.sentiment,
    required this.positiveScore,
    required this.neutralScore,
    required this.negativeScore,
    required this.reviewText,
    this.reviewCount,
    this.distribution,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Analysis Results",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (widget.reviewCount != null && widget.reviewCount! > 1) ...[
                  Text(
                    "Batch Analysis Results (${widget.reviewCount!} reviews)",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.distribution != null) ...[
                    _buildDistributionInfo(),
                  ],
                ] else ...[
                  Text(
                    "Overall Sentiment: ${widget.sentiment}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getSentimentColor(widget.sentiment),
                    ),
                  ),
                ],

                const SizedBox(height: 30),
                const Text(
                  "Sentiment Scores:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Pie Chart with significantly reduced size (15%)
                PieChart(
                  dataMap: {
                    "Positive": widget.positiveScore,
                    "Neutral": widget.neutralScore,
                    "Negative": widget.negativeScore,
                  },
                  colorList: [Colors.green, Colors.amber, Colors.red],
                  chartType: ChartType.disc,
                  // 15% of screen width
                  chartRadius: MediaQuery.of(context).size.width * 0.15,
                  legendOptions: const LegendOptions(
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    legendTextStyle: TextStyle(fontSize: 14),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    chartValueStyle: TextStyle(fontSize: 12),
                  ),
                ),

                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Back to Upload",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDistributionInfo() {
    final total = widget.distribution!['Positive'] + widget.distribution!['Neutral'] + widget.distribution!['Negative'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Distribution:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildDistributionRow('Positive', widget.distribution!['Positive'], total),
        _buildDistributionRow('Neutral', widget.distribution!['Neutral'], total),
        _buildDistributionRow('Negative', widget.distribution!['Negative'], total),
      ],
    );
  }

  Widget _buildDistributionRow(String label, int count, int total) {
    final percentage = (count / total * 100).toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            "$count ($percentage%)",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case 'Positive':
        return Colors.green;
      case 'Neutral':
        return Colors.amber;
      case 'Negative':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}