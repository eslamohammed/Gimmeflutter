// ignore_for_file: file_names

import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchAccounts{
  
  Future  <http.Response> fetchMyAccount() async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
    var url = Uri.parse(Config.apiURl+ Config.userProfileAPI);
    return await http.get(url, headers: header); 

  }
 Future  <http.Response> fetchOthersAccount(String id) async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
    var url = Uri.parse(Config.apiURl+ Config.othersProfileAPI+id);
    return await http.get(url, headers: header); 
 }











/*for test
 get_commenterName(String id) async{
  var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
  var url = Uri.parse(Config.apiURl+ Config.othersProfileAPI+id);
  http.Response  res = await http.get(url, headers: header); 
  if (res.statusCode==200) {
    var body = jsonDecode(res.body());
    print(body['data']['name']);
    return body['data']['name'] as String;
  } else {
    print("reject");
    
  }
} 
*/
/*
Future<List<Map<String, dynamic>>> get_commenterName(String id) async{
    List <Map<String,dynamic>> commenters = [];
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
    var url = Uri.parse(Config.apiURl+ Config.othersProfileAPI+id);
    http.Response  res = await http.get(url, headers: header); 
    if (res.statusCode==200) {
      var body = jsonDecode(res.body());
      commenters.add(body);
    } else {
      print("reject");
    }
    return commenters;
  } */

/*
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




*/





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