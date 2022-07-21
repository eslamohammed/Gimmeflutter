import 'package:flutter/material.dart';
import 'package:gimme/main.dart';

import 'package:gimme/shared/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:snippet_coder_utils/FormHelper.dart';

///Release payment to the mod
///
class ReleasePayment {

  Future releasePayment(BuildContext context ,String reqId) async{
    var header = {
      "Authorization":"Bearer " + (prefs.getString("token") as String),
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var url = Uri.parse(Config.apiURl+Config.paymentAPI + Config.paymentReleaseAPI);
    String bodii = json.encode(
      {
        "reqId" : reqId,
      }
    );
    var res = await http.post(
      url,
      body: bodii,
      headers: header
    );

    var body = jsonDecode(res.body());

    if (res.statusCode == 200) {
      if (body["status"] == true) {
        //print(body["data"]["url"]);
        FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "${body["message"]}",
        "Ok",
        () {
          Navigator.pop(context);
        ///routing url to open in AddReview page
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => AddReview(),),);
        },
      );
      } else {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Something went woring \n ${body["message"]}",
        "Ok",
        (){
          debugPrint("${body["message"]}");
          Navigator.pop(context);  
        },
      );
      }
      
    } else {
      print(body);
      FormHelper.showSimpleAlertDialog(
        context,
         Config.appName,
        " Error${res.statusCode}: ${body["message"]} ",
        "Ok",
        (){
          debugPrint("${body["message"]}");
          Navigator.pop(context);  
        },
      );
    }

  }

}