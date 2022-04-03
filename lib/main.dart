// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gimme/pages/Home_page.dart';
import 'package:gimme/pages/addRequest.dart';
import 'package:gimme/pages/chatPage.dart';
import 'package:gimme/pages/homePage.dart';
import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:gimme/pages/profilePage.dart';
import 'package:gimme/pages/registerAccountPage/register_page.dart';
import 'package:gimme/pages/searchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

int currnetIndex = 0;  //to index that only responisible for change between home screens 
  final screens = [   // home screens home, chat, search, add request , profile
    Home(),
    SearchPage(),
    ChatPage(),
    AddRequest(),
    ProfilePages(),
  ];
   
const primaryColor = Color.fromARGB(179, 0, 161, 35);
//const primaryColor = Color.fromARGB(255, 23, 192, 52);

SharedPreferences prefs = "null" as SharedPreferences ;

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();   //because we now in main class so flutter have to ignore an some Ops
   prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token") ;  //getting token value
    //String? tokenEmail = prefs.getString("tokenEmail");

  Widget _screen;               //initial screen ==> if user have allready token / logged in before then send him to home page directly 
                                // user should not log in again
   if((token == null) || (token == "null") || (token == "")){
      _screen = Login_page();
    }
    else if(token == "Invalid Syntax : Email and Password are required!" || token == "Incorrect Password!!!" || token == "User not found!!!" ){
     _screen = Login_page();
    }else{
      _screen = HomePage();
    } 

  runApp(MyApp(_screen));

}

class MyApp extends StatelessWidget {
  final Widget _screen ;
  MyApp(this._screen);

@override
Widget build(BuildContext context) {
  
  return MaterialApp(
    title: 'Gimme App',
    theme: ThemeData(
     //primarySwatch: Colors.blue,
     primaryColor: primaryColor,
    ),

    home: _screen,   // if user have allready token (logged in before) then log in again not required 
    routes: {
      //'/':((context) =>  Login_page()),   //ignored for   home: this._screen,  its an expected error
      '/home':((context) =>  HomePage()),
      '/login':((context) =>  Login_page()),
      '/register':((context) =>  Register_page()),
      },
    );
  }
}