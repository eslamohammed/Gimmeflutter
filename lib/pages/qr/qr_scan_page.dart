import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimme/main.dart';
import 'package:gimme/shared/config.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:qr_code_scanner_example/widget/button_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrKey = GlobalKey(debugLabel: 'OR');

  Barcode? barcode;  
  QRViewController? controller;
  
//  String qrCode = 'Unknown';
  @override 
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble()async{

    super.reassemble();

    if (Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: primaryColor,
          title: Text(Config.appName),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),

            Positioned(
              bottom: 10,
              child: buildResult(),            
            ),
            Positioned(
              top: 10,
              child: buildControlButtons(),            
            )
          ],
        )
      
      /*  
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Scan Result',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$qrCode',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 72),
              ButtonWidget(
                text: 'Start QR scan',
                onClicked: () => scanQRCode(),
              ),
            ],
          ),
        ),
      */
    ),
  );

  Widget buildControlButtons() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () async {
            await controller?.toggleFlash();
            setState(() {
              
            });
          }, 
          icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: ( context , snapshot ){
              if (snapshot.data !=null) {
                return  Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
              } else {
                return  Container();
              }
            },
           ),
        ),
        IconButton(
          onPressed: () async {
            await controller?.flipCamera();
            setState(() {
              
            });
          }, 
          icon:FutureBuilder(
            future: controller?.getCameraInfo(),
            builder: ( context , snapshot ){
              if (snapshot.data !=null) {
                return Icon(Icons.switch_camera);
              } else {
                return  Container();
              }
            },
           ), 
          //Icon(Icons.switch_camera), 
        ),
      ],
    ),
  );

  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Text(
      barcode != null ? 'Result : ${barcode!.code}' : 'Scan a Code!',
      maxLines: 3,
    ),
  ); 
  
  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderWidth: 10,
      borderLength: 20,
      borderRadius: 10,
      borderColor: primaryColor,
      cutOutSize: MediaQuery.of(context).size.width*0.8,

    ),
  
  );

  void  onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) => setState(()=> this.barcode = barcode));
  }

/*
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
*/

}
