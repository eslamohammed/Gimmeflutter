// ignore_for_file: file_names


import 'package:gimme/Api/Models/requestOpenModel.dart';
import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchRequestOpenModel{
  var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
  Future <List<RequestOpenModel>?> fetchRequestOpenModel() async{
    
    var url = Uri.parse(Config.apiURl+ Config.requestOpenAPI);
    http.Response  response = await http.get(url, headers: header); 
    //http.Response  response = await http.post(url, headers: header); 

    if(response.statusCode == 200){
      print(response.statusCode);
      print(response.body());
      
      

      List <RequestOpenModel>  Requests= [];
      /*for (var profile in body)
      {
        profiles.add(ProfileModel.fromJson(profile));
        print(profiles.length);
      }*/
        
        return Requests;
    }else{
      //debugPrint(response.statusCode as String);
            print(response.statusCode);
            print("reiect");

    }
    return null;
    
  }
 
 
}