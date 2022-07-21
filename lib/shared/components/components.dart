import 'package:flutter/material.dart';

/////////////////////////////////////////// DEFAULT BUTTON ////////////////////////////////
Widget defaultBtn({
  double width = double.infinity,
  double hight = 40.0,
  double radius = 3.0,
  bool upperCase = true,
  Color background = Colors.blue,
  required VoidCallback  function,
  required String text,
}) =>
    Container(
        width: width,
        height: hight,
        child: MaterialButton(
          onPressed: function,
          child: Text(
            upperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
        );

/////////////////////////////////////////// DEFAULT BUTTON ////////////////////////////////
/////////////////////////////////////////// DEFAULT TEXT FORM FIELD ////////////////////////////////
Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  required   final String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function(String)? change, 
  Function(String)? submit,
  Function()? onTap,
  Function()? suffixPressed,
  bool isClickable = true,
  bool isPassword = false,
}) => 
TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: submit,
      onChanged: change,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
)
);
/////////////////////////////////////////// DEFAULT TEXT FORM FIELD ////////////////////////////////
/////////////////////////////////////////// Task Component ////////////////////////////////
Widget Task(Map model){
   return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 40,
            child: Text('${model["time"]}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Text(
                '${model["title"]}',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${model["date"]}',
                style: const TextStyle(color:Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
}
/////////////////////////////////////////// Task Component ////////////////////////////////
