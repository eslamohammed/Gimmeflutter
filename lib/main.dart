// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:gimme/Google_maps/googleMap.dart';
import 'package:gimme/pages/Home_page.dart';
import 'package:gimme/pages/addRequest.dart';
import 'package:gimme/pages/chatPage.dart';
import 'package:gimme/pages/homePage.dart';
import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:gimme/pages/profilePage.dart';
import 'package:gimme/pages/registerAccountPage/register_page.dart';
import 'package:gimme/pages/searchPage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gimme/utilies/global_library.dart' as global_library;
//import 'package:global_library.dart' as global_library ;

int currnetIndex = 0;  //the index that only responisible for change between home screens 
  final screens = [    // home screens home, chat, search, add request , profile
    Home(),
    SearchPage(),
    ChatPage(),
    AddRequest(),
    GoogleMaps(),
    ProfilePages(),
  ];
   
const primaryColor = Color.fromARGB(179, 0, 161, 35); 
SharedPreferences prefs = "null" as SharedPreferences ;

void main() async{
  //global_library.fromLat ;
  
  WidgetsFlutterBinding.ensureInitialized();   //because we now in main class so flutter have to ignore an some Ops
   prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token") ;  //getting token value

    //print(global_library.toLat);
    // To decode the token
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    print(payload);                                     // Print the payload
    print(payload['_id']);                              // Print one of its property(example: email):
    /*
    DateTime? expiryDate = Jwt.getExpiryDate(token);    //   To get expiry date
                                                        //   Note: The return value from getExpiryDate function is nullable.
    debugPrint("the expire date at : $expiryDate");                                  //Print the expiry date
    // To check if token is expired
    bool isExpired = Jwt.isExpired(token);
    print(isExpired);
    // Can be used for auth state
    if (!isExpired) {                                   //   Token isn't expired 
      print("token is not Expired") ;              

      } else {                                          //Token is expired
      print("token is not Expired") ;              

  }*/



    //String? tokenEmail = prefs.getString("tokenEmail");
    //String? token2 = token;
  
  Widget _screen;               //initial screen ==> if user have allready token / logged in before then send him to home page directly 
                                // user should not log in again
   
   if((token == null) || (token == "null") || (token == "")/*||token == token2*/){
      _screen = Login_page();
    }
    else if(token == "Invalid Syntax : Email and Password are required!" || token == "Incorrect Password!!!" || token == "User not found!!!" ){
     _screen = Login_page();
    }else{
      _screen = HomePage();
      //_screen = screens[1];
    } 
  
  runApp(MyApp(_screen));

}

class MyApp extends StatelessWidget {
  final Widget _screen ;
  MyApp(this._screen);

@override
Widget build(BuildContext context) {
  
  return MaterialApp(
    debugShowCheckedModeBanner: false,   //remove debug padged
    //debugShowMaterialGrid: false,
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