import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/controller/HomeController.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

class Review{
///Adding review Api part 

   
Future  addReview(BuildContext context , String review , String reqId) async{      
Map<String,String> header = {
   "Authorization":"Bearer " + (prefs.getString("token") as String),
   'Content-type' : 'application/json', 
};
  String bodii = json.encode(
    {
      "comment" : review,
      "rate" : 4
    });

  var url = Uri.parse(Config.apiURl+Config.reviewAPI+reqId); //widget.reqID);
  print(url);
  var response = await http.post(url, body: bodii, headers: header);
      // if condition to check if account already exited or created and if then send user to login page

      if(response.statusCode == 200){
        debugPrint('Response body: ${response.body()}');
        debugPrint("=======================================");
        debugPrint('Response status: ${response.statusCode}');
      var body =jsonDecode(response.body());
        print("${body["status"]}");
        if (body["status"]==true) {
          FormHelper.showSimpleAlertDialog(
              context, 
            "["+Config.appName+"]",
              "${body["message"]}\nSucsses now press Ok and go Back your home",
              "Ok", 
              (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeControllerPage(),),);
              },
            );
        }else {
          FormHelper.showSimpleAlertDialog(
              context, 
            "["+Config.appName+"]",
              "Faild: ${body["message"]}",
              "Ok", 
              (){
                Navigator.pop(context);
              },
            );
          }
      }else if (response.statusCode == 403){
          var body =jsonDecode(response.body());
          debugPrint("not Forbidden");
          FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "${body["message"]}",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }else if (response.statusCode == 400){
          var body =jsonDecode(response.body());
          debugPrint("not Forbidden");
          FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "${body["message"]} ",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }else{
        var body =jsonDecode(response.body());
        debugPrint("Faild Message:$body");
        FormHelper.showSimpleAlertDialog(
            context, 
            "["+Config.appName+"]",
            "${body["message"]} ",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }
  }

}