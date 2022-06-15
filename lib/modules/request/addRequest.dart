// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:gimme/Google_maps/googleMap.dart';
import 'package:gimme/widget/InputWidet/customInputNumberField.dart';

import 'package:gimme/widget/InputWidet/customInputTextField.dart';

import 'package:snippet_coder_utils/FormHelper.dart';

import 'package:gimme/utilies/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gimme/utilies/global_library.dart' as globals;

import 'package:gimme/main.dart';
import 'package:gimme/controller/HomeController.dart';
import 'package:snippet_coder_utils/hex_color.dart';


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
          toolbarHeight: 65,
          title: const Text(
            'Add Request',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: TextButton(
              child:  Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Text("Back", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: primaryColor,
                  ),
                ),
              ), //Icon(Icons.ac_unit_sharp), // city name from location
              ///here it will change .close
              onPressed: () =>{}// Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeControllerPage(),),),
          ),
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
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height*0.19,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Padding(//Need Something field
                    padding: EdgeInsets.only(left:20.0, top: 10,),
                    child: Text(
                      "Need Something..!!! , Put here",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),*/
                  SizedBox(//title
                    height: MediaQuery.of(context).size.height*0.09,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 10,right: 20,left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                            color: grayColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              ),
                            /// contin
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomInputTextFieldWidget(
                            labelText: "Title",
                            hintText: "title",
                            secure: false,
                            ccontroller: _titleTextEditingController,
                            fillColor: grayColor,
                            //icon: Icons.update,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(//body
                    height: MediaQuery.of(context).size.height*0.09,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top:10, bottom:10, right:20, left:20),
                      child: Container(
                        decoration: BoxDecoration(
                            border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                            color: fillColors,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomInputTextFieldWidget(
                            labelText: "Body",
                            hintText: "body",
                            secure: false,
                            ccontroller: _bodyTextEditingController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                child: Container(//Choose the delivery price.
                  height: MediaQuery.of(context).size.height*0.1, //**delivery price Word hight**
                  width: MediaQuery.of(context).size.width*0.85, //**delivery price Word width**
                  decoration: const BoxDecoration(//from-to box decoration
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(//word Time
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Text("Time",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(//Time & Units
                        children: [
                          SizedBox(// time
                            width: MediaQuery.of(context).size.width*0.36, //** price width it self **
                            height: MediaQuery.of(context).size.height*0.065,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 9),
                                  child: CustomInputNumberField(
                                    labelText: "Time",
                                    hintText: "Time",
                                    //fillColor: Colors.white,
                                    controller: _timeRangeTextEditingController,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                          SizedBox(// unit
                            width: MediaQuery.of(context).size.width*0.36, //** price width it self **
                            height: MediaQuery.of(context).size.height*0.065,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                ),
                              ),
                                child: Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 9),
                                child: CustomInputTextFieldWidget(
                                  labelText:"unit",
                                  hintText: "unit",
                                  secure: false,
                                  fillColor: Colors.white,
                                  ccontroller: _timeUnitsTextEditingController,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(//price range
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: MediaQuery.of(context).size.height*0.1, //**delivery price Word hight**
                width: MediaQuery.of(context).size.width,
                 decoration: const BoxDecoration(//from-to box decoration
                  color: Colors.white,
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(//Choose the delivery price.
                    height: MediaQuery.of(context).size.height*0.03,
                    child: const Padding(//word Price
                      padding: EdgeInsets.all(8.0),
                      child: Text("Price",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(// price min
                        width: MediaQuery.of(context).size.width*0.36, //** price width it self **
                        child: Container(
                          decoration: BoxDecoration(
                              color: fillColors,
                              border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  ),
                                ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 9),
                            child: CustomInputNumberField(
                              labelText: "min",
                              hintText: "min",
                              controller: _minPricreTextEditingController,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                      SizedBox(// price max
                        width: MediaQuery.of(context).size.width*0.36, //** price width it self **
                        child: Container(
                          decoration: BoxDecoration(
                              color: fillColors,
                              border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  ),
                                ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, bottom: 9),
                            child: CustomInputNumberField(
                              labelText:"max",
                              hintText: "max",
                              controller: _maxPricreTextEditingController,
                            ),
                          ),
                        ),
                      ),
                    ],
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

          /// now putting address manually until gitting googlePlaces key
          /// it just replaced with address comes from google instead inserttimg it manually

          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          
                 
          Container(//Temperory location
            decoration: const BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height * 0.26,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(//Location word
                  padding: EdgeInsets.all(8.0),
                  child: Text("     Location ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), //waiting for API data
                Center(//Google maps widget *** some error
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.201,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: HexColor("#BDBDBD"),
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    //child: GoogleMapsState().build(context),
                    //Text will be replace by  Googlemaps
                    //will send From & To Locations LatLong Co ordinates here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                  
                        SizedBox( //address from
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10, right: 20, left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: fillColors,
                                  border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomInputTextFieldWidget(
                                  labelText: "From address" ,
                                  hintText:"From address   it will replaced by google places data",
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
                          height: MediaQuery.of(context).size.height*0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 15, right: 20, left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: fillColors,
                                  border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  /// contin
                                ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomInputTextFieldWidget(
                                  labelText: "To address",
                                  hintText:"To address\t\t\t\t\t\t\t\t\tit will replaced by google places data",
                                  secure: false,
                                  ccontroller: _toAddressTextEditingController,
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
    

          /// end of UI address never forgett to git me key

          Container( //Location
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.85,

            child: FlatButton(
              onPressed: () async{ //navigation to GoogleMaps to place marker
                Navigator.push(context,  MaterialPageRoute( builder: (context) => GoogleMaps(key: Key("value"),)));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                    "\t\t\t\t\t\t Select Location:  Click here   \n\nHint\nclick select Loctations [Source{from} & distination{to}] Points[Loc-Coordinantes'GoogleMaps'] Homepage Bar\n\n     If you if you are already here Just ignore this step ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ),
              shape: StadiumBorder(side: BorderSide(color: fillColors,width: 9)),
              color: primaryColor,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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
                    onPressed: () async {//Calling AddRequest() function
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

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
        "min": int.parse(_minPricreTextEditingController.text),
        "max": int.parse(_maxPricreTextEditingController.text)
      },
      "timeRange": {
        "val": int.parse(_timeRangeTextEditingController.text),
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

      
      ////////////////////////////////////////////////
      if (body["status"] == true) {
        FormHelper.showSimpleAlertDialog(
          context,
          "[" + Config.appName + "]",
          "${body["message"]}",
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
          "${body["message"]}\ntry again",
          "Ok",
          () {
            Navigator.pop(context);
          },
        );
      }
    } else if (response.statusCode == 400) {
      var body = jsonDecode(response.body());

      print("${body}");
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "${body["message"]}\n",
        "OK",
        () {
          Navigator.pop(context);
        },
      );
    } else {
      var body = jsonDecode(response.body());
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "${body["message"]}",
        "OK",
        () {
          Navigator.pop(context);
        },
      );
    }
  }
/*
  Future _getRequest(String id) async {
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

  Future _deleteRequest(String id) async {
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
  }*/
}
