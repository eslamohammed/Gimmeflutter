// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, camel_case_types

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:gimme/Api/sharedPrefs.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http ;

import 'package:flutter/material.dart';
import 'package:gimme/config.dart';
//import 'package:gimme/pages/loginPage/loginPage.dart';
import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../../config.dart';
import '../../widget/customInputTextField.dart';
class Register_page extends StatefulWidget{
  
  @override
  _Register_pageState createState() => _Register_pageState();
}

class  _Register_pageState extends State<Register_page>{
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController= TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _ganderTextEditingController= TextEditingController();
  final TextEditingController _passwordTextEditingController= TextEditingController();

  //every controller must be disposed (deleted from memory for avoiding memory problems)
  @override
  void dispose(){

    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _ganderTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
    
  }
  bool checkIfAccountCreated = false;
  String checkMassage = "";

  
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  

  
  @override
  Widget build(BuildContext context){
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white, 
          body: _registerUI(context)
        ),
    );
}


Widget _registerUI(BuildContext context){
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(  //Sign Up word in UI & log in
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
                  
                   child: const Center(
                     child: Text(
                      "Sign Up",
                      style: TextStyle(
                      fontWeight:  FontWeight.bold, 
                      fontSize: 40,
                      color: Colors.black ),
                      ),
                    ),
                  ),      
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.32, 
                  child: Center(
                    child: RichText(
                  text : TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.5,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                    TextSpan(
                        text: "Log in",
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.pushNamed(context, "/login");
                        }
                      ),
                    ],
                  ),
                    ),
                  ),
               ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2 ,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [// username , email , password , phone...
               /* 
                Padding(    //Create your Account, Now! field
                  padding:  EdgeInsets.only(top :10.0),
                    child: Center(
                    child: Text("Create your Account, Now!" ,
                     style: TextStyle(
                     color: primaryColor,
                     fontWeight: FontWeight.bold,
                     fontSize: 20 ,
                     ),
                   ),
                  ),
                ),
                */
                Padding(    //username
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
                      child: CustomInputTextFieldWidget(hintText: "username",secure: false,ccontroller: _nameTextEditingController,icon: Icons.people,),
                    )),
                ),
                
                Padding(    //email
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.only(  
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),  
                        ),),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomInputTextFieldWidget(hintText: "email                                                                            forExample@email.com",
                      secure: false,ccontroller: _emailTextEditingController, icon: Icons.email,),
                    ),
                  ),
                ),

                Padding(    //phone
                 padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.only(  
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),  
                        ),),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomInputTextFieldWidget(hintText: "phone",
                      secure: false,ccontroller: _phoneTextEditingController,
                  icon: Icons.phone,),
                    ),
                ),),

                Padding(    //password
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.only(  
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),  
                        ),),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                  child: CustomInputTextFieldWidget(hintText: "password",secure: true ,ccontroller: _passwordTextEditingController,icon: Icons.password,),
                ),),),
                         
                Padding(    //Register
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: FlatButton(onPressed: () async {   //registeration function
                      registerAccount();
                    }
                    ,child: Padding(
                        padding: const EdgeInsets.all(12.5),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                        child: const Center(
                          child: Text("   Register" ,
                                      style: TextStyle( color:Colors.white, fontWeight: FontWeight.bold, fontSize:27.5,),
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

          const SizedBox(
            height: 20,
          ),
          
          Align( //Have Already an account? ==> Login
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
                    const TextSpan(
                      text: "Have Already an account?  ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      
                    ),
                    TextSpan(
                      text: "Log in",
                      style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        Navigator.pushNamed(context, "/login");
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
    ],
   ),
  ),
 );  
}
Future  registerAccount() async{
                    //create account
  var url = Uri.parse(Config.apiURl + Config.registerAPI);
  //var url = Uri.parse("http://localhost:8080/api/user/register");
  var response = await http.post(url,
                  body: {
                "name"  : _nameTextEditingController.text,
                "email" : _emailTextEditingController.text,
                "phone" : _phoneTextEditingController.text,
                "password" : _passwordTextEditingController.text, 
              });
              
// if condition to check if account already exited or created and if then send user to login page
  if(response.statusCode == 200){
      debugPrint('Response body: ${response.body()}');
      debugPrint("=======================================");
      debugPrint('Response status: ${response.statusCode}');
      
      var body =jsonDecode(response.body());
      debugPrint(body["message"] );
      checkMassage = body["message"] ;
      ///////////////////////////////////////
      SharedPrefs.saveToken(body["data"]);

       if(checkMassage == "Email Already Exists"){
          debugPrint(checkMassage);
          FormHelper.showSimpleAlertDialog(
            context, 
            Config.appName,
            "Account Already Exists",
            "Ok", 
            (){
              Navigator.pop(context);  
              },);
        }
        else if(checkMassage == "Success : User registered !!!"){
          debugPrint(checkMassage);
          FormHelper.showSimpleAlertDialog(
            context, 
            Config.appName,
            "Account created ! Now Press OK to login",
            "Ok", 
            (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login_page()));
            },
          );
        } else {
            debugPrint("try again");
            FormHelper.showSimpleAlertDialog(
            context, 
            Config.appName,
            "Data can not be Empty Or an error has ouccerd please try again [Ensure that you insert ther right data with the right requirments]",
            "Ok", 
            (){
                Navigator.pop(context);
            },
          );}
    }else{
      debugPrint("account not created ====");
      var body =jsonDecode(response.body());
      debugPrint(body["massage"]);
      }


} 
}
