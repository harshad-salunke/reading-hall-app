import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
final FocusNode focusNode;
final isenalble;
  const NumberField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.focusNode,
     this.isenalble=true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.number,
        maxLength: 10,
        focusNode: focusNode,
        enabled:isenalble ,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,

            prefixIcon: Icon(Icons.add_call),
            prefixText: "+91",
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}