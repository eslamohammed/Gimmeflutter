
// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gimme/Google_maps/googleMap.dart';
import 'package:gimme/main.dart';
import 'package:gimme/pages/Commenets/addComment.dart';
import 'package:gimme/pages/Commenets/showComments.dart';
import 'package:gimme/pages/HomeController.dart';
import 'package:gimme/requestItem/requestItem.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class SearchRequestDetails extends StatefulWidget { 
  final body ;
  final title ;
  final reqID;
  final timerange;
  final minPr;
  final maxPr;
  SearchRequestDetails (this.body, this.title,this.reqID,this.timerange,this.minPr,this.maxPr);// this.id,this.timerange,this.minPr,this.maxPr/* this.from ,this.to*/ );
  
    @override
  SearchRequestDetailsState createState() => SearchRequestDetailsState();
  
}
class  SearchRequestDetailsState extends State<SearchRequestDetails>{

  @override
  void initState(){
    GoogleMapsState().build(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return requestDetails(
      context,
      widget.body,
      widget.title,
      widget.reqID,
      widget.timerange,
      widget.minPr,
      widget.maxPr
    ) ;
 }

 Widget requestDetails(BuildContext context, String body, String title ,String reqID,dynamic timerange,dynamic minPr,dynamic maxPr){
   return Scaffold(
      appBar:  AppBar(
      title:const Text('Request Details' , style: TextStyle(color: Colors.black , fontSize: 50 ,fontWeight: FontWeight.bold),),
      toolbarHeight: 65,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation:0,  
      automaticallyImplyLeading: true,
      leading: TextButton(
      child:const Text("Back",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 22, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
      onPressed: 
        ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()))          
       )   
      ),
     body: Card(
       color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
        ),
        elevation: 6,
        margin: const EdgeInsets.all(11),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              
              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
              
              Container(//title & price
                decoration: const BoxDecoration(color:Colors.white),
                height: MediaQuery.of(context).size.height*0.05,
                width: MediaQuery.of(context).size.width,
                child:Container(
                  decoration: const BoxDecoration(color:Colors.white,),
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width*0.67,
                  child: Row(//title & price Box
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Container(//title
                      decoration: BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.56,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${title} ",style: TextStyle(fontSize: 28, color: Colors.black ,fontWeight: FontWeight.bold), ),
                      ),   //waiting for API data
                      ),
                      Container(//just for UI
                      decoration: const BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.025,),
                      SizedBox(//price
                        height: MediaQuery.of(context).size.height*0.06,
                        width: MediaQuery.of(context).size.width*0.3,
                        child: TextButton(
                          child:Text("price range:           \n[ ${minPr} - ${maxPr} ] EGP " ,style: TextStyle(fontSize: 20, color: Colors.black ,),),
                          //Icon(Icons.ac_unit_sharp), // city name from location
                          onPressed: (){

                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: primaryColor),
                            ),
                          )
                        ),
                       ),
                      ),
                      Container(//just for UI
                      decoration: const BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.02,),
                    ],
                  ),
                ) ,
              ),
              
               const Padding(//just for UI
                 padding: EdgeInsets.all(8.0),
                 child: Divider(color: primaryColor,),
               ),
              
              Container(//body
                decoration: const BoxDecoration(color:Colors.white),
                height: MediaQuery.of(context).size.height*0.125,
                width: MediaQuery.of(context).size.width,
                child:Container(
                  decoration: const BoxDecoration(color:Colors.white,),
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width*0.67,
                  //Text( "//  {reqBody}  ",style: TextStyle(fontSize: 25, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data

                  child:Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text( "//  $body  ",style: TextStyle(fontSize: 25, color: Colors.black , fontWeight: FontWeight.bold),),
                  ),    //waiting for API data
                ) ,
              ),
              
               const Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Divider(color: primaryColor,),
               ),              
              
              Container(//time
                decoration: const BoxDecoration(color:Colors.white),
                height: MediaQuery.of(context).size.height*0.08,
                width: MediaQuery.of(context).size.width,
                child:Container(//time
                  decoration: const BoxDecoration(color:Colors.white,),
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width*0.67,
                  child: Row(//time
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      
                      Padding(//word time
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                        decoration: const BoxDecoration(color:Colors.white),
                        height: MediaQuery.of(context).size.height*0.08,
                        width: MediaQuery.of(context).size.width*0.615,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Time : ",style: TextStyle(fontSize: 40, color: Colors.black ,fontWeight: FontWeight.bold), ),
                        ),   //waiting for API data,
                        ),
                      ),

                      Container(//Just for UI
                      decoration: BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.04,),
                      SizedBox(//timerange
                        height: MediaQuery.of(context).size.height*0.06,
                        width: MediaQuery.of(context).size.width*0.15,
                        child: TextButton(
                          child:Text("${timerange} hour " ,style: TextStyle(fontSize: 20, color: Colors.black ,),),
                          //Icon(Icons.ac_unit_sharp), // city name from location
                          onPressed: (){
                            print(reqID);
                          },
                          style: ButtonStyle(
                            //maximumSize: Size.infinite,
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: primaryColor),
                            ),
                          )
                        ),
                    ),
                      ),
                      Container(//Just for UI
                      decoration: BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.02,),
                    ],
                  ),
                ) ,
              ),
                            
               const Padding(//Just for UI
                 padding: EdgeInsets.all(8.0),
                 child: Divider(color: primaryColor,),
               ),
              
              Container(//location
                decoration: const BoxDecoration(color:Colors.white),
                height: MediaQuery.of(context).size.height*0.30,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Text("  Location ",style: TextStyle(fontSize: 40, color: Colors.black ,fontWeight: FontWeight.bold), ),),   //waiting for API data
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.23,
                        width: MediaQuery.of(context).size.width*0.85,
                        decoration: BoxDecoration(color: HexColor("#BDBDBD"),borderRadius: BorderRadius.circular(17.0),),
                        child: GoogleMapsState().build(context) ,
                        //Text will be replace by  Googlemaps 
                        //will send From & To Locations LatLong Co ordinates here
                        ),
                      ),
                    ],
                  ),
                ),
              
              Container( //add && show Comments
                decoration: BoxDecoration(color:Colors.white),
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [ 
                    /*Padding(//deleteRequest 
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child: FloatingActionButton(
                        child: Icon(Icons.delete,color: Colors.white, ),
                        backgroundColor: primaryColor,
                        onPressed: (){
                          //print(reqID);
                          //deleteRequest(context,reqID); //sending object id to be deleted
                        })
                      ),
                    ),*/

                    SizedBox(//Show Comments
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.4,
                      child: TextButton(
                        child:Text("Show Comments",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.5, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowComments(reqID)),),
                        style: ButtonStyle(
                          //maximumSize: Size.infinite,
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                            side: BorderSide(color: primaryColor,),
                          ),
                        )
                      ),
                    ),
                  ),    
        
                    SizedBox(//Add Comment
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.4,
                      child: TextButton(
                        child: Text("Add Comment",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.5, color: primaryColor ,),), // city name from location
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddComment(reqID)),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                            side: BorderSide(color: primaryColor),
                          ),
                        )
                      ),
                    ),
                  ),
                  ],
                ) ,
              ),              
            
            ],
          ),
        ),
      ),
    );
 }

}