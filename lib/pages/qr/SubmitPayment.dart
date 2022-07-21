
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gimme/Api/payment/releasePayment.dart';
import 'package:gimme/main.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/widget/Alertdialog/alertDialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

// ignore: must_be_immutable
class SubmitPayment extends StatelessWidget {
    Barcode? barcode;  
      final reqId;
      final mod;

   SubmitPayment(
    this.barcode,
    this.reqId,
    this.mod,
    {
      Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _submitRelease(context);
  }


  Widget _submitRelease(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Release Payment',
            style: TextStyle(
                color: Colors.black, fontSize: 45, fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 65,
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => {}, //route to edit page,
                //()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(

                style: TextButton.styleFrom(
                    primary: primaryColor,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: Text("Edit", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: TextButton(
              child:  Text("Back", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: primaryColor,
                ),
              ), //Icon(Icons.ac_unit_sharp), // city name from location
              ///here it will change .close
              onPressed: () => Navigator.pop(context),
              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeControllerPage(),),),
                  ),
                ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [  
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" Scan Code result : ",
                style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                barcode != null ? '${barcode!.code}' : 'Please Return to Scan a Code!',
                maxLines: 3,
                style: TextStyle(fontSize: 20 ,backgroundColor: primaryColor),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" Request ID : ",
                style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                "[${reqId}]",
                maxLines: 3,
                style: TextStyle(fontSize: 20 ,backgroundColor: primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.4,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.1,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Center(//Edit button & calling editrequest() Function function;
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () async {//Calling releasr payment() method
                      // 5 == 5 ? _releasePayment(context, reqId) : print("false");   
                      //
                      //_releasePayment(context, reqId)   
                       barcode!.code == mod ? 
                       AlertDialogWidget.alartDialog(
                        context,
                        "Successful: Release Payment?",
                        ()=>{
                          ReleasePayment().releasePayment(context, reqId),
                          print("done"),
                          print(reqId)

                        },
                        ()=>{
                          print("Not Done.."),
                          Navigator.pop(context),
                        },
                      ) : FormHelper.showSimpleAlertDialog(
                        context,
                        "${Config.appName} : [${barcode!.code}]",
                        "Woring Code : Please try again",
                        "Ok",
                        () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        ///routing url to open in AddReview page
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => AddReview(),),);
                        },
                      );
                    },
                    child: Padding(//submit
                      padding: const EdgeInsets.all(12.5),
                      child: Center(
                        child: Text(
                          "Release Payment",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    color: primaryColor,
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ),
          ),

          
        ],
      )
    );
  }

  void _releasePayment (BuildContext context , String requestID){
    //if (bc == widget.code){
      AlertDialogWidget.alartDialog(
          context,
          "Successful: Release Payment?",
          ()=>{
            //ReleasePayment().releasePayment(context, requestID),
            print("done")
          },
          ()=>{
            print("Not Done.."),
            Navigator.pop(context),
          },
        );
    /*}else{
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Please try again",
        "Ok",
        () {
          Navigator.pop(context);
        ///routing url to open in AddReview page
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => AddReview(),),);
        },
      );
    }*/
  }


}