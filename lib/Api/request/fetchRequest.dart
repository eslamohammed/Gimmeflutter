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


Future<http.Response> fetchMyOnRequests() async {
    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    var url = Uri.parse(Config.apiURl + Config.getMyOnRequestAPI);
    print(url);
    return await http.get(url, headers: header);
  }


Future<http.Response> fetchMyOnFulfilledRequests() async {
    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    var url = Uri.parse(Config.apiURl + Config.getMyOnFulfilledRequestAPI);
    //var url = Uri.parse(Config.apiURl + Config.getMyOnClosedRequestAPI);
    print(url);
    return await http.get(url, headers: header);
  }


Future<http.Response> fetchMyOnClosedRequests() async {
    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    var url = Uri.parse(Config.apiURl + Config.getMyOnclosedRequestAPI);
    //var url = Uri.parse(Config.apiURl + Config.getMyOnClosedRequestAPI);
    print(url);
    return await http.get(url, headers: header);
  }

Future<http.Response> fetchMyOwnerRequests() async {
    var header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String)
    };

    var url = Uri.parse(Config.apiURl + Config.getMyOnFulfilledOwnerRequestAPI);
    //var url = Uri.parse(Config.apiURl + Config.getMyOnClosedRequestAPI);
    print(url);
    return await http.get(url, headers: header);
  }

}