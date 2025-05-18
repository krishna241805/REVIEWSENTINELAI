import 'package:flutter/material.dart';

class Textfiled extends StatefulWidget {
  final String label;
  final bool obscureText;
  final bool isPassword;

  const Textfiled(
      this.label, {
        super.key,
        this.obscureText = false,
        this.isPassword = false,
      });

  @override
  _TextfiledState createState() => _TextfiledState();
}

class _TextfiledState extends State<Textfiled> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: widget.isPassword ? !_isPasswordVisible : widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.brown, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.brown, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.brown, width: 1),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.brown,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${widget.label}';
          }
          return null;
        },
      ),
    );
  }
}