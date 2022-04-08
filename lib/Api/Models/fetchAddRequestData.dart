

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/AddRequestModel.dart';
import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';




class FetchAddRequestData{
  var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

  Future <List<AddRequestModel>?> fetchRequests() async{
    Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String); // instead 624e9ebce96ec076cbce6e53
    
    var url = Uri.parse( Config.apiURl + Config.getRequestAPI +"624e9ebce96ec076cbce6e53");  //payload['_id']);//Config.apiURl+ Config.getRequestAPI);
    
    http.Response  response = await http.get(url, headers: header); 
    if(response.statusCode == 200){
      debugPrint("----------------------------------------------");
      print(response.statusCode);
      print(response.body());
      var body = jsonDecode(response.body()) ;
      debugPrint("==============================================");
      
                          //bool c = body["status"];
      
      print(body);
      //List <AddRequestModel> requests = [];
      List requests = [];
      requests.add(body);
      print(requests[0]);
      
      /*for (var request in body )
      {
        //requests.add(AddRequestModel.fromJson(request));          //add request to array requests 
        requests.add(request);

        //print(requests.length);
        //debugPrint(requests[0].title as String);
        print("===================--------------------==========");
      }*/
      print("===================--------------------==========");
      //debugPrint(requests[0].status as String);
      //print(requests.length);
      

    return null;
//    return requests;
    }else{
            print(response.statusCode);
            print("reiect");
    }
    return null;
    
  }
 
 
}