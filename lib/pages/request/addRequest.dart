// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors
import 'package:flutter/material.dart';

import 'package:gimme/sharedPrefrances/sharedPrefsReqID.dart';

import 'package:gimme/widget/customInputTextField.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:gimme/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gimme/utilies/global_library.dart' as globals;

import 'package:gimme/main.dart';
import 'package:gimme/pages/HomeController.dart';


class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _bodyTextEditingController =
      TextEditingController();

  final TextEditingController _minPricreTextEditingController =
      TextEditingController();
  final TextEditingController _maxPricreTextEditingController =
      TextEditingController();
  final TextEditingController _timeRangeTextEditingController =
      TextEditingController();
  final TextEditingController _timeUnitsTextEditingController =
      TextEditingController();
  final TextEditingController _fromAddressTextEditingController =
      TextEditingController();
  final TextEditingController _toAddressTextEditingController =
      TextEditingController();

  //double ? _minDropDownValue; //value of price
  //double ? _mintimeDropDownValue; //value of price

  @override
  void dispose() {
    _bodyTextEditingController.dispose();
    _titleTextEditingController.dispose();
    _minPricreTextEditingController.dispose();
    _maxPricreTextEditingController.dispose();
    _timeRangeTextEditingController.dispose();
    _timeUnitsTextEditingController.dispose();
    _fromAddressTextEditingController.dispose();
    _toAddressTextEditingController.dispose();
    //_maxTimeTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'Add Request',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          backgroundColor: primaryColor,
          elevation: 1,
          centerTitle: true,
        ),
        body: _addRequestUI(context));
  }

  ///UI
  Widget _addRequestUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(// Need Something && title && body
            padding: const EdgeInsets.only(right: 10, left: 10),

            child: Container(
              //
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(//Need Something field
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Need Something..!!! , Put here",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(//title
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("#E5E5E5"),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )

                              /// contin
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomInputTextFieldWidget(
                              hintText: "title",
                              secure: false,
                              ccontroller: _titleTextEditingController,
                              icon: Icons.update,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(//body
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("#E5E5E5"),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )

                              /// contin
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomInputTextFieldWidget(
                              hintText: "body",
                              secure: false,
                              ccontroller: _bodyTextEditingController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),

          Padding(//price range
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 10,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //Choose the delivery price.
                      width: MediaQuery.of(context).size.width /
                          2.7, //**delivery price Word width**
                      decoration: const BoxDecoration(
                        //from-to box decoration
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "the delivery price range...",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    //function implementaion min & max must be int
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    SizedBox(
                      // price min
                      width: MediaQuery.of(context).size.width /
                          5, //** price width it self **
                      child: Padding(
                        //min
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("#E5E5E5"),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )

                              /// contin...
                              ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 9),
                            child: CustomInputTextFieldWidget(
                              hintText: "min",
                              secure: false,
                              ccontroller: _minPricreTextEditingController,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      // price max
                      width: MediaQuery.of(context).size.width /
                          5, //** price width it self **
                      child: Padding(
                        //max
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("#E5E5E5"),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )

                              /// contin
                              ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 9),
                            child: CustomInputTextFieldWidget(
                              hintText: "max",
                              secure: false,
                              ccontroller: _maxPricreTextEditingController,
                            ),
                          ),
                        ),
                      ),
                    ),

/*
      Container( // price DropdownButton
       width: MediaQuery.of(context).size.width/3,
       decoration: BoxDecoration(            
         borderRadius: BorderRadius.circular(50),
         color: primaryColor,         
       ),
      
       child: DropdownButton(items: [
       DropdownMenuItem<double>(child: Text("  20.0 LE"),value: 20.0, ),
       DropdownMenuItem<double>(child: Text("  35.0 LE"),value: 35.0, ),
       DropdownMenuItem<double>(child: Text("  50.0 LE"),value: 50.0, ),
       DropdownMenuItem<double>(child: Text("  70.0 LE"),value: 70.0, ),
       DropdownMenuItem<double>(child: Text("  90.0 LE"),value: 90.0, ),
      ],
        value: _minDropDownValue,
        onChanged: minDropDownCallback,
        iconSize: 20.0,
        iconEnabledColor: Colors.white,
        iconDisabledColor: primaryColor,
        focusColor: primaryColor,
        icon: const Icon(Icons.attach_money_sharp),
        dropdownColor: primaryColor,
        borderRadius: BorderRadius.circular(30),
        isExpanded: true,
        style: TextStyle(color: Colors.white  , fontSize:15 ),
        ),
      ),            
    */
                  ],
                ),
              ),
            ),
          ),

          Padding(// Time range
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 10,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //Choose the delivery price.
                      width: MediaQuery.of(context).size.width /
                          2.7, //**delivery price Word width**
                      decoration: const BoxDecoration(
                        //from-to box decoration
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Delivery Time range...",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    SizedBox(
                      // time
                      width: MediaQuery.of(context).size.width /
                          4, //** price width it self **
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#E5E5E5"),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 9),
                              child: CustomInputTextFieldWidget(
                                hintText: "Time in hour",
                                secure: false,
                                ccontroller: _timeRangeTextEditingController,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      // time unit
                      width: MediaQuery.of(context).size.width /
                          6.5, //** price width it self **
                      child: Padding(
                        //max
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("#E5E5E5"),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )

                              /// contin
                              ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 9),
                            child: CustomInputTextFieldWidget(
                              hintText: "unit",
                              secure: false,
                              ccontroller: _timeUnitsTextEditingController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// now putting address manually until gitting googlePlaces key
          /// it just replaced with address comes from google instead inserttimg it manually
          
          SizedBox( //address from
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: HexColor("#E5E5E5"),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    )

                    /// contin
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomInputTextFieldWidget(
                    hintText:
                        "From address   it will replaced by google places data",
                    secure: false,
                    ccontroller: _fromAddressTextEditingController,
                    icon: Icons.update,
                  ),
                ),
              ),
            ),
          ),

          SizedBox( //address to
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: HexColor("#E5E5E5"),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    )

                    /// contin
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomInputTextFieldWidget(
                    hintText:
                        "To address\t\t\t\t\t\t\t\t\tit will replaced by google places data",
                    secure: false,
                    ccontroller: _toAddressTextEditingController,
                  ),
                ),
              ),
            ),
          ),

          /// end of UI address never forgett to git me key

          Container( //Location
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.9,

            child: TextButton(
              onPressed: () async {
                //navigation to GoogleMaps to place marker
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeControllerPage()));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Center(
                    child: Text(
                  "\t\t\t\t\t\t Select Location \n\nHint \n\nclick select Loctations [Source{from} & distination{to}] Points[Loc-Coordinantes'GoogleMaps'] Homepage Bar\n\nIf you if you are already here Just ignore this step ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                )),
              ),
            ),
            color: primaryColor,
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          Padding( // add request
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 10,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Center(
                //Add request button & calling Addrequest() Function function;
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () async {
                      //Calling AddRequest() function

                      if (_titleTextEditingController.text.isNotEmpty) {
                        if (_bodyTextEditingController.text.isNotEmpty) {
                          if (_minPricreTextEditingController.text.isNotEmpty &&
                              _maxPricreTextEditingController.text.isNotEmpty) {
                            if (_timeRangeTextEditingController
                                .text.isNotEmpty) {
                              if (globals.fromLat != null &&
                                  globals.fromLong != null &&
                                  globals.toLat != null &&
                                  globals.toLong != null) {
                                _addRequest(); //function to add Request
                              } else {
                                FormHelper.showSimpleAlertDialog(
                                  //location
                                  context,
                                  Config.appName,
                                  "Set {From & To} markers on Google maps blow, uh baka!!",
                                  "OK",
                                  () {
                                    Navigator.pop(context);
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMaps()));
                                  },
                                );
                              }
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                //time
                                context,
                                Config.appName,
                                "Time[unit] in hour \nCheck inserted Time, press OK to try again",
                                "OK",
                                () {
                                  Navigator.pop(context);
                                },
                              );
                            }
                          } else {
                            FormHelper.showSimpleAlertDialog(
                              //price
                              context,
                              Config.appName,
                              "inserted worng data , price and try again",
                              "OK",
                              () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        } else {
                          FormHelper.showSimpleAlertDialog(
                            //body
                            context,
                            Config.appName,
                            "inserted worng data , body and try again",
                            "OK",
                            () {
                              Navigator.pop(context);
                              debugPrint("");
                            },
                          );
                        }
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          //all data
                          context,
                          Config.appName,
                          "Request data is required and can not be Empty press OK to try again",
                          "OK",
                          () {
                            Navigator.pop(context);
                            debugPrint("");
                          },
                        );
                      }
                    },
                    child: Padding(
                      //Add Request
                      padding: const EdgeInsets.all(12.5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Center(
                          child: Text(
                            "   Add Request",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    color: primaryColor,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        ],
      ),
    );
  }

  ///API
  Future _addRequest() async {
//  var header = {"Authorization":"Bearer "+"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjQ5YWJkNmQ4MzUzODMxZDI1Nzg5MmQiLCJpYXQiOjE2NDk2ODMxNTB9.4UZEwg4UvTHR6AIZ2KyHvtcDxwpPJpjFUVLO1WZrT2A"};//(prefs.getString("token") as String)};
    //var url = Uri.parse("http://192.168.1.4:8080/api/request/open"); //http://localhost:8080/api/request/open
    Map<String, String> header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String),
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    String bodii = json.encode({
      "title": _titleTextEditingController.text,
      "body": _bodyTextEditingController.text,
      "toAddress": _toAddressTextEditingController.text,
      "fromAddress": _fromAddressTextEditingController.text,
      "fromLocation": {
        "type": "Point",
        "coordinates": [globals.fromLat, globals.fromLong]
      },
      "toLocation": {
        "type": "Point",
        "coordinates": [globals.toLat, globals.toLong]
      },
      "priceRange": {
        "min": _minPricreTextEditingController.text,
        "max": _maxPricreTextEditingController.text
      },
      "timeRange": {
        "val": _timeRangeTextEditingController.text,
        "unit": _timeUnitsTextEditingController.text
      }
    });

    var url =
        Uri.parse(Config.apiURl + Config.requestAPI + Config.openRequestAPI);
    var response = await http.post(url, body: bodii, headers: header);
    // if condition to check if account already exited or created and if then send user to login page
    if (response.statusCode == 200) {
      print("success");
      debugPrint('Response body: ${response.body()}');
      debugPrint("=======================================");
      debugPrint('Response status: ${response.statusCode}');

      var body = jsonDecode(response.body());

      debugPrint(body["message"]);
      //  checkRequestData = body["message"];
      print(body['data']['_id']);
      ///////////////// saving Id ///////////////////
      var id = body['data']['_id'] as String; //  requestId
      SharedPrefsId.saveRequestID(id);
      //SharedPrefs.saveToken(id);         // save id of request
      ////////////////////////////////////////////////
      print("your request id is :$id");
      print("${prefsRequestID.getString("id")}");

      if (body["status"] == true) {
        FormHelper.showSimpleAlertDialog(
          context,
          "[" + Config.appName + "]",
          "Request has been created !!!",
          "Ok",
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeControllerPage()));
          },
        );
      } else {
        FormHelper.showSimpleAlertDialog(
          context,
          "[" + Config.appName + "]",
          "Faild: Something went woring !!!\ntry again",
          "Ok",
          () {
            Navigator.pop(context);
          },
        );
      }
    } else if (response.statusCode == 400) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Invalid Syntax : ... \nEnsure that u inserted the right data press OK to try again",
        "OK",
        () {
          Navigator.pop(context);
        },
      );
    } else {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "not successed : ... \nSomething went woring, try again",
        "OK",
        () {
          Navigator.pop(context);
        },
      );
      debugPrint("not successed =============");
    }
  }

  Future getRequest(String id) async {
    bool? status;
    String? msessage;
    dynamic data;
    String? title, bodii;
    double? fromLocation, toLocation;
    int priceRangemin, priceRangemax, timeRange;

    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    //  Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String); // will be putted instead 624e9ebce96ec076cbce6e53
    var url = Uri.parse(Config.apiURl +
        Config.getRequestAPI +
        id); //payload['_id']);//Config.apiURl+ Config.getRequestAPI);
    http.Response response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      var body = (json.decode(response.body()));

      setState(() {
        globals.requestsData.add(body);
      });

      print((globals
          .requestsData)); //[first iteration added to list requestsData ][first data[body]]
      print((globals.requestsData[0][
          'status'])); //[first iteration added to list requestsData ][first data[body]]

      msessage = globals.requestsData[0]["msessage"];
      status = globals.requestsData[0]["status"];
      data = globals.requestsData[0]['data'];
      title = globals.requestsData[0]["data"][0]["title"];
      bodii = globals.requestsData[0]["data"][0]["body"];

      fromLocation =
          globals.requestsData[0]['data'][0]['fromLocation']['coordinates'][1];
      toLocation =
          globals.requestsData[0]['data'][0]['fromLocation']['coordinates'][1];
      priceRangemin = globals.requestsData[0]["data"][0]["priceRange"]["min"];
      priceRangemax = globals.requestsData[0]["data"][0]["priceRange"]["max"];
      timeRange = globals.requestsData[0]["data"][0]["timeRange"]["val"];

      print("==============================");
      print("${data}");
      print("==============================");
      print("${msessage}");
      print("${status}");
      print("${bodii}");
      print("${title}");
      print("${fromLocation}");
      print("${toLocation}");
      print("${priceRangemin}");
      print("${priceRangemax}");
      print("${timeRange}");

      /*for (var i = 0; i < body.length; i++) {
      // instgram example
      requestsData.add((body[i]['fromLocation']['coordinates']));
    }
    for (var i = 0; i < body.length; i++) {
      // instgram example
      print((body[i]['fromLocation']['coordinates']));
    }*/

      /*print(body);
    print(body["data"]["fromLocation"]);
    */

      return null;
    } else {
      print("reject");
    }
  }

  Future deleteRequest(String id) async {
//  var header = {"Authorization":"Bearer "+"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjQ5YWJkNmQ4MzUzODMxZDI1Nzg5MmQiLCJpYXQiOjE2NDk2ODMxNTB9.4UZEwg4UvTHR6AIZ2KyHvtcDxwpPJpjFUVLO1WZrT2A"};//(prefs.getString("token") as String)};
    //var url = Uri.parse("http://192.168.1.4:8080/api/request/open"); //http://localhost:8080/api/request/open
    Map<String, String> header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String),
    };

    var url = Uri.parse(
        Config.apiURl + Config.requestAPI + Config.deleteRequestAPI + id);
    var response = await http.delete(url, headers: header);

    if (response.statusCode == 200) {
      print("hi");
    } else {
      print("reject");
    }
  }
}
