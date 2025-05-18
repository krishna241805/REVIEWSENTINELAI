import 'package:flutter/material.dart';
class InfoBox extends StatelessWidget {
  final Color color;
  final String title;
  final String content;

  const InfoBox({super.key, required this.color, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
