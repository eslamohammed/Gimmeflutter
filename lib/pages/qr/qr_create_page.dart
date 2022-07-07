import 'package:flutter/material.dart';
import 'package:gimme/main.dart';
import 'package:gimme/shared/config.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCreatePage extends StatefulWidget {
  @override
  _QRCreatePageState createState() => _QRCreatePageState();
}

class _QRCreatePageState extends State<QRCreatePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      toolbarHeight: 60,
      backgroundColor: primaryColor,
      title: Text(Config.appName),
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
                data: controller.text,
                size: 200,
                backgroundColor: Colors.white,
              ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(child: buildTextField(context)),
                const SizedBox(width: 12),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.done, size: 30),
                  onPressed: () => setState(() {}),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );

Widget buildTextField(BuildContext context) => TextField(
    controller: controller,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the data',
      hintStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      suffixIcon: IconButton(
        onPressed: ()=> setState(()=>{}),
        icon: Icon(Icons.done,size: 30,),
      ),
    ),
  );
}
