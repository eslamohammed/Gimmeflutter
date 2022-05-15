// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/config.dart';
import 'package:gimme/pages/HomeController.dart';
import 'package:gimme/widget/customInputTextField.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../main.dart';
import 'package:http/http.dart' as http;



class AddComment extends StatelessWidget {
  final reqID;
  AddComment(this.reqID);

 /*

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
*/
  final TextEditingController _priceTextEditingController= TextEditingController(); 
  final TextEditingController _timeTextEditingController= TextEditingController(); 
  final TextEditingController _unitsTextEditingController= TextEditingController(); 
  final TextEditingController _commentTextEditingController= TextEditingController(); 
  
  @override
  void dispose(){
    _priceTextEditingController.dispose();
    _timeTextEditingController.dispose();
    _unitsTextEditingController.dispose();
    _commentTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return comment(context);
  }

  Widget comment (BuildContext context){
  return  Scaffold(
    appBar:  AppBar(
      toolbarHeight: 75,
    title:const Text('AddComment' , style: TextStyle(color: Colors.black , fontSize: 40 ,fontWeight: FontWeight.bold),),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation:0,  
    automaticallyImplyLeading: true,
    leading: TextButton(
    child:const Text("Back",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 22, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
    onPressed: ()=>{},
      //()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RequestDetails()))          
      )   
    ),
    body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 

          const Padding(//price word
            padding:EdgeInsets.only(
              top: 15,
              left: 20
            ),
            child: Text("Price",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25, color: Colors.black ,)),
          ),
                  
          SizedBox(//price
            width: MediaQuery.of(context).size.width*0.9,
            //height: MediaQuery.of(context).size.height/9 ,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child : Container(
              decoration:  BoxDecoration(
                border:  Border.all(color: Colors.black ,width:1 ,style: BorderStyle.solid ),
                color: Colors.white,
                borderRadius:  const BorderRadius.only(  
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),  
                  
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomInputTextFieldWidget(hintText: "price",secure: false ,ccontroller: _priceTextEditingController, icon: Icons.update,),
              )),
             ),
            ),
          
          const Padding(//Time word
              padding:EdgeInsets.only(
                top: 15,
                left: 20
              ),
              child: Text("Time",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25, color: Colors.black ,)),
            ),

          Row(//time & units
            children: [
              SizedBox(
            width: MediaQuery.of(context).size.width*0.45,
            //height: MediaQuery.of(context).size.height/9 ,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child : Container(
              decoration:  BoxDecoration(
                border:  Border.all(color: Colors.black ,width:1 ,style: BorderStyle.solid ),
                color: Colors.white,
                borderRadius:  const BorderRadius.only(  
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),  
                  
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomInputTextFieldWidget(hintText: "time",secure: false ,ccontroller: _timeTextEditingController, icon: Icons.update,),
              )),
             ),
            ),
            SizedBox(
            width: MediaQuery.of(context).size.width*0.45,
            //height: MediaQuery.of(context).size.height/9 ,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child : Container(
              decoration:  BoxDecoration(
                border:  Border.all(color: Colors.black ,width:1 ,style: BorderStyle.solid ),
                color: Colors.white,
                borderRadius:  const BorderRadius.only(  
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),  
                  
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomInputTextFieldWidget(hintText: "Uints                  [d/h/min]",secure: false ,ccontroller: _unitsTextEditingController, icon: Icons.update,),
              )),
             ),
            ),
            ],
          ),
          
          const Padding(//Text word
              padding:EdgeInsets.only(
                top: 15,
                left: 20
              ),
              child: Text("Text",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25, color: Colors.black ,)),
            ),
          
          Padding(//text box
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.23,
              width: MediaQuery.of(context).size.width*0.82,
              decoration: BoxDecoration(
                 border:  Border.all(color: Colors.black ,width:1 ,style: BorderStyle.solid ),
                borderRadius: BorderRadius.circular(10.0),),
              child:  CustomInputTextFieldWidget(hintText: "Put some Comment ",secure: false ,ccontroller: _commentTextEditingController,) ,

            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.08),
         
          Center(//Submit button
            child: SizedBox(//Show Comments
              height: MediaQuery.of(context).size.height*0.08,
              width: MediaQuery.of(context).size.width*0.3,
              child: TextButton(
                child:Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.5, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                onPressed: (){
                  //addComment function here
                  _addComment(context);
                print(reqID);
                },
                style: ButtonStyle(
                  //maximumSize: Size.infinite,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                    side: const BorderSide(color: primaryColor,),
                      ),
                    )
                  ),
                ),
              ),
             ),    
          ],
        ),
      ),
    ),
    );
  }


Future  _addComment(BuildContext context) async{      
Map<String,String> header = {
   "Authorization":"Bearer " + (prefs.getString("token") as String),
   'Content-type' : 'application/json', 
};
  String bodii = json.encode(
    {
    "time" : {
        "unit" : _unitsTextEditingController.text,
        "val" : _timeTextEditingController.text
      },
      "price" : _priceTextEditingController.text ,
      "text" : _commentTextEditingController.text
    });

  var url = Uri.parse(Config.apiURl+Config.commentAPI+ reqID);
  var response = await http.post(url, body: bodii, headers: header);
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
        if (body["status"]==true) {
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
              "Faild: ${body["message"]}",
              "Ok", 
              (){
                Navigator.pop(context);
              },
            );
          }
      }else if (response.statusCode == 403){
          debugPrint("not Forbidden");
          FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "Forbidden [MOD is already choosen !!!]",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }else if (response.statusCode == 400){
          debugPrint("not Forbidden");
          FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "Price can't be less than the minimum range",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }else{
        FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "Something went woring, try again",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }
  }

//id=CommentID/RequestID
Future  deleteComment(BuildContext context ,String id) async{ 
  
  Map<String,String> header = { "Authorization":"Bearer " + (prefs.getString("token") as String),};

    var url = Uri.parse(Config.apiURl+Config.commentAPI+ id);
    var response = await http.delete(url , headers: header);

    if(response.statusCode == 200){
    FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      "Success : Comment has been deleted !!!",
      "Ok", 
      (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()));  
    },);
    }else if (response.statusCode == 404){
      FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      "Error ${response.statusCode}: Comment doens't exist ",
      "Ok", 
      (){
      Navigator.pop(context);  
    },);
    }  
  }

}