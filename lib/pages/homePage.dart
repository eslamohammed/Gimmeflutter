

// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/requestModel.dart';

import 'package:gimme/main.dart';
import 'package:gimme/pages/HomeController.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../requestItem/requestItem.dart';

class Home extends StatefulWidget {  
  @override
  _HomeState createState() =>_HomeState();  

}
class _HomeState extends State<Home>{
  

  RequestItem _fetchRequest = RequestItem();
  List <RequestModel> requests = [] ;



  @override
  void initState() {
    _fetchRequest.fetchRequests();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 60,
      title:const Text('Home' , style: TextStyle(color: Colors.black , fontSize: 47.5 ,fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation:0,  
      automaticallyImplyLeading: true,
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new , color: primaryColor, size: 35,),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeControllerPage())) ,
       )   
      ),
     body: SafeArea(
       child: SingleChildScrollView(
        child: Column(// 2 Parts search part & qetRequests [result of search]
          children: [
            RefreshIndicator(
              onRefresh: _refresh,
              child: FutureBuilder(
                //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                future: _fetchRequest.fetchRequests(),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                  http.Response res = snapshot.data as http.Response;
                  var body = jsonDecode(res.body()); 
                  if(body["data"].isEmpty){
                      return const Center(child: Text("\n\n\n\n\n\n\nNO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                  }else{
                    List <RequestModel> requests = [] ;
                    requests.add(RequestModel.fromJson(body)); 
                    switch(snapshot.connectionState){                        
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                        
                      case ConnectionState.none:
                        return const Center(child: Text("Error in connection"),);
            
                      case ConnectionState.active:
                        return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
            
                      case ConnectionState.done:
                      return SizedBox(
                        height: 860,
                        width: 800,
                        child : requests.isNotEmpty ? ListView.builder(
                          itemCount:requests[0].data.length ,
                          itemBuilder: (context , index){
                            return  RequestItem().requestCard( //sending data to request card
                              context,
                              index,
                              requests[0].data[index]['body'].toString(),
                              requests[0].data[index]['title'].toString(),
                              requests[0].data[index]['_id'].toString(),
                              requests[0].data[index]["timeRange"]["val"] ,
                              requests[0].data[index]["priceRange"]["min"],
                              requests[0].data[index]["priceRange"]["max"],
                              "My Account",
                            );
                          }
                        ):Container()
                      );
                    }
                  }
                } 
                      return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                } 
              ),
            ),
        ]),
     )),
   );
   
 }

  Future<void> _refresh() async {
    return Future.delayed(
      Duration(seconds: 2)
    );
  }

  String getUserID(){ //method to decode the token
    // To decode the token
    String? token = prefs.getString("token") ;
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    print(payload);                                     // Print the payload
    print(payload['_id']);                              // Print one of its property(example: email):
    /*DateTime? expiryDate = Jwt.getExpiryDate(token);    //   To get expiry date
                                                        //   Note: The return value from getExpiryDate function is nullable.
    debugPrint("the expire date at : $expiryDate");    //Print the expiry date                               
    bool isExpired = Jwt.isExpired(token);              // To check if token is expired

    print(isExpired);
    // Can be used for auth state
    if (!isExpired) {                                   //   Token isn't expired 
      print("token is not Expired") ;              

      } else {                                          //Token is expired
      print("token is not Expired") ;
  }*/
  return payload['_id'] ;
  }

}

/*

// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/fetchRequestOpenModel.dart';
import 'package:gimme/Api/fetchDataAPIRequest.dart';
import 'package:gimme/config.dart';
import 'package:gimme/pages/Home.dart';
import 'package:gimme/pages/addRequest.dart';
import 'package:gimme/widget/Pdrawer.dart';
import 'package:gimme/widget/customInputTextField.dart';
import 'package:gimme/main.dart';


class HomePage extends StatefulWidget {  
  @override
  _HomePageState createState() =>_HomePageState();  

}


class _HomePageState extends State<HomePage>{
   final TextEditingController _searchTextEditingController= TextEditingController();

/*  final TextEditingController _toTextEditingController= TextEditingController();  
  final TextEditingController _fromTextEditingController= TextEditingController();
  final TextEditingController _requestDataTextEditingController= TextEditingController();
*/ 

  void dispose(){
    _searchTextEditingController.dispose();
    super.dispose();
  }
/*  void dispose(){
   /* _toTextEditingController.dispose();
    _fromTextEditingController.dispose();
    _requestDataTextEditingController.dispose();*/
    super.dispose();
  }*/

@override

final FetchDataAPIRequest _fetchDataAPIRequest = FetchDataAPIRequest();

  void iniState(){
    _fetchDataAPIRequest.fetchDataAPIRequest();
    super.initState();

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: primaryColor,
      appBar:  AppBar(
      title: Text(Config.appName),
      centerTitle: true,
      backgroundColor: primaryColor,
     ),
      drawer:PDrawer().widgetBuildDrawer(context),   //
      body:Center(
       child:_homePageUI(context), 
       /*ListView.builder(itemCount: 2,
      itemBuilder: (context, index)
      {
        return addRequestCard();
      }
      ), */
      )
    );
  }
//Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String);
  //print(payload[]);

Widget _homePageUI(BuildContext context){
  return SingleChildScrollView(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.values[3],
    children: [
  //// it will be impelemented later.. 
    
  Padding( //Add Request
   padding: const EdgeInsets.only(right: 10 , top: 10 , bottom: 10),
    child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/5,          
    decoration: const BoxDecoration(   
            color: Colors.white,
            borderRadius:  BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20))
            ),  
    
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.start,
    
     children: [
     Padding(    //Need Something..!!!
     padding: const EdgeInsets.only(top :10.0 , left: 5),
     child: Text("Need Something..!!!" ,
     style: TextStyle(
     color: primaryColor,
     fontWeight: FontWeight.bold,
     fontSize: 15 ,
    ),
   ),
 ),
    
     Padding( //devider
       padding: const EdgeInsets.only(top:3 , bottom: 3 ,right: 20 , left: 5),
       child: Divider(color: primaryColor),
     ),    
  
     Padding( // AddRequest Button
     padding: const EdgeInsets.only(top :5.0),
     child: Center(
     child: FlatButton(onPressed: () {
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddRequest()));
      
      },
     child: Padding(
     padding: const EdgeInsets.all(10),
     child: SizedBox(
     width: MediaQuery.of(context).size.width*0.5,
     child: const Center(
     child: Text("Add Request" , style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:20,),),
    ),
    ),
   ),
    color: primaryColor,
   ),
  ),  
 ),
]),      
/////////////////////////////////////////////////////////////////////////////////////
),
),
   

  Padding(  //search
    padding: const EdgeInsets.only(top: 5,right: 10),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/5,          
      decoration: const BoxDecoration(   
              color: Colors.white,
              borderRadius:  BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25))
              ),  
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,

      children: [
       Padding(
         padding: const EdgeInsets.only(left: 5 , right: 20),
         child: CustomInputTextFieldWidget(hintText: "Search", secure: false, ccontroller: _searchTextEditingController),
       ),
       
       Padding(
         padding: const EdgeInsets.only(top : 10),
         child: Padding(
           padding: const EdgeInsets.only(right: 20 , bottom : 5),
           child: Container(
           decoration: const BoxDecoration(   
                  color: primaryColor,
                  borderRadius:  BorderRadius.all(Radius.circular(10),)
                  ),
           child: 
               FlatButton(onPressed: (){
                 //// take data from _searchTextEditingController then compare it with all data in API to get similar requests
               
               },
              child: const Text("search" , 
              style: TextStyle( color: Colors.white, fontSize: 15 , fontWeight: FontWeight.bold,),),
           ),
      ),
         ),
       ),
    ]),
   ),
  ),    

  ////////////////////////////////////
    
  Padding( //All request here

  padding: const EdgeInsets.only(right: 10 , top: 10 , left: 5  ),
   child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height*5 ,
    decoration: const BoxDecoration(  // box decoration 
            color: Colors.white,
            borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),            
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25))
            ),             
           //posts & requests & comments
    child:Column(    
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    children:  <Widget>[
     
     Padding( // Welcome All Requests is here...
      padding: EdgeInsets.all(8.0),
      child:  Text("Welcome All Requests is here..." ,
      style: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 15 ,
    ),
   ),

),

     Padding( //divider
       padding: const EdgeInsets.only( right: 20),
       child: Divider(color: primaryColor,),
     ),

    /// here [list of requests from Api] it will be designed later
     Container( // here

      child: addRequestCard()
    ),
    /*ListView.builder(itemCount: 2,
      itemBuilder: (context, index)
      {
        return addRequestCard();
      }
      ), */


],
),
       
       
       /* FlatButton(child: Text("eslam" , style: TextStyle(color: Colors.black , fontSize: 50)),
           onPressed: (){
              FetchDataAPIRequest().fetchDataAPIRequest();
            },),*/
       ),
  ),
   
    ////////////////////////////////////

    ],    
  
   ),
  );
  
 }

Widget addRequestCard(){
  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Container(
         width: MediaQuery.of(context).size.width*0.8,
         child: Column(
          children: [
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("datadatadatatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata " ,),
            ),
      
           Card(
            child:Image.network("https://images.unsplash.com/photo-1647960611692-39bb707eacf6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60" , width: 250, height: 250, fit: BoxFit.cover,),
            ),      
          ],
      ),
       ),
    
    
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1647989818649-62012bb4c0bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"),fit: BoxFit.cover)
            ),
           ),
        Text("@username",style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),),

         ],
       ),
    
    ]),
  );
}

}
    /*
     Center(
              child: Center(
                child: FlatButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_page()));
                },
                child: const Text("login page"),
                ),
              ),
            ),
     Center(
              child: Center(
                child: FlatButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Register_page()));
                },
                child: const Text("register page"),
                ),
              ),
            ),
    */
    



 */