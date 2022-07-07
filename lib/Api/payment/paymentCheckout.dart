// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/modules/Payment/paymentWebview.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

class PaymentCheckout{
  
  Future  paymentCheckout(BuildContext context ,String reqId , String commentId) async{
    var header = {
      "Authorization":"Bearer " + (prefs.getString("token") as String),
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var url = Uri.parse(Config.apiURl+ Config.paymentAPI + Config.paymentCheckoutAPI);
    String bodii = json.encode(
      {
        "reqId" : reqId,
        "commentId" : commentId
      }
    );
    print(bodii);
    var response = await http.post(url , body: bodii , headers: header);
    var body = jsonDecode(response.body());
    print(body);
    if (response.statusCode == 200) {
      if (body["status"] == true) {
        print(body["data"]["url"]);
        FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "${body["message"]}",
        "Ok",
        () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => PaymentWebview(
/*here */   body["data"]["url"], //routing url to open in webview page
            key: Key("key"),
            ),
          ),
        );
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
    } else{
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        " Error${response.statusCode}: ${body["message"]} ",
        "Ok",
        (){
          debugPrint("${body["message"]}");
          Navigator.pop(context);  
        },
      );
    }
    print(url);
    
    
    ///return await http.get(url, headers: header); 
  }
}