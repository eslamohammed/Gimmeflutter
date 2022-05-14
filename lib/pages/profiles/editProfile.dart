// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/requestModel.dart';
import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:gimme/widget/customInputTextField.dart';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../Api/Models/requestModel.dart';
import 'package:http/http.dart' as http;


class EditProfile extends StatefulWidget {  
  final name ;
  final email ;
  final phone;
  final createTime;
  EditProfile (this.name, this.email,this.phone,this.createTime);// this.id,this.timerange,this.minPr,this.maxPr/* this.from ,this.to*/ );
  
  @override
  _EditProfileState createState() =>_EditProfileState();  

}


class _EditProfileState extends State< EditProfile >{

  final TextEditingController _userNameTextEditingController= TextEditingController();
  final TextEditingController _passwordTextEditingController= TextEditingController();

  

  @override
  void dispose(){
    _userNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
   
   body: _editProfilePageUI(context),
   );
}

Widget _editProfilePageUI(BuildContext context){
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children:[
                      Container(//background photo
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.3,          
                      decoration: const BoxDecoration(   
                      color: primaryColor,
                      image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1568043210943-0e8aac4b9734?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80")) ,  //DecorationImage(image: NetworkImage(Config.ImageURL,),
                      borderRadius:  BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),  
                      child: const Center(), //photo
                    ),
                    IconButton(//editing profile pic
                      onPressed: () {
                        ///chosse photo using camera picker package
                        ///Waiting to add this feature to Api
                      },
                      icon: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 20.0,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 25.0,
                          )
                        )
                      )
                    ]
                      
                  ),
                  Transform.translate( //profile photo 
                    offset: Offset(
                      MediaQuery.of(context).size.height*0.001,
                      MediaQuery.of(context).size.height*0.125,
                      ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                          Container(//profile photo
                          width: MediaQuery.of(context).size.height*0.125,
                          height: MediaQuery.of(context).size.height*0.125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                            image: const DecorationImage(image: NetworkImage(Config.ImageURL,),
                            )
                          ),
                        ),
                        IconButton(//editing profile pic
                          onPressed: () {
                            ///chosse photo using camera picker package
                            ///Waiting to add this feature to Api
                          },
                          icon: CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 20.0,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                                size: 25.0,
                              )
                            )
                          ),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.04 ,),
              Center(child: Text("${widget.name}",style:  const TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold))),
              //@:${myAcc.email}
              Center(child: Text("Mail : ${widget.email}\nPhone : ${widget.phone}",style:  const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))),
              SizedBox(height:MediaQuery.of(context).size.height*0.02 ,),
              Center(child: Text(" Creation time Joind at : ${widget.createTime}",style:  const TextStyle(fontSize: 20, color: Colors.black,))),
              SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Divider(color: primaryColor,),
              ),
              
              
              Column(//new name
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Padding(
                  padding: EdgeInsets.only(left:30 , top: 10, bottom: 10),
                  child: Text("New name ",style: TextStyle(fontSize: 30, color: Colors.black ,fontWeight: FontWeight.bold), ),),
                  SizedBox(//user name
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(right:50,left: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#E5E5E5"),
                          borderRadius: const BorderRadius.only(  
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),  
                            
                          )
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(12.5),
                      child: CustomInputTextFieldWidget(hintText: "User name [${widget.name}]",
                      secure: false,ccontroller: _userNameTextEditingController, 
                      icon: Icons.update,),
                    ),
                  ),
                ),
              ),
                ]
              ),
              
              Column(//New Password
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Padding(
                  padding: EdgeInsets.only(left:30 , top: 10, bottom: 10),
                  child: Text("New Password",style: TextStyle(fontSize: 30, color: Colors.black ,fontWeight: FontWeight.bold), ),),
                  SizedBox(//user name
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(right:50,left: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#E5E5E5"),
                          borderRadius: const BorderRadius.only(  
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),  
                            
                          )
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(12.5),
                      child: CustomInputTextFieldWidget(hintText: "Password",
                      secure: false,ccontroller: _passwordTextEditingController, 
                      icon: Icons.update,),
                    ),
                  ),
                ),
              ),
                ]
              ),
              
              SizedBox(height:MediaQuery.of(context).size.height *0.04),
              
              Center( //search
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height *0.075,
                
                  decoration: const BoxDecoration(  
                  color: Colors.black12,
                  borderRadius:  BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  )
                ),    

                  child: Center( //Add request button & calling Addrequest() Function function;
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(onPressed: () async{//Calling edit profile() function
                  _editProfile(context ,getUserID());
                  print(getUserID());
                  },
                  child: Padding(//Add Request
                  padding: const EdgeInsets.all(12.5),
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: const Center(
                  child: Text("Submmit Changes" , style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:25,),),
                    ),
                    ),
                  ),
                  color: primaryColor,
                  shape: const StadiumBorder(),
                      ),
                    ),
                  ), 
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

  
Future  _editProfile(BuildContext context , String id) async{      
Map<String,String> header = {
   "Authorization":"Bearer " + (prefs.getString("token") as String),
   'Content-type' : 'application/json', 
};
  String bodii = json.encode(
    {
      "name" : _userNameTextEditingController.text,
      "password" : _passwordTextEditingController.text
  }
  );

  var url = Uri.parse(Config.apiURl+Config.editProfileAPI+id);
  print(url);
  var response = await http.put(url, body: bodii,);
      // if condition to check if account already exited or created and if then send user to login page
      if(response.statusCode == 200){
        print("success");
        print("success $url");
        debugPrint('Response body: ${response.body()}');
        debugPrint("=======================================");
        debugPrint('Response status: ${response.statusCode}');

      var body =jsonDecode(response.body());
      /*
       FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "Success: Comment has been added !!!",
            "Ok", 
            (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeControllerPage()));
            },
          );
       */
        print("${body["status"]}");
        /*if (body["status"]==true) {
          FormHelper.showSimpleAlertDialog(
              context, 
            "["+Config.appName+"]",
              "Success: Comment has been added !!!",
              "Ok", 
              (){
                Navigator.pop(context);
              },
            );
        }else {
          FormHelper.showSimpleAlertDialog(
              context, 
            "["+Config.appName+"]",
              "Faild: You are already commented !!!",
              "Ok", 
              (){
                Navigator.pop(context);
              },
            );}*/

      }else{
        print("not succssed");
        print(response.body());
        print("Status code :${response.statusCode}");
        /*FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "Something worng, try again",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );*/
      }
  }

  
  String getUserID(){ //method to decode the token
    // To decode the token
    String? token = prefs.getString("token") ;
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    //print(payload);                                     // Print the payload
    //print(payload['_id']);                              // Print one of its property(example: email):
  return payload['_id'] ;
  }
  
  
}