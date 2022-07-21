// ignore_for_file: file_names

import 'package:gimme/shared/config.dart';
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
}