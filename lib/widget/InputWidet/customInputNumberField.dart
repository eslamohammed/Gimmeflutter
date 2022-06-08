// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputNumberField extends StatelessWidget {
  const CustomInputNumberField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.labelText,
    this.icon,
  }) : super(key: key);
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10 ,right: 5,left: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(fontSize: 16),
          hintStyle: const TextStyle(fontSize: 17.5),
          //icon: Icon(icon)
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be insterted
      ),
    );
  }
}
