// ignore_for_file: file_names

import 'package:gimme/utilies/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchMyComments{
  
  Future  <http.Response> fetchMyComment(String id) async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
    var url = Uri.parse(Config.apiURl+ Config.commentAPI + id);
    return await http.get(url, headers: header); 
  }
}