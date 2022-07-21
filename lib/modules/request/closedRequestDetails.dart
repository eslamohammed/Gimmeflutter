// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors


import 'package:flutter/material.dart';
import 'package:gimme/modules/Google_maps/googleMap.dart';
import 'package:gimme/main.dart';

import 'package:gimme/pages/qr/qr_create_page.dart';
import 'package:gimme/pages/qr/qr_scan_page.dart';


import 'package:gimme/shared/global_library.dart' as globals;


class ClosedRequestDetails extends StatefulWidget {
  final body;
  final title;
  final reqID;
  final timerange;
  final minPr;
  final maxPr;
  final timeUnit;
  final fromAddress;
  final toAddress;
  final requesterID;
  final mod;
  ClosedRequestDetails(
    this.body,
    this.title,
    this.reqID,
    this.timerange,
    this.minPr,
    this.maxPr,
    this.timeUnit,
    this.fromAddress,
    this.toAddress,
    this.requesterID,
    this.mod
  ); // this.id,this.timerange,this.minPr,this.maxPr/* this.from ,this.to*/ );

  @override
  ClosedRequestDetailsState createState() => ClosedRequestDetailsState();
}

class ClosedRequestDetailsState extends State<ClosedRequestDetails> {
  @override
  void initState() {
    GoogleMapsState().build(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return closedRequestDetails(
      context,
      widget.body,
      widget.title,
      widget.reqID,
      widget.timerange,
      widget.minPr,
      widget.maxPr,
      widget.timeUnit,
      widget.fromAddress,
      widget.toAddress,
      widget.requesterID,
    );
  }

  Widget closedRequestDetails(
    BuildContext context,
    String body,
    String title,
    String reqID,
    dynamic timerange,
    dynamic minPr,
    dynamic maxPr,
    dynamic timeUnit,
    dynamic fromAddress,
    dynamic toAddress,
    String requesterID,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Closed Request',
          style: TextStyle(
          color: Colors.black, fontSize: 45, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 65,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => {},
              //()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(

              style: TextButton.styleFrom(
                  primary: primaryColor,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text("Edit", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: TextButton(
            child: const Text("Back", style: TextStyle(
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
      body: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
        ),
        elevation: 6,
        margin: const EdgeInsets.all(11),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(///just for UI
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              
              Container(//title & price
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: Row(//title & price Box
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(//title
                        decoration: const BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.56,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${title} ",
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ), //waiting for API data
                      ),
                      Container(//just for UI
                        decoration: const BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.025,
                      ),
                      SizedBox(//price
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextButton(
                          child: Text(
                            "price range:           \n[ ${minPr} - ${maxPr} ] EGP ",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          //Icon(Icons.ac_unit_sharp), // city name from location
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: primaryColor),
                            ),
                          )),
                        ),
                      ),
                      Container(//just for UI
                        decoration: const BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              
              const Padding( //just for UI
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: primaryColor,
                ),
              ),
              
              Container(//body
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.125,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.67,
                  //Text( "//  {reqBody}  ",style: TextStyle(fontSize: 25, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "//  ${body}  ",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ), //waiting for API data
                ),
              ),
              
              const Padding(//divider
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: primaryColor,
                ),
              ),
              
              Container(//time
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: Container(//time
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: Row(//time
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(//word time
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.615,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Time : ",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ), //waiting for API data,
                        ),
                      ),
                      Container(//Just for UI
                        decoration: const BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      SizedBox(//timerange
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: TextButton(
                          child: Text(
                            "$timerange\t\t[$timeUnit] ",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          //Icon(Icons.ac_unit_sharp), // city name from location
                          onPressed: () {
                            print(reqID);
                          },
                          style: ButtonStyle(
                              //maximumSize: Size.infinite,
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: primaryColor),
                            ),
                          )),
                        ),
                      ),
                      Container(//Just for UI
                        decoration: const BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              
              const Padding(//Just for UI
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: primaryColor,
                ),
              ),
              
              Container(//location
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(//Location word
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "  Location ",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ), //waiting for API data
                    
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextButton(
                            child: Text(
                              "From:\n$fromAddress",
                              style: const TextStyle(
                                fontSize: 17.5,
                                color: primaryColor,
                              ),
                            ), // city name from location
                            onPressed: () async {
                              print("==============");
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: primaryColor),
                              ),
                            )),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextButton(
                            child: Text(
                              "To:\n$toAddress",
                              style: const TextStyle(
                                fontSize: 17.5,
                                color: primaryColor,
                              ),
                            ), // city name from location
                            onPressed: () async {
                              print("==============");
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0),
                                side: const BorderSide(color: primaryColor),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Container( //Release Payment
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(//release Payment
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextButton(
                        child: const Text("Release Payment",  style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.5,
                            color: primaryColor,
                          ),
                        ),
                        onPressed: () => {
                          /// release payment method
                          print(widget.requesterID),
                          print(globals.getUserID()),
                          print("here is mod : ${widget.mod}"),
                          print("here is request id : ${widget.reqID}"),
                          widget.requesterID == globals.getUserID() ?
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanPage(widget.reqID,widget.mod)))
                          : Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCreatePage(widget.reqID,widget.mod)))
                        /*    Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCreatePage(widget.reqID,widget.mod)))
                          : Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanPage(widget.reqID,widget.mod)))
                        */
                          },
                        style: ButtonStyle(//maximumSize: Size.infinite,
                            shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                            side: const BorderSide(
                              color: primaryColor,
                              ),
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
/*      floatingActionButton: FloatingActionButton(
        //delete function
        //calling delete function to delete request
        onPressed: () =>DeleteRequest().deleteRequest(context, reqID), //sending object id to be deleted
        heroTag: "$reqID",
        child: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
        backgroundColor: primaryColor,
      ),*/
    );
  }
}
