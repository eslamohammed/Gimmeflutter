// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gimme/Api/review/addReview.dart';

import 'package:gimme/controller/HomeController.dart';
import 'package:gimme/main.dart';

import 'package:gimme/shared/config.dart';
import 'package:gimme/widget/InputWidet/customInputTextField.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;



class AddReview extends StatefulWidget {
  final reqID;
  const AddReview(this.reqID);

  
 

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  double rating =0 ;

  final TextEditingController _reviewTextEditingController= TextEditingController(); 
  
  @override
  void dispose(){
    _reviewTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return comment(context);
  }

  Widget comment (BuildContext context){
  return  Scaffold(
    appBar:  AppBar(
      toolbarHeight: 75,
    title:const Text('Review' , style: TextStyle(color: Colors.black , fontSize: 40 ,fontWeight: FontWeight.bold),),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation:0,  
    automaticallyImplyLeading: true,
    leading: TextButton(
    child:const Text("Back",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 22, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
    onPressed: ()=> Navigator.pop(context,false),
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
             const Padding(//Add word
                padding:EdgeInsets.only(
                  top: 15,
                  left: 20
                ),
                child: Text("Rate this user: ",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 35, color: Colors.black ,)),
              ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03),
            Center(//rating
              child: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(1,1),
                    child: Column(
                      children: [
                        Text("Rating: $rating",style:  const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold)),
                        RatingBar.builder(
                          minRating: 1,
                          itemSize: 45 ,
                          itemBuilder: (context,_)=>const Icon(Icons.star, color: Colors.amber,),
                          updateOnDrag: true,
                          onRatingUpdate: (rating){
                            //review here
                            this.rating = rating;
                            /*setState(() {
                              this.rating = rating;
                            });*/
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03),
  /*
            const Padding(//price word
              padding:EdgeInsets.only(
                top: 15,
                left: 20
              ),
              child: Text("Price",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25, color: Colors.black ,)),
            ),
                    
            SizedBox(//price
              height: MediaQuery.of(context).size.height*0.112,
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
                    child: CustomInputNumberField(
                      labelText: "price",
                      hintText: "price",
                      controller: _priceTextEditingController, 
                      //icon: Icons.update,
                    //fillColor: Colors.white,
                      ),
                    ),
                  ),
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
                height: MediaQuery.of(context).size.height*0.112,
                width: MediaQuery.of(context).size.width*0.45,
                //height: MediaQuery.of(context).size.height/9 ,
                child: Padding(//time
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
                      child: CustomInputNumberField(
                        labelText:"Time",
                        hintText: "time",
                        controller: _timeTextEditingController, icon: Icons.update,
                      //fillColor: Colors.white,
                        ),
                      )
                    ),
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
                  child: CustomInputTextFieldWidget(
                    labelText:"Unit",
                    hintText: "[w/d/h]",secure: false ,
                    ccontroller: _unitsTextEditingController,
                    fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
  */          
            const Padding(//Add word
                padding:EdgeInsets.only(
                  top: 15,
                  left: 20
                ),
                child: Text("Add a Comment",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 35, color: Colors.black ,)),
              ),
            
            Padding(//review box
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.23,
                width: MediaQuery.of(context).size.width*0.82,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:  Border.all(color: Colors.black ,width:1 ,style: BorderStyle.solid ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:  CustomInputTextFieldWidget(
                  labelText:"Comment",
                  hintText: "Put a Comment ",secure: false,
                  ccontroller: _reviewTextEditingController,
                  fillColor: Colors.white,
                ) ,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.04),
          
            Center(//Add review button
              child: SizedBox(//Show Comments
                height: MediaQuery.of(context).size.height*0.08,
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(
                  child:Text("Add Review",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.5, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                  onPressed: (){
                    try {
                    //addReview function here
                    _addReview(context);
                    Review().addReview(context,_reviewTextEditingController.text,widget.reqID);
                    //debugPrint(widget.reqID);
                    } catch (err) {
                      print(err);
                      FormHelper.showSimpleAlertDialog(
                      context, 
                      "["+Config.appName+"]",
                      "Error: $err\ntry again",
                      "Ok", 
                      (){
                        Navigator.pop(context);
                      },
                    );
                    }
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
          
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
          
            Align(//Don't 
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Don't you need to add Review?  ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: "Go Home",
                          style: TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomeControllerPage()));
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
    ),
    );
  }


Future  _addReview(BuildContext context) async{      
Map<String,String> header = {
   "Authorization":"Bearer " + (prefs.getString("token") as String),
   'Content-type' : 'application/json', 
};
  String bodii = json.encode(
    {
      "comment" : _reviewTextEditingController.text,
      "rate" : 4
    });

  var url = Uri.parse(Config.apiURl+Config.reviewAPI+widget.reqID);
  print(url);
  var response = await http.post(url, body: bodii, headers: header);
      // if condition to check if account already exited or created and if then send user to login page

      if(response.statusCode == 200){
        debugPrint('Response body: ${response.body()}');
        debugPrint("=======================================");
        debugPrint('Response status: ${response.statusCode}');
      var body =jsonDecode(response.body());
        print("${body["status"]}");
        if (body["status"]==true) {
          FormHelper.showSimpleAlertDialog(
              context, 
            "["+Config.appName+"]",
              "${body["message"]}\nSucsses now press Ok and go Back your home",
              "Ok", 
              (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeControllerPage(),),);
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
          var body =jsonDecode(response.body());
          debugPrint("not Forbidden");
          FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "${body["message"]}",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }else if (response.statusCode == 400){
          var body =jsonDecode(response.body());
          debugPrint("not Forbidden");
          FormHelper.showSimpleAlertDialog(
            context, 
          "["+Config.appName+"]",
            "${body["message"]} ",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }else{
        var body =jsonDecode(response.body());
        debugPrint("Faild Message:$body");
        FormHelper.showSimpleAlertDialog(
            context, 
            "["+Config.appName+"]",
            "${body["message"]} ",
            "Ok", 
            (){
              Navigator.pop(context);
            },
          );
      }
  }


}