//import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, unnecessary_null_comparison
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gimme/pages/HomeController.dart';
import 'package:gimme/sharedPrefrances/sharedPrefsToken.dart';
import 'package:gimme/main.dart';

import 'package:gimme/widget/customInputTextField.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:snippet_coder_utils/hex_color.dart';
import '../../config.dart';


// ignore: camel_case_types
class Login_page extends StatefulWidget{
  const Login_page({Key? key}) : super(key: key);


  @override
  _Login_pageState createState() => _Login_pageState();
  
}

// ignore: camel_case_types
class  _Login_pageState extends State<Login_page>{

  final TextEditingController _emailTextEditingController= TextEditingController();  
  final TextEditingController _passwordTextEditingController= TextEditingController();


  @override
  void dispose(){

    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  bool isAPIcallProcess = false;
  bool hidepassword = true;
  String checkAccount = "";
  String checkData = "";

@override
Widget build(BuildContext context){
  return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white, 
          body: _loginUI(context),

          ),
        );
  }


Widget _loginUI(BuildContext context){
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
/*
          Container(    //Logo
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  ],
              ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(110),
                 bottomRight: Radius.circular(110),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(  
                alignment : Alignment.center,
                child: Image.asset("assets/gimmeMoblieApp.png",
                width: 250,
                fit: BoxFit.contain,),
                ), 
            ],
            ),
          ),
*/
  //login Word
Padding(
  padding: const EdgeInsets.all(15),
  child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height: MediaQuery.of(context).size.height*0.05,
                        width: MediaQuery.of(context).size.width*0.25, 
                      ),
                Container(
                  decoration: BoxDecoration(),
                  height: MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.25, 
                   child: Text(
                    "Log In",
                    style: TextStyle(
                    //fontWeight : FontWeight.bold, 
                    fontWeight:  FontWeight.bold, 
                    fontSize: 50,
                    color: Colors.black ),
                    ),
                ),    
                  
              Container(
                decoration: BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height*0.05,
                width: MediaQuery.of(context).size.width*0.32, 
             ),
            ],
           ),
          ),
         ],
        ),
       ),

          
          SizedBox(
            width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height/3 ,
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.only(  
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),  
                          
                        )
                        /// contin
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomInputTextFieldWidget(hintText: "email                                     forExample@email.com",
                      secure: false,ccontroller: _emailTextEditingController, 
                      icon: Icons.update,),
                    ),
                     ),
                ),
                

                //password
              
                 Padding(
                   padding: const EdgeInsets.all(10),

                    child : Container(
                      decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.only(  
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),  
                          
                        )
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInputTextFieldWidget(hintText: "password",secure: true ,ccontroller: _passwordTextEditingController, icon: Icons.update,),
                      )),
                 ),
                

              Padding(    
                  padding: const EdgeInsets.all(15),
                  child: Center( //login button & calling _loginToAccount() function;
                    // ignore: deprecated_member_use
                    child: FlatButton(onPressed: () async {
                      _loginToAccount();
                    }
                    ,child: Padding(
                        padding: const EdgeInsets.all(12.5),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                        child: const Center(
                          child: Text("   Login" ,
                                      style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:25,),
                                      ),
                                    ),
                                ),
                            ),
                            color: primaryColor,
                    ),
                  ),
              ),
            ],
            ),
          ),
          

          /*
          Padding(  //email
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              
              context,
              "email", 
              "email", 
              
              (onValidateVal){
                if(onValidateVal.isEmpty){return "Password Can't be empty";}
                return null;
                
              }, 
              (onSavedVal){
                email = onSavedVal; 
              },
              prefixIcon: const Icon(Icons.person),
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),


          Padding(  //password
            padding: const EdgeInsets.only(top : 10),
            child: FormHelper.inputFieldWidget(
              context,
              "password", 
              "password", 
              
              (onValidateVal){
                if(onValidateVal.isEmpty){return "Password Can't be empty";}
                return null;
                  
              }, 
              (onSavedVal){
                password = onSavedVal; 
              },
              //prefixIcon: const Icon(Icons.person),
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              
              obscureText: hidepassword,
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  hidepassword = !hidepassword;
                });
              },
              color: Colors.white.withOpacity(0.7),
              icon: Icon(
                hidepassword ? Icons.visibility_off : Icons.visibility),
                )
            ),
          ),

          Align(    //Forget password
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20 , top: 10),
              child: RichText(
                text : TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Forget password",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        debugPrint("Forget password");
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          
          Center(
            child: FormHelper.submitButton(
              "Login",
              () async {
                    //login waiting for Api  
                    /*var url = Uri.parse('http://localhost:8080/api/user/login');
                    var response = await http.post(url, body: {
                          "email" : "admin@email.com",
                          "password" : "Helloadmin123_"
                      });
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');
                    print(await http.read(Uri.parse('http://localhost:8080/api/user/login')));*/

                    if (true){
                          //Navigator.pushNamed(context, "/register");
                          Navigator.pushNamedAndRemoveUntil(
                            context, '/home',
                            (route) => false,);
                        }
                        else
                    {
                      /*FormHelper.showSimpleAlertDialog(
                        context, 
                        Config.appName,
                        "Invalid Username/Password !",
                        "Ok", 
                        (){
                          Navigator.pop(context);
                        },);*/
                    }
              
              
              }
            ),
          ),
          */
         
          Align( //Don't have an account ==> Sign Up
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 20,),
              child: RichText(
                text : TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "     ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      
                    ),
                    TextSpan(
                      text: "Forget your password",
                      style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        //Navigator.pushNamed(context, "/register");
                        
                        ///navigatting to forget password page 
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),


          Center( //OR
            child: Text("OR" ,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
           ),
          ),

          SizedBox(
            height: 20,
          ),   

          Align( //Don't have an account ==> Sign Up
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 20 , top: 10),
              child: RichText(
                text : TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      
                    ),
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        Navigator.pushNamed(context, "/register");
                      }
                    ),
                  ],
                ),
              ),
            ),
          )
       ],
     ),
   ),
 );

  
}


Future  _loginToAccount() async{      //login to account
  
  var url = Uri.parse(Config.apiURl + Config.loginAPI);
  var response = await http.post(url, 
  body: {
  "email"    : _emailTextEditingController.text,
  "password" : _passwordTextEditingController.text, });            
                  
      // if condition to check if account already exited or created and if then send user to login page
      if(response.statusCode == 200){
      debugPrint('Response body: ${response.body()}');
      debugPrint("=======================================");
      debugPrint('Response status: ${response.statusCode}');

      var body =jsonDecode(response.body());

      debugPrint(body["message"] );
      debugPrint(body["data"] );
      checkAccount = body["message"];
      checkData = body["data"];
      ////////////////////////////////////
      var token = body["data"] as String ;
      SharedPrefs.saveToken(token);

      FormHelper.showSimpleAlertDialog(
            context, 
            Config.appName,
            "Login Successfully     Now Press Ok to continue",
            "Ok", 
            (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()));
           },
          );
      }else if((response.statusCode == 404)){
        FormHelper.showSimpleAlertDialog(
          context, 
          Config.appName,
          "Can't login : User not found!!!",
          "Ok", 
          (){
          Navigator.pop(context);  
         },);
       }else if(response.statusCode == 401){
         FormHelper.showSimpleAlertDialog(
          context, 
          Config.appName,
          "[Can't login : Incorrect Password!!!] ",
          "Ok", 
          (){
          Navigator.pop(context);  
         },);
        }else if(response.statusCode == 400 ){
          FormHelper.showSimpleAlertDialog(
            context, 
            Config.appName,
            "Invalid Syntax : Email and Password are required!",
            "Try again", 
            (){
            Navigator.pop(context);
            },
          );
        } else{
          FormHelper.showSimpleAlertDialog(
            context, 
            Config.appName,
            "Something went worng",
            "Try again", 
            (){
            Navigator.pop(context);
            },
          );
      }
  }
}