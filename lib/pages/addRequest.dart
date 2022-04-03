
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gimme/Api/fetchDataAPIRequest.dart';
import 'package:gimme/Google_maps/googleMap.dart';
import 'package:gimme/config.dart';
import 'package:gimme/widget/customInputTextField.dart';
import 'package:gimme/main.dart';



class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);
  
  @override
  _AddRequestState createState() =>_AddRequestState();  
}

class _AddRequestState extends State<AddRequest>{
  final TextEditingController _toTextEditingController= TextEditingController();  
  final TextEditingController _fromTextEditingController= TextEditingController();
  final TextEditingController _dataBodyTextEditingController= TextEditingController();
  final TextEditingController _titleDataTextEditingController= TextEditingController();
  final TextEditingController _minTextEditingController= TextEditingController();
  final TextEditingController _maxTextEditingController= TextEditingController();

  double ? _minDropDownValue; //value of price

  double ? _mintimeDropDownValue; //value of price


  @override
  void dispose(){
    _toTextEditingController.dispose();
    _fromTextEditingController.dispose();
    _dataBodyTextEditingController.dispose();
    _titleDataTextEditingController.dispose();
    _minTextEditingController.dispose();
    _maxTextEditingController.dispose();
    super.dispose();
  }

  final FetchDataAPIRequest _fetchDataAPIRequest = FetchDataAPIRequest();

  void iniState(){
    _fetchDataAPIRequest.fetchDataAPIRequest();
    super.initState();

  }


  void minDropDownCallback(double? selectedprice){
    if(selectedprice is double){
      setState(() {
        _minDropDownValue = selectedprice ;
      });
    }
  }
  
  void minTimeDropDownCallback(double? selectedprice){
    if(selectedprice is double){
      setState(() {
        _mintimeDropDownValue = selectedprice ;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar:  AppBar(
      title:Text('Add request'),
      backgroundColor: primaryColor,
     ),
      body:Center(
       child:_addRequest(context), 
      )
    );
  }
//Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String);
  //print(payload[]);

Widget _addRequest(BuildContext context){
  return SingleChildScrollView(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    //// it will be impelemented later.. 

    Padding(//logo
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(   
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height /6,
    
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
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Align(  //logo
        alignment : Alignment.center,
        //width: MediaQuery.of(context).size.width/3,
        child: Image.asset("assets/gimmeMoblieApp.png",
        width: 250,
        fit: BoxFit.contain,),
        ), 
    
    Center( // Request Card Word
    child: Container(
    decoration: BoxDecoration(color: primaryColor ,
    borderRadius: BorderRadius.circular(20)),
    
    child: const Padding(
      padding: EdgeInsets.all(7.5),
      child: Text("Request Card" , style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20 ,),),),),)
  ],
  ),
 ),
),
      
    Padding( // Need Something && title && body
     padding: const EdgeInsets.only(right: 10  ,),
  
     child: Container( //
     width: MediaQuery.of(context).size.width/1,
     height: MediaQuery.of(context).size.height/4,          
     decoration: const BoxDecoration(  
     borderRadius:  BorderRadius.only(
      topRight: Radius.circular(25)),
     color: Colors.white, ),  
     child: Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     const Padding(    //Need Something field
     padding:  EdgeInsets.only(top :10.0),
     child:  Text("Need Something..!!! , Put here" ,
     style: TextStyle(
     color: primaryColor,
     fontWeight: FontWeight.bold,
     fontSize: 17.5 ,
    ),
   ),
 ),

     Padding(    //title
      padding: const EdgeInsets.only(left: 15 , right: 15),
      child: CustomInputTextFieldWidget(hintText: "title ",
       secure: false,
       ccontroller:_titleDataTextEditingController, ),
    ),
     
     Padding(    //Requesting
      padding: const EdgeInsets.only(left: 15 , right: 15),
      child: CustomInputTextFieldWidget(hintText: "request body  ",
       secure: false,
       ccontroller:_dataBodyTextEditingController,),
    ),
    ]
   ),
  ),
 ),
    
    Padding(//dopr down button to choose  price range
     padding: const EdgeInsets.only(right: 10 , top: 1),
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height / 11 ,    
       decoration: const BoxDecoration(
       color: Colors.white,
      ),  

    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.center,         
      children: [

      Container(   //Choose the delivery price.     
        width: MediaQuery.of(context).size.width/2,

        decoration: const BoxDecoration(  //from-to box decoration 
        color:Colors.white,
      ),
      child: const Text("Choose the delivery price..." , style: TextStyle(color: primaryColor, fontSize: 16 , fontWeight: FontWeight.bold),),
    ),

      Container( // price DropdownButton
       width: MediaQuery.of(context).size.width/4,
       decoration: BoxDecoration(            
         borderRadius: BorderRadius.circular(50),
         color: primaryColor,         
       ),
      
       child: DropdownButton(items: [
       DropdownMenuItem<double>(child: Text("  20.0 LE"),value: 20.0, ),
       DropdownMenuItem<double>(child: Text("  35.0 LE"),value: 35.0, ),
       DropdownMenuItem<double>(child: Text("  50.0 LE"),value: 50.0, ),
       DropdownMenuItem<double>(child: Text("  70.0 LE"),value: 70.0, ),
       DropdownMenuItem<double>(child: Text("  90.0 LE"),value: 90.0, ),
      ],
        value: _minDropDownValue,
        onChanged: minDropDownCallback,
        iconSize: 20.0,
        iconEnabledColor: Colors.white,
        iconDisabledColor: primaryColor,
        focusColor: primaryColor,
        icon: const Icon(Icons.attach_money_sharp),
        dropdownColor: primaryColor,
        borderRadius: BorderRadius.circular(30),
        isExpanded: true,
        style: TextStyle(color: Colors.white  , fontSize:15 ),
        ),
      ),            
    ],
   ),
  ),       
 ),
 ),

    Padding(//dopr down button to choose  time range
     padding: const EdgeInsets.only(right: 10 , top: 1),
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height / 11 ,    
       decoration: const BoxDecoration(
       color: Colors.white,
      ),  

    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.center,         
      children: [

      Container(                 
        width: MediaQuery.of(context).size.width/2,

        decoration: const BoxDecoration(  //from-to box decoration 
        color:Colors.white,
      ),
      child: const Text("Delivery range time ..." , style: TextStyle(color: primaryColor, fontSize: 16 , fontWeight: FontWeight.bold),),
    ),

      //SizedBox(      width: MediaQuery.of(context).size.width/8,),           
      
      Center(
        child: Container( // time range DropdownButton
         width: MediaQuery.of(context).size.width/4,
         decoration: BoxDecoration(            
           borderRadius: BorderRadius.circular(50),
           color: primaryColor,
           
         ),
        
         child: DropdownButton(items: [
         DropdownMenuItem<double>(child: Text("  30:00   min "),value: 30*60, ),
         DropdownMenuItem<double>(child: Text("  60:00   min "),value: 60*60, ),
         DropdownMenuItem<double>(child: Text("  120:00  min"),value:  2*60*60, ),
         DropdownMenuItem<double>(child: Text("  12:00:00 hour "),value:  12 * 60 * 60, ),
         DropdownMenuItem<double>(child: Text("  1 Day"),value:  24*60*60, ),
        ],
          value: _mintimeDropDownValue,
          onChanged: minTimeDropDownCallback,
          iconSize: 17.0,
          
          iconEnabledColor: Colors.white,
          iconDisabledColor: primaryColor,
          focusColor: primaryColor,
          icon: const Icon(Icons.timer_rounded , color: Colors.white,),

          dropdownColor: primaryColor,
          borderRadius: BorderRadius.circular(30),
          isExpanded: true,
          style: TextStyle(color: Colors.white  , fontSize:15 ),
          ),
 
          ),
      ),
    ],
   ),
  ),       
 ),
 ),
   
    //     crossAxisAlignment: CrossAxisAlignment.center,

    Padding( // add request   
     padding: const EdgeInsets.only(right: 10 ,),
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
    
      decoration: const BoxDecoration(  //from-to box decoration 
      color: Colors.white,),

      child: Center( //from & to
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.75,
        child: Row(
     children: [
     
    SizedBox( width: MediaQuery.of(context).size.width*0.1),
    
    Container(      //from
     height: MediaQuery.of(context).size.height*0.05,
     width: MediaQuery.of(context).size.width*0.25,  
     
      child:TextButton(onPressed: () {
        
        //GoogleMaps();
        print("hi");



        /*
        CupertinoAlertDialog(
          title: Text("Choose Location"),
          content: Text("Current location Or Another on ?"), 
          actions: [
            FlatButton(onPressed: (){}, child: Text("Current location")),
            FlatButton(onPressed: (){}, child: Text("Google map"))
          ],
        );*/
      },
      child: SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      child: const Center(
      child: Text("From" , style: TextStyle(color:Colors.white, fontSize:20,),),
         ),
        ),
       ),
      color: primaryColor,
      ),

    SizedBox( width: MediaQuery.of(context).size.width*0.05),
    
    Container( //to
     height: MediaQuery.of(context).size.height*0.05,
     width: MediaQuery.of(context).size.width*0.25,
     decoration: const BoxDecoration(color:primaryColor,),
      child: const Text("to"),
    ),
    ],
   ),
  ),
 ),
 ), 
),
    
    Padding( // add request   
    padding: const EdgeInsets.only(right: 10 ,),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
    
      decoration: const BoxDecoration(  
      color: Colors.white,
      borderRadius:  BorderRadius.only(
      bottomRight: Radius.circular(25))
    ),    

      child: Center( //Add request button & calling Addrequest() Function function;
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(onPressed: () {
        //Calling fetchAddRequest() function here
      },
      child: Padding(
      padding: const EdgeInsets.all(12.5),
      child: SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      child: const Center(
      child: Text("   Add Request" , style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:25,),),
         ),
        ),
       ),
      color: primaryColor,
      ),
     ),
    ), 
  ),
),
////////////////////////////////////
/*Center(
  child: Text(prefs.getString("token") as String),                
),*/
  ],    
  ),
 );
  
}

double getCurrentLocation( double loc){


  return loc ;
}

double getOtherLocationGMap( double loc){


  return loc ;
}




}



/* */