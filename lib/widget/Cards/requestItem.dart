
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gimme/Api/request/deleteRequest.dart';
import 'package:gimme/main.dart';
import 'package:gimme/pages/profiles/profilePage.dart';
import 'package:gimme/modules/request/requestDetails.dart';

import 'package:gimme/shared/config.dart';
import 'package:gimme/widget/Alertdialog/alertDialog.dart';

class RequestItem extends StatelessWidget {
  final index;
  final reqbody;
  final reqtitle;
  final reqid;
  final reqtimeRange;
  final reqMinPrice;
  final reqMaxPrice;
  final unit;
  final from;
  final to;
  final requesterID;

  final userName;
  RequestItem(
    this.index,
    this.reqbody,
    this.reqtitle,
    this.reqid,
    this.reqtimeRange,
    this.reqMinPrice,
    this.reqMaxPrice,
    this.unit,
    this.from,
    this.to,
    this.requesterID,

    this.userName
  );

  @override
  Widget build(BuildContext context) {
    return _requestCard(
      context,
      index,
      reqbody,
      reqtitle,
      reqid,
      reqtimeRange,
      reqMinPrice,
      reqMaxPrice,
      unit,
      from,
      to,
      requesterID,

      userName
    );
  }

  Widget _requestCard(
    BuildContext context,
    int index,
    String reqBody,
    String reqTitle,
    String reqID,
    dynamic reqtimerange,
    dynamic reqminPrice,
    dynamic reqmaxPrice,
    dynamic timeUnits,
    dynamic fromAddress,
    dynamic toAddress,
    String requesterID,

    dynamic username,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RequestDetails(
              index,
              reqBody,
              reqTitle,
              reqID,
              reqtimerange,
              reqminPrice,
              reqmaxPrice,
              timeUnits,
              fromAddress,
              toAddress,
              requesterID,
            ),
         ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
        ),
        elevation: 6,
        margin: const EdgeInsets.all(11),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Padding(//Profile image
                            padding: EdgeInsets.only(left: 8.0, top: 15),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(Config.ImageURL),
                            ),
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*0.005,),
                          RichText(//username
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "\t\t$username",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // route to this account page
                                        //  Navigator.pushNamed(context, "/login");
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>ProfilePages(),),);
                                      }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Padding( //photo
                      padding: const EdgeInsets.only(top: 8 , left: 8 ,bottom: 8),
                      child:Container(//profile photo
                      width: MediaQuery.of(context).size.height*0.065,
                      height: MediaQuery.of(context).size.height*0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        image: DecorationImage(image: NetworkImage(Config.ImageURL,),
                        )
                      ),
                    ),
                        /*Container(/// Image if exist
                        decoration: BoxDecoration(color:Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2, 
                        child: Image.asset("assets/gimmeMoblieApp.png", //here we receive an image from API instead this ***Logo
                          width: 250,
                          fit: BoxFit.contain,),
                      ),*/
                    ),*/
                    Padding(///title && body
                      padding: const EdgeInsets.all(8.0),
                      child: Container(/// title && body
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.73,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title
                              Text(
                                "#${reqTitle} ",
                                style: TextStyle(
                                    fontSize: 33,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ), //waiting for API data
                              const Divider(
                                color: primaryColor,
                              ),
                              //body
                              Text(
                                "//  ${reqBody}  ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ), //waiting for API data
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(///deleteRequest
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          heroTag: "btn$index",
                          backgroundColor: primaryColor,
                          onPressed: () {
                            AlertDialogWidget.alartDialog(
                              context,
                              "Delete ?",
                              ()=>{
                                 //sending id of of request to be deleted
                                DeleteRequest().deleteRequest(context,reqID),
                                Navigator.pop(context),
                              },
                              ()=>{
                                Navigator.pop(context),
                              },
                            );
                          }),
                    ),
                    /* Padding(//just for margin
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color:Colors.white,
                        borderRadius: BorderRadius.circular(10),),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.25,
                      ),
                    ),*/
                    Padding(//from & to address
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(//from
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextButton(
                                child: Text(
                                  "From: ${fromAddress} ",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: primaryColor,
                                  ),
                                ), //Icon(Icons.ac_unit_sharp), // city name from location
                                onPressed: () {
                                  debugPrint(
                                      prefs.getString("token") as String);
                                },
                                style: ButtonStyle(
                                    //maximumSize: Size.infinite,
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                    side: const BorderSide(color: primaryColor),
                                  ),
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(//to
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextButton(
                                child: Text(
                                  "To: $toAddress",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: primaryColor,
                                  ),
                                ), // city name from location
                                onPressed: () async {
                                  print("here");
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
