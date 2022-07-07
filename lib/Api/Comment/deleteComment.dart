import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

class DeleteComment{
  
Future  deleteComment(BuildContext context ,String reqId , String commentId) async{ 
  
  Map<String,String> header = {
    "Authorization":"Bearer " + (prefs.getString("token") as String),
    'Content-Type': 'application/json; charset=UTF-8'
    };
  /*String bodii = json.encode(
      {
        
        "reqId" : reqId as String,
        "commentId" : commentID
        
      }
    );*/
    var url = Uri.parse(Config.apiURl + Config.commentAPI);
    var response = await http.delete(
      url ,
      body: json.encode(
        {
          "reqId" : reqId,
          "commentId" : commentId
        }
      ),
      headers: header );

    if(response.statusCode == 200){
    var body = jsonDecode(response.body());
    print(body["status"]);
      if (body["status"]== true){
      FormHelper.showSimpleAlertDialog(
        context, 
        Config.appName,
        "${body["message"]}",
        "Ok", 
        (){
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowSearchedReqComments(reqId)));  
          Navigator.pop(context);
          Navigator.pop(context);
      },);
      } else {
        FormHelper.showSimpleAlertDialog(
        context, 
        Config.appName,
        "Error:${body["message"]}",
        "Ok", 
        (){
        Navigator.pop(context);  
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()));  
      },);
      }
    }else{
      var body = jsonDecode(response.body());
      print(body);
      FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      "Error:${response.statusCode}\n${body["message"]["formErrors"]}",
      "Ok", 
      (){
      Navigator.pop(context);  
    },);
    }  
  }


}