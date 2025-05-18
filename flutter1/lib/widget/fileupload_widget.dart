import 'package:flutter/material.dart';

class FileUpload extends StatelessWidget {
  const FileUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Text(
          'File Upload Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
