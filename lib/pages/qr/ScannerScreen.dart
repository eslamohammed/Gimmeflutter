import 'package:flutter/material.dart';
import 'package:gimme/pages/qr/readqr.dart';
import 'package:gimme/pages/qr/scanqr.dart';

class ScannerScreen extends StatefulWidget {
  ScannerScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>CreateScreen()));
                  print('creating qr code');
                },
                child: Text('create QR code')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ScanScreen()));
                  print('Read qr code');
                },
                child: Text('Read QR code')),
          ],
        ),
      ),
    );
  }
}
