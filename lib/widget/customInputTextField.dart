// ignore_for_file: file_names
import 'package:flutter/material.dart';

class CustomInputTextFieldWidget extends StatelessWidget {
  const CustomInputTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.secure,
    required this.ccontroller,
    this.icon,
  }) : super(key: key);
  final String hintText;
  final bool secure;
  final TextEditingController ccontroller;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: ccontroller,
        obscureText: secure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 17.5),
          //icon: new Icon(icon)
        ),
      ),
    );
  }
}
