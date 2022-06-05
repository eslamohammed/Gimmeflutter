// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gimme/main.dart';

class CustomInputTextFieldWidget extends StatelessWidget {
  const CustomInputTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.secure,
    required this.ccontroller,
    this.icon,
    this.fillColor,
  }) : super(key: key);
  final String hintText;
  final bool secure;
  final TextEditingController ccontroller;
  final IconData? icon;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        controller: ccontroller,
        obscureText: secure,
        decoration: InputDecoration(
          fillColor: fillColor == null ? fillColors : fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 19),
          //icon: new Icon(icon)
        ),
      ),
    );
  }
}
