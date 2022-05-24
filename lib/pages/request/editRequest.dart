// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gimme/Google_maps/googleMap.dart';
import 'dart:convert';

import 'package:gimme/config.dart';
import 'package:gimme/pages/HomeController.dart';
import 'package:gimme/widget/customInputTextField.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:http/http.dart' as http;
import 'package:gimme/utilies/global_library.dart' as globals;

import 'package:gimme/main.dart';

class EditRequest extends StatefulWidget {
  final body;
  final title;
  final reqID;
  final timerange;
  final minPr;
  final maxPr;
  final timeUnit;
  final fromAddress;
  final toAddress;
  EditRequest(
      this.body,
      this.title,
      this.reqID,
      this.timerange,
      this.minPr,
      this.maxPr,
      this.timeUnit,
      this.fromAddress,
      this.toAddress); // this.id,this.timerange,this.minPr,this.maxPr/* this.from ,this.to*/ );

  @override
  _EditRequestState createState() => _EditRequestState();
}

class _EditRequestState extends State<EditRequest> {
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text(
            'Edit request',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          backgroundColor: primaryColor,
          elevation: 1,
          centerTitle: true,
        ),
        body: _editRequestUI(context));
  }

  ///UI
  Widget _editRequestUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),

            child: Container(//"Insert new data,here"
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
                        "Insert new data,here",
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
                              hintText: "${widget.title}",
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
                              hintText: "${widget.body}",
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
                    Container(//Choose the delivery price.
                      width: MediaQuery.of(context).size.width / 2.7, //**delivery price Word width**
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
                    SizedBox(// price min
                      width: MediaQuery.of(context).size.width / 5, //** price width it self **
                      child: Padding(//min
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
                              hintText: "min : ${widget.minPr}",
                              secure: false,
                              ccontroller: _minPricreTextEditingController,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(// price max
                      width: MediaQuery.of(context).size.width / 5, //** price width it self **
                      child: Padding( //max
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
                              hintText: "max : ${widget.maxPr}",
                              secure: false,
                              ccontroller: _maxPricreTextEditingController,
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
                                hintText: "Time : ${widget.timerange}",
                                secure: false,
                                ccontroller: _timeRangeTextEditingController,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(// time unit
                      width: MediaQuery.of(context).size.width /
                          6.5, //** price width it self **
                      child: Padding(//max
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
                              hintText: "unit : ${widget.timeUnit}",
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
          SizedBox(//address from
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
                        "from : [${widget.fromAddress}]   it will replaced by google places data",
                    secure: false,
                    ccontroller: _fromAddressTextEditingController,
                    icon: Icons.update,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(//address to
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
                        "To : [${widget.toAddress}]\t\t\t\t\t\t\t\t\tit will replaced by google places data",
                    secure: false,
                    ccontroller: _toAddressTextEditingController,
                  ),
                ),
              ),
            ),
          ),

          /// end of UI address never forgett to git me key

          Container(//Location
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.9,

            child: TextButton(
              onPressed: () async {
                //navigation to GoogleMaps to place marker
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GoogleMaps()));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Center(
                    child: Text(
                  "\t\t\t\t\t\t Select Location \n\nHint: \n\nClick here to select new [From & To] Loctations [Source{From} & distination{To}]\n",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ),
          color: primaryColor,
        ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          Padding(// edit request
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
                //Edit button & calling editrequest() Function function;
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () async {
                      //Calling editRequest() function
                      print(
                          "From LatLong after Edit: latlng(${globals.fromLat},${globals.fromLong})");
                      print(
                          "=======================================================================");
                      print(
                          "To LatLong after Edit: latlng(${globals.toLat},${globals.toLong})");

                      print("${widget.reqID}");
                      editRequest(widget.reqID);
                      /*if (_titleTextEditingController.text.isNotEmpty){
            if(_bodyTextEditingController.text.isNotEmpty){
              if(_minPricreTextEditingController.text.isNotEmpty && _maxPricreTextEditingController.text.isNotEmpty){
                  if(_timeRangeTextEditingController.text.isNotEmpty){
                    if(globals.fromLat != null && globals.fromLong !=null && globals.toLat != null && globals.toLong !=null){
                      // _addRequest();  //function to add Request
                    }else  {FormHelper.showSimpleAlertDialog(//location
                      context, 
                      Config.appName,
                      "Set {From & To} markers on Google maps blow, uh baka!!",
                      "OK", 
                      (){
                        Navigator.pop(context);
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMaps()));                      
                      },);
                    }  
                  }else  {FormHelper.showSimpleAlertDialog( //time
                    context, 
                    Config.appName,
                    "Time[unit] in hour \nCheck inserted Time, press OK to try again",
                    "OK", 
                    (){
                        Navigator.pop(context);
                    },);
                  }  
                }else  {FormHelper.showSimpleAlertDialog(//price
                context, 
                Config.appName,
                "inserted worng data , price and try again",
                "OK", 
                (){
                    Navigator.pop(context);
                },);
              }            
            }else  {FormHelper.showSimpleAlertDialog(//body
              context, 
              Config.appName,
              "inserted worng data , body and try again",
              "OK", 
              (){
                  Navigator.pop(context);
                  debugPrint("");
              },);
            }
          }else  {FormHelper.showSimpleAlertDialog(//all data
            context, 
            Config.appName,
            "Request data is required and can not be Empty press OK to try again",
            "OK", 
            (){
                Navigator.pop(context);
                debugPrint("");
            },
          );
        }
        */
                    },
                    child: Padding(//Edit Request
                      padding: const EdgeInsets.all(12.5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Center(
                          child: Text(
                            "   Edit  ",
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
////http://192.168.1.4:8080/api + /request + /edit/: + id[req Id]
  Future editRequest(String id) async {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer " + (prefs.getString("token") as String),
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
      "timeRange": {"val": _timeRangeTextEditingController.text}
    });
    var url = Uri.parse(
        Config.apiURl + Config.requestAPI + Config.editRequestAPI + id);
    var response = await http.put(url, body: bodii, headers: header);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body());
      //print(body);
      //print("${body["status"]}");
      //print("${body["status"]}");
      if (body["status"] == true) {
        FormHelper.showSimpleAlertDialog(
          context,
          "[" + Config.appName + "]",
          "Success : request has been edited !!!",
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
          "Faild: Something went woring !!!",
          "Ok",
          () {
            Navigator.pop(context);
          },
        );
      }
    } else if (response.statusCode == 400) {
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "Faild\nInvalid Syntax : ...",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );

      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to update album.');
    } else if (response.statusCode == 403) {
      debugPrint("not Forbidden");
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "Can't perform this action !!!",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    } else if (response.statusCode == 404) {
      debugPrint("not Forbidden");
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "Error : Not found",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    } else {
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "Something went woring, try again",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    }
  }
}
