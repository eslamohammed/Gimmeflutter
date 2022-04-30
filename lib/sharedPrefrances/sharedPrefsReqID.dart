// ignore_for_file: file_names
//file which contain saveToken that i use to save the token of user

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsId{

  static Future saveRequestID(String id) async {
  
    SharedPreferences prefsId = await SharedPreferences.getInstance();
    prefsId.setString("id", id);
  }

    
 /* static getToken() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return token;
  
  }*/

}