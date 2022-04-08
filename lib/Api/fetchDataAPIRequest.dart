// ignore_for_file: file_names

import 'dart:convert';
import 'package:gimme/Api/Models/profileModel.dart';
import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchDataAPIRequest{
  
 // String profileName = "";
  //String profileEmail= "";
  //String profilePhone= "" ;
  //String profileId   ="";



  var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
  Future <List<ProfileModel>?> fetchDataAPIRequest() async{
    
    var url = Uri.parse(Config.apiURl+ Config.userProfileAPI);
    http.Response  response = await http.get(url, headers: header); 

    if(response.statusCode == 200){
      print(response.statusCode);
      print(response.body());
      print("=============================");
      var body = jsonDecode(response.body());
      

    var  profileName  =  body["data"]["name"] ;
    var  profileEmail =  body["data"]["email"];
    var  profilePhone =  body["data"]["phone"];
    var  profileId    =  body["data"]["_id"];
      
      print(profileName);
      print(profileEmail);
      print(profilePhone);
      print(profileId);

      List <ProfileModel> profiles = [];
      /*for (var profile in body)
      {
        profiles.add(ProfileModel.fromJson(profile));
        print(profiles.length);
      }*/
        
        return profiles;
    }else{
      //debugPrint(response.statusCode as String);
            print(response.statusCode);

    }
    return null;
    
  }

 








Future<String ?>  fetchDataProfileEmail() async{
    
    var url = Uri.parse(Config.apiURl+ Config.userProfileAPI);
    http.Response  response = await http.get(url, headers: header); 

    if(response.statusCode == 200){
     
      var body = jsonDecode(response.body());
      

    var  profileEmail =  body["data"]["email"];

    return profileEmail ;
  }
  
  }


  Future <  String ? > fetchDataProfileName() async{
    
    var url = Uri.parse(Config.apiURl+ Config.userProfileAPI);
    http.Response  response = await http.get(url, headers: header); 

    if(response.statusCode == 200){
     
      var body = jsonDecode(response.body());
      

    var  profileName  =  body["data"]["name"] ;

    return profileName ;
  }
  
  }










/*
  Future<Widget> widgetBuildUserAccount () async {
   return UserAccountsDrawerHeader(
         
       accountName: Text(profileName),   //FetchDataAPIRequest().profileEmail as String,      //from account token
       accountEmail: Text(profileEmail),
       arrowColor: Colors.black,
       currentAccountPicture :  CircleAvatar(
       backgroundImage:  NetworkImage('https://images.unsplash.com/photo-1648869190057-4a2e50d0395b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),          
     ),
    );
 } 
*/
  
}