// ignore_for_file: file_names

import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchReviews{
  
  Future  <http.Response> fetchReview(String userId) async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};
    var url = Uri.parse(Config.apiURl+ Config.reviewGetAPI + userId);
    print(url);
    return await http.get(url, headers: header); 

  }
}