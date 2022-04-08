// ignore_for_file: file_names
//file which contain saveToken that i use to save the token of user

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static Future saveToken(String token) async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", id);
  }
    static Future saveEmail(String saveEmail) async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("saveEmail", saveEmail);

  }

 /* static getToken() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return token;
  
  }*/

}