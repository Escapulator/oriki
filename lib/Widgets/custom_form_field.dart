import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeHolder;
  final TextEditingController controller;
  final String validationMessage;
  const CustomTextField(
      {Key? key,
      required this.placeHolder,
      required this.controller,
      required this.validationMessage})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        return value!.isEmpty ? widget.validationMessage : null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        hintText: widget.placeHolder,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
