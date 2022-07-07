import 'package:flutter/material.dart';
import 'package:gimme/main.dart';
import 'package:gimme/modules/stripe/createStripeAccountWV.dart';
import 'package:gimme/shared/config.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:snippet_coder_utils/FormHelper.dart';



class CreateAccount{

  Future  createStripeAccount(BuildContext context) async{    
  var url = Uri.parse(Config.apiURl + Config.paymentAPI + Config.createStripeAcc);
  Map<String,String> header = {
    "Authorization":"Bearer " + (prefs.getString("token") as String),
    //'Content-type' : 'application/json', 
  };
  var response = await http.post(url,  headers: header);
      // if condition to check if account already exited or created and if then send user to login page
      if(response.statusCode == 200){
        debugPrint('Success : Response body: ${response.body()}');
        debugPrint('Response status: ${response.statusCode}');
        debugPrint("=======================================");

        var body =jsonDecode(response.body());
        if (body["status"]==true) {
          FormHelper.showSimpleAlertDialog(
              context, 
            "["+Config.appName+"]",
              "${body["message"]}",
              "Create Account", 
              (){
                print("${body["data"]["url"]}");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreateStripeAccount(
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
            "["+Config.appName+"]",
            "${body["message"]}",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
        }
      }else{
        var body =jsonDecode(response.body());
        print("${body["message"]}");
        FormHelper.showSimpleAlertDialog(
          context, 
          "["+Config.appName+"]",
          "Something went error : ${body["message"]}",
          "Ok", 
          (){
            Navigator.pop(context);
          },
        );
      }
  }

}