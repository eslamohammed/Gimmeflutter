import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:gimme/modules/Search/SearchRequestDetails.dart';
import 'package:gimme/Api/fetchAccountsData.dart';
import 'package:gimme/pages/profiles/otherProfilesPage.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;


class RequestResultCard extends StatelessWidget {
   RequestResultCard(
     //{ Key? key }
     this.reqBody,
     this.reqTitle,
     this.reqID,
     this.reqtimerange,
     this.reqminPrice,
     this.reqmaxPrice,
     this.fromAddress,
     this.toAddress,
     this.requesterID,
     this.reqtimeunit, 
     this.state,{Key? key}
     ) : super(key: key);

  final FetchAccounts _fetchOthersAccount = FetchAccounts();
  final  String reqBody;
  final  String reqTitle;
  final  String reqID;
  final  dynamic reqtimerange;
  final  dynamic reqminPrice;
  final  dynamic reqmaxPrice;
  final  dynamic fromAddress;
  final  dynamic toAddress;
  final  dynamic requesterID;
  final  dynamic reqtimeunit;
  final  String state ;
  @override
  Widget build(BuildContext context) {
    return reqResultCard(
      context,
      reqBody,
      reqTitle,
      reqID,
      reqtimerange,
      reqminPrice,
      reqmaxPrice,
      fromAddress,
      toAddress,
      requesterID,
      reqtimeunit
      );
  }

Widget reqResultCard(
    BuildContext context,
    String reqBody,
    String reqTitle,
    String reqID,
    dynamic reqtimerange,
    dynamic reqminPrice,
    dynamic reqmaxPrice,
    dynamic fromAddress,
    dynamic toAddress,
    dynamic requesterID,
    dynamic reqtimeunit,
  ) {
    return InkWell(
      onTap: () => Navigator.push(context,MaterialPageRoute(
        builder: (context) => SearchRequestDetails(
          reqBody, reqTitle, reqID, reqtimerange, reqminPrice, reqmaxPrice, reqtimeunit,requesterID, state),
          ),
        ),
      child: FutureBuilder(
        future: _fetchOthersAccount.fetchOthersAccount(requesterID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            http.Response res = snapshot.data as http.Response;
            var body = jsonDecode(res.body());
            //print(body);
            print("Done..");
            if (body["status"] == true) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(
                      backgroundColor: primaryColor,
                    ),
                  );

                case ConnectionState.none:
                  return const Center(
                    child: Text("Error in connection"),
                  );

                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: primaryColor,
                    ),
                  );

                case ConnectionState.done:
                  return Card(
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
                            height: MediaQuery.of(context).size.height * 0.21,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, top: 15),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(Config.ImageURL),
                                      ),
                                    ),
                                    SizedBox(
                                      height:MediaQuery.of(context).size.height *0.005,
                                    ),
                                    RichText(
                                      //username
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(///making Username routalbe ///navigating to user page
                                            text:"\t\t${body['data']['name']} ", //Show user name
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              //decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // route to this Othor accounts page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OthersProfilePages(
                                                      ///User infos
                                                      ///The data comming from API
                                                      body['data']['name'],
                                                      "4.7",
                                                      body['data']['isTrusted'],
                                                      body['data']['createTime'],
                                                    ),
                                                  ),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                Padding(
                                  //*** title && body
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    //*** title && body
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: MediaQuery.of(context).size.height *0.2,
                                    width: MediaQuery.of(context).size.width *0.66,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          //title
                                          Text(
                                            "#$reqTitle ",
                                            style: const TextStyle(
                                                fontSize: 33,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ), //waiting for API data
                                          const Divider(
                                            color: primaryColor,
                                          ),
                                          //body
                                          Text(
                                            "$reqBody  ",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                            decoration:const BoxDecoration(color: Colors.white),
                            height: MediaQuery.of(context).size.height * 0.075,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(//just for UI
                                  width:MediaQuery.of(context).size.width * 0.15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: MediaQuery.of(context).size.height*0.1,
                                    width: MediaQuery.of(context).size.width*0.75,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height *0.06,
                                          width: MediaQuery.of(context).size.width *0.35,
                                          child: TextButton(
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Center(
                                                  child: Text(
                                                  fromAddress,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width *
                                                      0.001,
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward,
                                                  color: primaryColor,
                                                ),
                                              ],
                                            ), //Icon(Icons.ac_unit_sharp), // city name from location
                                            onPressed: () {
                                              debugPrint(
                                                  prefs.getString("token") as String
                                              );
                                            },
                                            style: ButtonStyle(
                                                //maximumSize: Size.infinite,
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17.0),
                                                side: const BorderSide(
                                                    color: primaryColor),
                                              ),
                                            )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.06,
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: TextButton(
                                            child: Text(
                                              toAddress,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: primaryColor,
                                              ),
                                            ), // city name from location
                                            onPressed: () async {},
                                            style: ButtonStyle(
                                              shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:BorderRadius.circular(17.0),
                                                side: const BorderSide(color: primaryColor),
                                              ),
                                            ),
                                          ),
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
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        },
      ),
    );
  
  }


}

