// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/fetchAddRequestData.dart';
import 'package:gimme/Api/Models/fetchAddRequestData.dart';
import 'package:gimme/Api/fetchDataAPIRequest.dart';
import 'package:gimme/Google_maps/googleMap.dart';
import 'package:gimme/widget/customInputTextField.dart';
import 'package:gimme/main.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:snippet_coder_utils/hex_color.dart';

//final GoogleMaps x = GoogleMaps(); 

class AddRequest extends StatefulWidget {
//  const AddRequest({Key? key}) : super(key: key);
  
  @override
  _AddRequestState createState() =>_AddRequestState();  
}

class _AddRequestState extends State<AddRequest>{

  //final TextEditingController _toTextEditingController= TextEditingController();  
  //final TextEditingController _fromTextEditingController= TextEditingController();

  final TextEditingController _titleTextEditingController= TextEditingController();
  final TextEditingController _bodyTextEditingController= TextEditingController();
  final TextEditingController _minPricreTextEditingController= TextEditingController();
  final TextEditingController _maxPricreTextEditingController= TextEditingController();
  final TextEditingController _minTimeTextEditingController= TextEditingController();
  final TextEditingController _maxTimeTextEditingController= TextEditingController();

  double ? _minDropDownValue; //value of price
  double ? _mintimeDropDownValue; //value of price

  @override
  void dispose(){
    //_toTextEditingController.dispose();
    //_fromTextEditingController.dispose();
    _bodyTextEditingController.dispose();
    _titleTextEditingController.dispose();
    _minPricreTextEditingController.dispose();
    _maxPricreTextEditingController.dispose();
    _minTimeTextEditingController.dispose();
    _maxTimeTextEditingController.dispose();

    super.dispose();
  }
  //          FetchAddRequestData().fetchAddRequestModel();

   FetchAddRequestData _fetchDataAPIRequest = FetchAddRequestData();

  void iniState(){
    _fetchDataAPIRequest.fetchRequests();
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
    
    Padding( // Need Something && title && body
     padding: const EdgeInsets.only(right: 10 , left: 10),
  
     child: Container( //
     width: MediaQuery.of(context).size.width/1,
     height: MediaQuery.of(context).size.height/4,          
     decoration: const BoxDecoration(  
     /*borderRadius:  BorderRadius.only(
      
      topRight: Radius.circular(25)),*/
      color: Colors.white,
      ),  
     child: Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     const Padding(    //Need Something field
     padding:  EdgeInsets.all(10.0),
     child:  Text("Need Something..!!! , Put here" ,
     style: TextStyle(
     color: Colors.black,
     fontWeight: FontWeight.bold,
     fontSize: 20 ,
    ),
   ),
 ),

    SizedBox(          //title
    width: MediaQuery.of(context).size.width,
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
            child: CustomInputTextFieldWidget(hintText: "title",
            secure: false,ccontroller: _titleTextEditingController, 
            icon: Icons.update,),
          ),
         ),
       ),
     ]),
    ),
    
    SizedBox(          //body
    width: MediaQuery.of(context).size.width,
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
            child: CustomInputTextFieldWidget(hintText: "body",
            secure: false,ccontroller: _bodyTextEditingController, 
          ),
         ),
        ),
       ),
     ]),
    ),
   ]
  ),
 ),
 ),
    
    Padding(//price range
     padding: const EdgeInsets.only(right: 10 , left: 10),
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height / 10 ,    
       decoration: const BoxDecoration(
       color: Colors.white,
      ),  

    child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,         
    children: [
     Container(   //Choose the delivery price.     
      width: MediaQuery.of(context).size.width/2.7,  //**delivery price Word width**
      decoration: const BoxDecoration(  //from-to box decoration 
      color:Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("the delivery price range..." , style: TextStyle(color: Colors.black, fontSize: 20 , fontWeight: FontWeight.bold),),
    ),
  ),
                          //function implementaion min & max must be int 
     Container( // price min
       width: MediaQuery.of(context).size.width/5,     //** price width it self **
       child:Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [  //min Price

       Padding(   //min
         padding: const EdgeInsets.only(right: 10 ,),
         child: Container( 
            decoration: BoxDecoration(
                color: HexColor("#E5E5E5"),
                borderRadius: BorderRadius.only(  
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),  
                  
                )
                /// contin...
            ),
            child: Padding(
              padding: const EdgeInsets.only( right: 10, left: 10 , bottom: 9),
              child: CustomInputTextFieldWidget(hintText: "min",
              secure: false,ccontroller: _minPricreTextEditingController, 
              ),
            ),
         ),
       ),
     ]),
    ),
    
     Container( // price max
       width: MediaQuery.of(context).size.width/5,     //** price width it self **
       child:Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [  //max Price

       Padding(   //max
         padding: const EdgeInsets.only(left: 10),
         child: Container( 
            decoration: BoxDecoration(
                color: HexColor("#E5E5E5"),
                borderRadius: BorderRadius.only(  
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),  
                  
                )
                /// contin
            ),
            child: Padding(
              padding: const EdgeInsets.only( right: 10, left: 10 , bottom: 9),
              child: CustomInputTextFieldWidget(hintText: "max",
              secure: false,ccontroller: _maxPricreTextEditingController, 
              ),
            ),
         ),
       ),
     ]),
    ),

/*
      Container( // price DropdownButton
       width: MediaQuery.of(context).size.width/3,
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
    */
    ],
   ),
  ),       
 ),
 ),

    Padding(// Time range
     padding: const EdgeInsets.only(right: 10 , left: 10),
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height / 10 ,    
       decoration: const BoxDecoration(
       color: Colors.white,
      ),  

    child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,         
    children: [
     Container(   //Choose the delivery price.     
      width: MediaQuery.of(context).size.width/2.7,  //**delivery price Word width**
      decoration: const BoxDecoration(  //from-to box decoration 
      color:Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Delivery Time range..." , style: TextStyle(color: Colors.black, fontSize: 20 , fontWeight: FontWeight.bold),),
    ),
  ),
                          //function implementaion min & max must be int 
     Container( // price min
       width: MediaQuery.of(context).size.width/5,     //** price width it self **
       child:Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [  //min && mas
     Padding(   //min Time
         padding: const EdgeInsets.only(right: 10 ,),
         child: Container( 
            decoration: BoxDecoration(
                color: HexColor("#E5E5E5"),
                borderRadius: BorderRadius.only(  
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),  
                  
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only( right: 10, left: 10 , bottom: 9),
              child: CustomInputTextFieldWidget(hintText: "min",
              secure: false,ccontroller: _minTimeTextEditingController, 
              ),
            ),
         ),
       ),]),
    ),

     Container(  //max Time
       width: MediaQuery.of(context).size.width/5,     //** price width it self **
       child:Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [  //max Price

       Padding(   //max
         padding: const EdgeInsets.only(left: 10),
         child: Container( 
            decoration: BoxDecoration(
                color: HexColor("#E5E5E5"),
                borderRadius: BorderRadius.only(  
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),  
                  
                )
                /// contin
            ),
            child: Padding(
              padding: const EdgeInsets.only( right: 10, left: 10 , bottom: 9),
              child: CustomInputTextFieldWidget(hintText: "max",
              secure: false,ccontroller: _maxTimeTextEditingController, 
              ),
            ),
         ),
       ),
     ]),
    ),
    ],
   ),
  ),       
 ),
 ),

// if design want dragdrop buttom
/*
    Padding(//dopr down button to choose  time range
     padding: const EdgeInsets.only(right: 10 , left: 10),
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height / 12 ,    
       decoration: const BoxDecoration(
       color: Colors.white,
      ),  

    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.center,         
      children: [

      Container(                 
        width: MediaQuery.of(context).size.width/1.9,
        decoration: const BoxDecoration(  //from-to box decoration 
        color:Colors.white,
      ),
      child: const Text("Delivery range time ..." , style: TextStyle(color: primaryColor, fontSize: 16 , fontWeight: FontWeight.bold),),
    ),

      //SizedBox(      width: MediaQuery.of(context).size.width/8,),           
      
      
         Container( // time range DropdownButton
         width: MediaQuery.of(context).size.width/3,
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
      
    ],
   ),
  ),       
 ),
 ),
*/
    Padding(   
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
        
      SizedBox(
         width: MediaQuery.of(context).size.width*0.1),
      
      Container(      //from
        height: MediaQuery.of(context).size.height*0.05,
        width: MediaQuery.of(context).size.width*0.25,  
        
        child:TextButton(onPressed: () async{
          
        
          /*Position position = await _getGeoLocationPosition();
          location ='Lat: ${position.latitude} , Long: ${position.longitude}';
          GetAddressFromLatLong(position);

          //GoogleMaps();
          print("hi");



          
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
        child: Text("Get Location" , style: TextStyle(color:Colors.white, fontSize:20,),),
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
      child: FlatButton(onPressed: () async{
        //Calling fetchAddRequest() function here

        FetchAddRequestData().fetchRequests();

        debugPrint(prefs.getString("token") as String);
          Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String);
          print(payload['_id']);   

        //  debugPrint() ;

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

    SizedBox(height : 100),
////////////////////////////////////
/*Center(
  child: Text(prefs.getString("token") as String),                
),*/
    ],    
   ),
  );
 }
}















/* */