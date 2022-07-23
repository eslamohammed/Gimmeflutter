import 'package:flutter/material.dart';

import 'package:gimme/Api/payment/releasePayment.dart';
import 'package:gimme/pages/qr/qr_scan_page.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QRCreatePage extends StatefulWidget {
  const QRCreatePage( this.reqId , this.mod);
  
  final reqId ;  
  final mod ;
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
            const Center(child: Text("Scan To release :",style:  TextStyle(fontSize: 50, color: Colors.black,fontWeight: FontWeight.bold))),

            SizedBox(height: MediaQuery.of(context).size.height*0.07),
            QrImage(
                data: widget.mod,
                size: 300,
                backgroundColor: Colors.white,
              ),
            SizedBox(height: 40),
/*          FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.done, size: 30),
                  onPressed: () => print(widget.code),
                ),
         

            SizedBox(height: 40),
*/
          Text("Just for test, It will be removed later" , style: TextStyle(color: Colors.black,fontSize: 30),),
          FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.done, size: 30),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanPage(widget.reqId,widget.mod))),
                ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: (){
             ReleasePayment().releasePayment(context, widget.reqId);
                          print("${widget.reqId}");
          }, child: Text("Test release payment"))

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
