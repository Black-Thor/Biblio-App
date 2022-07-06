import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  TextEditingController controller;

  PasswordTextField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_isVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            icon: Icon(
              _isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            )),
        border: InputBorder.none,
        hintText: 'Password',
      ),
    );
  }
}
