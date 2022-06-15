
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gimme/modules/Google_maps/googleMap.dart';
import 'dart:convert';

import 'package:gimme/utilies/config.dart';
import 'package:gimme/controller/HomeController.dart';
import 'package:gimme/widget/InputWidet/customInputNumberField.dart';
import 'package:gimme/widget/InputWidet/customInputTextField.dart';

import 'package:snippet_coder_utils/FormHelper.dart';

import 'package:http/http.dart' as http;
import 'package:gimme/utilies/global_library.dart' as globals;

import 'package:gimme/main.dart';
import 'package:snippet_coder_utils/hex_color.dart';

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
            padding: EdgeInsets.only(right: 10, left: 10),

            child: Container(//"Insert new data,here"
              width: MediaQuery.of(context).size.width/1,
              height: MediaQuery.of(context).size.height*0.21,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(//Insert new data,here Word
                      padding: EdgeInsets.only(left:20.0, top: 10,),
                      child: Text("Insert new data, here",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(//title
                      height: MediaQuery.of(context).size.height*0.09,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(top:10,bottom: 10,right: 20,left: 20),
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
                            padding: EdgeInsets.all(8),
                            child: CustomInputTextFieldWidget(
                              labelText: "Title",
                              hintText: "Old title : ${widget.title}",
                              secure: false,
                              ccontroller: _titleTextEditingController,
                              //fillColor: grayColor,
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
                        padding: const EdgeInsets.only(top:10,bottom: 10,right: 20,left: 20),
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
                            padding: const EdgeInsets.all(8),
                            child: CustomInputTextFieldWidget(
                              labelText: "Body",
                              hintText: "Old Body :${widget.body}",
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
                      child: Text(
                        "Time",
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
                                  hintText: "Time : ${widget.timerange}",
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
                                hintText: "${widget.timeUnit}",
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
                    height: MediaQuery.of(context).size.height*0.03, //**delivery price Word hight**
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
                        width: MediaQuery.of(context).size.width*0.38, //** price width it self **
                        child: Padding(//min
                          padding: const EdgeInsets.only(right: 10,),
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
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 9),
                              child: CustomInputNumberField(
                                labelText: "min",
                                hintText: "${widget.minPr}",
                                controller: _minPricreTextEditingController,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.025,),
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
                              labelText: "max",
                              hintText: "${widget.maxPr}",
                              controller: _maxPricreTextEditingController,
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

          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

          /// now putting address manually until gitting googlePlaces key
          /// it just replaced with address comes from google instead inserttimg it manually
        
                
          Container(//Temperory location
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(//Location word
                  padding: EdgeInsets.all(8.0),
                  child: Text( "     Location ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), //waiting for API data
                Center(//Google maps widget *** some error
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.22,
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
                                  hintText: "from : [${widget.fromAddress}]   it will replaced by google places data",
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
                                  hintText: "from : [${widget.toAddress}]   it will replaced by google places data",
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

          Container(//Location
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.9,

            child: FlatButton(
              onPressed: () async { //navigation to GoogleMaps to place marker
                Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMaps(key: Key("key"),)));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Center(
                    child: Text(
                  "\t\t\t\t\t\t Select Location \n\nHint: \n   Click here to select new [From & To] Loctations [Source{From} & distination{To}]\n",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            shape: StadiumBorder(side: BorderSide(color: fillColors,width: 9)),
            color: primaryColor,
          ),
        ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          Padding(// edit request
            padding: const EdgeInsets.only(right: 10,),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 10,
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
                    onPressed: () async {//Calling editRequest() function
                      editRequest(widget.reqID);
                    },
                    child: Padding(//Edit Request
                      padding: const EdgeInsets.all(12.5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Center(
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
                    shape: StadiumBorder(),
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
        "min": int.parse(_minPricreTextEditingController.text),
        "max": int.parse(_maxPricreTextEditingController.text)
      },
      "timeRange": {
        "val": int.parse(_timeRangeTextEditingController.text),
        "unit": _timeUnitsTextEditingController.text
        }
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
          "${body["message"]}",
          "Ok",
          () {
            Navigator.pop(context);
          },
        );
      }
    } else if (response.statusCode == 400) {
      var body = jsonDecode(response.body());
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "${body["message"]}",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );

      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to update album.');
    } else if (response.statusCode == 403) {
      var body = jsonDecode(response.body());
      debugPrint("not Forbidden");
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "${body["message"]}",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    } else if (response.statusCode == 404) {
      debugPrint("not Forbidden");
      var body = jsonDecode(response.body());
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "${body["message"]}",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    } else {
      var body = jsonDecode(response.body());
      FormHelper.showSimpleAlertDialog(
        context,
        "[" + Config.appName + "]",
        "${body["message"]}",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    }
  }
}
