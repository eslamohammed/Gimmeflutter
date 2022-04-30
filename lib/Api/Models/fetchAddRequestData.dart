

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/AddRequestModel.dart';
import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';



class FetchAddRequestData{

  var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

  Future <List<AddRequestModel>?> fetchRequests(String id) async{
    Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String); // will be putted instead 624e9ebce96ec076cbce6e53
    
    var url = Uri.parse( Config.apiURl + Config.getRequestAPI + id );  //payload['_id']);//Config.apiURl+ Config.getRequestAPI);
    
    http.Response  response = await http.get(url, headers: header); 
    if(response.statusCode == 200){
      debugPrint("----------------------------------------------");
      print(response.statusCode);
      //print(response.body());
      var body = jsonDecode(response.body());// as Map<String,dynamic>; 
      debugPrint("==============================================");
      List <AddRequestModel> Requests = [] ;
      List requests = [];
      requests.add(body);
      requests.add(AddRequestModel.fromJson(body));
      print(requests.length);
      print(requests[0]);
      debugPrint("==============================================");
      for (var request in body){
        Requests.add(AddRequestModel.fromJson(request));          //add request to array requests 
        print(requests.length);
        print("===================--------------------==========");
      }
      debugPrint("==============================================");

/*      for (var body in body.values){
        requests.add(AddRequestModel.fromJson(body));          //add request to array requests 
        print(requests.length);
        print("===================--------------------==========");
      }
      print("===================--------------------==========");
*/
/*      for (var request in body ){
        requests.add(request);          //add request to array requests 
        //requests.add(request);
      }
      print(requests.length);
      print("===================--------------------==========");
      debugPrint(requests[0].title as String);
      print("===================--------------------==========");
      //debugPrint(requests[0].status as String);
      //print(requests.length);
//    return null;
      for (var request in body ){
      print(requests[request].length);
      print("===================--------------------==========");
      debugPrint(requests[request].title as String);
      print("===================--------------------==========");
      }
      
*/
    
    //return requests[x];
    return null;
    }else{
            print(response.statusCode);
            print("reiect");
    }
    return null;
    
  }

}