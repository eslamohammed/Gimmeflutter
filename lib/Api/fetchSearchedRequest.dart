// ignore_for_file: file_names

import 'package:gimme/utilies/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchSearchedRequest{
  
 ///featching all result requests from search
  Future<http.Response> getSearchedRequest(String to, String from) async {
    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    var url = Uri.parse(Config.apiURl + Config.requestAPI + Config.searchRequestAPI + to + Config.searchFromRequestAPI + from); //payload['_id']);//Config.apiURl+ Config.getRequestAPI);
    return await http.get(url, headers: header);
  }
}