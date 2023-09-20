// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  String hintText;
  int maxLengh;
  double width;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.maxLengh,
    required this.width,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFielState();
}

class _CustomTextFielState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        controller: widget.controller,
        maxLength: widget.maxLengh,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(60),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(60),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
