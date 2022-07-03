import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;

class FetchRequest{
   ///featching all requests 
Future<http.Response> fetchRequests() async {
    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    var url = Uri.parse(Config.apiURl + Config.getAllRequestAPI);
    return await http.get(url, headers: header);
  }

}