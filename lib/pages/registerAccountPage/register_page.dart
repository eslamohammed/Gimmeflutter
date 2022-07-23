// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:gimme/main.dart';
import 'package:gimme/utilies/sharedPrefrances/sharedPrefsToken.dart';
import 'package:gimme/widget/InputWidet/customInputNumberField.dart';
import 'package:gimme/widget/InputWidet/customInputPasswordField.dart';
import 'package:gimme/widget/InputWidet/customInputTextField.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class Register_page extends StatefulWidget {
  @override
  _Register_pageState createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _ganderTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _ageTextEditingController =
      TextEditingController();

  //every controller must be disposed (deleted from memory for avoiding memory problems)
  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _ganderTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _ageTextEditingController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(backgroundColor: Colors.white, body: _registerUI(context)),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //Sign Up word in UI & log in
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(//for UI
                    decoration: BoxDecoration(color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  SizedBox(//Sign Up
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(//Log in
                    decoration: BoxDecoration(color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
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
                                  ..onTap = () {
                                    Navigator.pushNamed(context, "/login");
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(// username , email , password , phone... //Register
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.57,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [// username , email , password , phone... //Register
                  Padding(//username
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#E5E5E5"),
                            borderRadius: BorderRadius.circular(10),
                            border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                            /// contin
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomInputTextFieldWidget(
                            labelText:"Enter your name",
                            hintText: "username",
                            secure: false,
                            ccontroller: _nameTextEditingController,
                            icon: Icons.people,
                          ),
                        )),
                  ),

                  Padding(//email
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.circular(10),
                        border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInputTextFieldWidget(
                          labelText: "Enter your email : forExample@email.com",
                          hintText: "email                                                                            forExample@email.com",
                          secure: false,
                          ccontroller: _emailTextEditingController,
                          icon: Icons.email,
                        ),
                      ),
                    ),
                  ),

                  Padding(//phone
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.circular(10),
                        border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInputTextFieldWidget(
                          labelText: "phone +201xxxxxxxxx",
                          hintText: "phone",
                          secure: false,
                          ccontroller: _phoneTextEditingController,
                          icon: Icons.phone,
                        ),
                      ),
                    ),
                  ),

                  Padding(//age
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.circular(10),
                        border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInputNumberField(
                          labelText: "Enter your age",
                          hintText: "age",
                          controller: _ageTextEditingController,
                          //icon: Icons //Icons.phone,
                        ),
                      ),
                    ),
                  ),

                  Padding(//password
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#E5E5E5"),
                        borderRadius: BorderRadius.circular(10),
                        border:  Border.all(color: Colors.black26 ,width:1 ,style: BorderStyle.solid ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInputPasswordField(
                          controller: _passwordTextEditingController,
                        ),
                      ),
                    ),
                  ),

                  Padding(//Register
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: FlatButton(
                        onPressed: () async {//registeration Method
                          try{
                            if (_nameTextEditingController.text.isNotEmpty) {
                              if (_emailTextEditingController.text.isNotEmpty) {
                                if (_phoneTextEditingController.text.isNotEmpty ) {
                                  if (_ageTextEditingController.text.isNotEmpty) {
                                    if (_passwordTextEditingController.text.isNotEmpty) {
                                      _register_user(); //function to add user
                                    } else {
                                      FormHelper.showSimpleAlertDialog(
                                        //location
                                        context,
                                        Config.appName,
                                        "Password id required:\nPassword can not be Empty try again",
                                        "OK",
                                        () {
                                          Navigator.pop(context);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMaps()));
                                        },
                                      );
                                    }
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      //time
                                      context,
                                      Config.appName,
                                      "Age is required:\nAnd can not be Empty try again",
                                      "OK",
                                      () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  }
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    //price
                                    context,
                                    Config.appName,
                                    "Phone number is required:\nPhone number can not be Empty try again",
                                    "OK",
                                    () {
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                              } else {
                                FormHelper.showSimpleAlertDialog(
                                  //body
                                  context,
                                  Config.appName,
                                  "Email is required:\nEmail can not be Empty Anyway try again",
                                  "OK",
                                  () {
                                    Navigator.pop(context);
                                    debugPrint("");
                                  },
                                );
                              }
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                //all data
                                context,
                                Config.appName,
                                "User data is required and can not be Empty press OK to try again",
                                "OK",
                                () {
                                  Navigator.pop(context);
                                  debugPrint("");
                                },
                              );
                            }
                          }
                          catch(err){
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Something Went Woring Be sure that you inserted the right data\n$err",
                              "Ok",
                              () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.5),
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27.5,
                                ),
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
            Align(
              //Have Already an account? ==> Login
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: RichText(
                  text: TextSpan(
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
                            ..onTap = () {
                              Navigator.pushNamed(context, "/login");
                            }),
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

  ///API
  Future _register_user() async {//used
    var url = Uri.parse(Config.apiURl + Config.registerAPI);
    var req_body = new Map();

     req_body["name"]  = _nameTextEditingController.text;
     req_body["email"] = _emailTextEditingController.text;
     req_body["phone"] = _phoneTextEditingController.text;
     req_body["age"] = int.parse(_ageTextEditingController.text) ;
     req_body["password"] = _passwordTextEditingController.text;

  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(req_body),
  );


    if (response.statusCode == 200) {
      var body = jsonDecode(response.body());
      print("Data body : ${body["status"]}");
      print("Data body : ${body}");
      ///////////////////////////////////////
      SharedPrefs.saveToken(body["data"]);
      if (body["status"] == true) {
        FormHelper.showSimpleAlertDialog(
          context,
          Config.appName,
          "${body["message"]}",
          "Ok",
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login_page()));
          },
        );
      } else {
        FormHelper.showSimpleAlertDialog(
          context,
          Config.appName,
          "${body["message"]}",
          "Ok",
          () {
            Navigator.pop(context);
          },
        );
      }
    } else if (response.statusCode == 400) {
      var body = jsonDecode(response.body());
      print("Data body : ${body["status"]}");
      print("Data body : ${body["message"]}");
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Error:${body["message"]["fieldErrors"]}",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    } else {
      var body = jsonDecode(response.body());
      print("Data body : ${body["status"]}");
      print("Data body : ${body["message"]}");
      debugPrint("try again");
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "${body["message"]}",
        "try again",
        () {
          Navigator.pop(context);
        },
      );
    }
}

  Future registerAccount() async {
    ///Register/create account Method
    var url = Uri.parse(Config.apiURl + Config.registerAPI);
    var response = await http.post(url, body: {
        "name": _nameTextEditingController.text,
        "email": _emailTextEditingController.text,
        "phone": int.parse(_phoneTextEditingController.text),
        "age": int.parse(_ageTextEditingController.text),
        "password": _passwordTextEditingController.text,
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body());
      //print("Data body : ${body["status"]}");
      ///////////////////////////////////////
      SharedPrefs.saveToken(body["data"]);
      if (body["status"] == true) {
        FormHelper.showSimpleAlertDialog(
          context,
          Config.appName,
          "${body["message"]}:\nNow Press OK to login",
          "Ok",
          () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login_page()));
          },
        );
      } else {
        FormHelper.showSimpleAlertDialog(
          context,
          Config.appName,
          "${body["message"]}",
          "Ok",
          () {
            Navigator.pop(context);
          },
        );
      }
    } else if (response.statusCode == 400) {
      var body = jsonDecode(response.body());
      print("Data body : ${body["status"]}");
      print("Data body : ${body["message"]}");
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Error:${body["message"]["fieldErrors"]}",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
    } else {
      debugPrint("try again");
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Data can not be Empty Or an error has ouccerd please try again [Ensure that you insert ther right data with the right requirments]",
        "try again",
        () {
          Navigator.pop(context);
        },
      );
    }
  }
  


}
