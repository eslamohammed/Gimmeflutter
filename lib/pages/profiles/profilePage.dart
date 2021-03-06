// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gimme/Api/request/fetchRequest.dart';
import 'package:gimme/Models/profileModel.dart';
import 'package:gimme/Models/requestModel.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gimme/pages/profiles/editProfile.dart';
import 'package:gimme/Api/user/fetchAccountsData.dart';
import 'package:gimme/widget/Cards/onRequestICard.dart';
import 'package:gimme/widget/Cards/requestItem.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class ProfilePages extends StatefulWidget {  
  @override
  _ProfilePagesState createState() =>_ProfilePagesState();  

}


class _ProfilePagesState extends State< ProfilePages >{

  double rating =0 ;

  final FetchAccounts _fetchMyAccount = FetchAccounts();
  final FetchAccounts _fetchOthersAccount = FetchAccounts();

  final FetchRequest _fetchRequest = FetchRequest();
  List <RequestModel> requests = [] ;


  @override
  void initState() {
    _fetchMyAccount.fetchMyAccount();
    _fetchRequest.fetchRequests();
    _fetchRequest.fetchMyOnFulfilledRequests();
    _fetchRequest.fetchMyOwnerRequests();
    _fetchRequest.fetchMyOnRequests();
    _fetchRequest.fetchMyOnClosedRequests();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
   
   body: _profilePageUI(context),
   );
}

Widget _profilePageUI(BuildContext context){
  return SafeArea(
    child: RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _fetchMyAccount.fetchMyAccount(),
              builder: (context , snapshot){
                if(snapshot.hasData){
                  http.Response res = snapshot.data as http.Response;
                  ProfileModel myAcc;
                  var body = jsonDecode(res.body());
                  myAcc = ProfileModel.fromJson(body);
                  switch(snapshot.connectionState){                        
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                      
                    case ConnectionState.none:
                      return const Center(child: Text("Error in connection"),);
            
                    case ConnectionState.active:
                      return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
            
                    case ConnectionState.done:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
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
                            Transform.translate( //profile photo && Edit profile
                              offset: Offset(
                                MediaQuery.of(context).size.height*0.165,
                                MediaQuery.of(context).size.height*0.125,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.values[2],
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
                                  Container(//Just for UI 
                                    width: MediaQuery.of(context).size.height*0.05,
                                  ),
                                  TextButton(
                                      child:const Text("Edit profile",style: TextStyle(fontSize: 17.5, color: Colors.white ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                      onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(myAcc.name,myAcc.email,myAcc.phone,myAcc.createTime))),
    
                                      style: ButtonStyle(
                                        //maximumSize: Size.infinite,
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(17.0),
                                          side: const BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:MediaQuery.of(context).size.height*0.04 ,),
                        Center(child: Text("${myAcc.name}",style:  const TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold))),
                        //@:${myAcc.email}
                        Center(child: Text("Mail : ${myAcc.email}\nPhone : ${myAcc.phone}",style:  const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))),
                        SizedBox(height:MediaQuery.of(context).size.height*0.02 ,),
                        Stack(//rating
                          children: [
                            Transform.translate(
                              offset: const Offset(1,1),
                              child: Column(
                                children: [
                                  Text("Rating: $rating",style:  const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                                  RatingBar.builder(
                                    minRating: 1,
                                    itemSize: 35 ,
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
                        Center(child: Text(" Creation time Joind at : ${myAcc.createTime}",style:  const TextStyle(fontSize: 20, color: Colors.black,))),
                        SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
                
                        Row(//my Requests & This is my profile Requests
                        children: [
                          Container(//profile photo
                            width: MediaQuery.of(context).size.height*0.065,
                            height: MediaQuery.of(context).size.height*0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              image: const DecorationImage(image: NetworkImage(Config.ImageURL,),
                              )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.values[0],
                            children: [
                              RichText(//username
                              text : TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: <TextSpan>[    
                                  TextSpan(
                                    text:"\t\t${myAcc.name} :",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: MediaQuery.of(context).size.height*0.005,),
                              const Center(child: Text(" This is my Requests :",style:  TextStyle(fontSize: 29, color: Colors.black,fontWeight: FontWeight.bold))),
                              const Center(child: Text("  Request that created by [me] user before",style:  TextStyle(fontSize: 17.5, color: Colors.black,fontWeight: FontWeight.bold))),

                            ],
                          ),
                        ],
                        ),
                        SizedBox(//my Requests
                          height:MediaQuery.of(context).size.height*0.33 ,
                          child: RefreshIndicator(
                            onRefresh: _refresh,
                            child: FutureBuilder(
                              //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                              future: _fetchRequest.fetchRequests(),
                              builder: (context , snapshot){
                                if(snapshot.hasData){
                                http.Response res = snapshot.data as http.Response;
                                List <RequestModel> requests = [] ;
                                var body = jsonDecode(res.body());
                                if(body["data"].isEmpty){
                                  return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                                }else{ 
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
                                        scrollDirection: Axis.horizontal,
                                        itemCount:requests[0].data.length ,
                                        itemBuilder: (context , index){
                                          return  RequestItem( //sending data to request card
                                            index,
                                            requests[0].data[index]['body'].toString(),
                                            requests[0].data[index]['title'].toString(),
                                            requests[0].data[index]['_id'].toString(),
                                            requests[0].data[index]["timeRange"]["val"] ,
                                            requests[0].data[index]["priceRange"]["min"],
                                            requests[0].data[index]["priceRange"]["max"],
                                            requests[0].data[index]["timeRange"]["unit"] ,
                                            requests[0].data[index]["fromAddress"],
                                            requests[0].data[index]["toAddress"],
                                            requests[0].data[index]['userId'],
    
                                            myAcc.name
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
                        ),
                        //////////////////////////////
                        //////////////////////////////
                        //////////////////////////////
                        //////////////////////////////
                        Row(//This is my on Requests
                        children: [
                          Container(//profile photo
                            width: MediaQuery.of(context).size.height*0.065,
                            height: MediaQuery.of(context).size.height*0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              image: const DecorationImage(image: NetworkImage(Config.ImageURL,),
                              )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.values[0],
                            children: [
                              RichText(//username
                              text : TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: <TextSpan>[    
                                  TextSpan(
                                    text:"\t\t${myAcc.name} :",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: MediaQuery.of(context).size.height*0.005,),
                              const Center(child: Text(" This is my on Requests :",style:  TextStyle(fontSize: 29, color: Colors.black,fontWeight: FontWeight.bold))),
                              const Center(child: Text("  Request that Commented by me",style:  TextStyle(fontSize: 17.5, color: Colors.black,fontWeight: FontWeight.bold))),

                            ],
                          ),
                        ],
                        ),
                        SizedBox(//my Commented request 
                          height:MediaQuery.of(context).size.height*0.33 ,
                          child: FutureBuilder(
                            //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                            future: _fetchRequest.fetchMyOnRequests(),
                            builder: (context , snapshot){
                              if(snapshot.hasData){
                              http.Response res = snapshot.data as http.Response;
                              List <RequestModel> requests = [] ;
                              var body = jsonDecode(res.body());
                              //print(body);
                              if(body["data"].isEmpty){
                                return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                              }else{ 
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
                                      scrollDirection: Axis.horizontal,
                                      itemCount:requests[0].data.length ,
                                      itemBuilder: (context , index){
                                        return FutureBuilder(
                                          //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                                          future:  _fetchOthersAccount.fetchOthersAccount(requests[0].data[index]['userId']),
                                          builder: (context , snapshot){
                                            if(snapshot.hasData){
                                            http.Response res = snapshot.data as http.Response;
                                              var body = jsonDecode(res.body());
                                              //print(body["data"]["name"]);
                                              print("Done..");
    
                                            if(body["data"].isEmpty){
                                              return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                                            }else{ 
                                              switch(snapshot.connectionState){                        
                                                case ConnectionState.waiting:
                                                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                                  
                                                case ConnectionState.none:
                                                  return const Center(child: Text("Error in connection"),);
                                          
                                                case ConnectionState.active:
                                                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                          
                                                case ConnectionState.done:
                                                return OnRequestCard( //sending data to request card
                                                  index,
                                                  requests[0].data[index]['body'].toString(),
                                                  requests[0].data[index]['title'].toString(),
                                                  requests[0].data[index]['_id'].toString(),
                                                  requests[0].data[index]["timeRange"]["val"] ,
                                                  requests[0].data[index]["priceRange"]["min"],
                                                  requests[0].data[index]["priceRange"]["max"],
                                                  requests[0].data[index]["timeRange"]["unit"] ,
                                                  requests[0].data[index]["fromAddress"],
                                                  requests[0].data[index]["toAddress"],
                                                  requests[0].data[index]['userId'],
    
                                                  body["data"]["name"],
                                                  "4.7",
                                                  body['data']['isTrusted'],
                                                  body['data']['createTime'],
    
                                                  0,
                                                  requests[0].data[index]["mod"]
                                                  );
                                                }
                                              }
                                            } 
                                              return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                          } 
                                        ); /*RequestItem( //sending data to request card
                                          index,
                                          requests[0].data[index]['body'].toString(),
                                          requests[0].data[index]['title'].toString(),
                                          requests[0].data[index]['_id'].toString(),
                                          requests[0].data[index]["timeRange"]["val"] ,
                                          requests[0].data[index]["priceRange"]["min"],
                                          requests[0].data[index]["priceRange"]["max"],
                                          requests[0].data[index]["timeRange"]["unit"] ,
                                          requests[0].data[index]["fromAddress"],
                                          requests[0].data[index]["toAddress"],
                                          requests[0].data[index]['userId'],
    
                                          body["data"]["name"]
                                        );
                                      */
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
                        //////////////////////////////
                        //////////////////////////////
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Divider(color: primaryColor,),
                        ),
                        //////////////////////////////
                        //////////////////////////////
                        Row(//This is my on [Closed] Requests
                        children: [
                          Container(//profile photo
                            width: MediaQuery.of(context).size.height*0.065,
                            height: MediaQuery.of(context).size.height*0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              image: const DecorationImage(image: NetworkImage(Config.ImageURL,),
                              )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.values[0],
                            children: [
                              RichText(//username
                              text : TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: <TextSpan>[    
                                  TextSpan(
                                    text:"\t\t${myAcc.name} :",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: MediaQuery.of(context).size.height*0.005,),
                              const Center(child: Text(" This is my on [Closed] Requests :",style:  TextStyle(fontSize: 29, color: Colors.black,fontWeight: FontWeight.bold))),
                              const Center(child: Text("  Request that Accept/closed by me",style:  TextStyle(fontSize: 17.5, color: Colors.black,fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(//Closed Requests 
                          height:MediaQuery.of(context).size.height*0.33 ,
                          child: RefreshIndicator(
                            onRefresh: _refresh,
                            child: FutureBuilder(
                              //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                              future: _fetchRequest.fetchMyOwnerRequests(),
                              builder: (context , snapshot){
                                if(snapshot.hasData){
                                http.Response res = snapshot.data as http.Response;
                                List <RequestModel> requests = [] ;
                                var body = jsonDecode(res.body());
                                print("object");
                                //print(body["data"][0]["mod"]);
                                if(body["data"].isEmpty){
                                  return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                                }else{ 
                                  requests.add(RequestModel.fromJson(body)); 
                                  //print(requests[0].data[0]["mod"]);
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
                                        scrollDirection: Axis.horizontal,
                                        itemCount:requests[0].data.length ,
                                        itemBuilder: (context , index){
                                          return FutureBuilder(
                                            //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                                            future:  _fetchOthersAccount.fetchOthersAccount(requests[0].data[index]['userId']),
                                            builder: (context , snapshot){
                                              if(snapshot.hasData){
                                              http.Response res = snapshot.data as http.Response;
                                                var body = jsonDecode(res.body());
                                                //print(body["data"]["name"]);
                                                print("Done..");
                                                print(body["data"]);
                                                //print(body["data"][0]["mod"]);
                                              if(body["data"].isEmpty){
                                                return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                                              }else{ 
                                                switch(snapshot.connectionState){                        
                                                  case ConnectionState.waiting:
                                                    return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                                    
                                                  case ConnectionState.none:
                                                    return const Center(child: Text("Error in connection"),);
                                            
                                                  case ConnectionState.active:
                                                    return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                            
                                                  case ConnectionState.done:
                                                  return OnRequestCard( //sending data to request card
                                                    index,
                                                    requests[0].data[index]['body'].toString(),
                                                    requests[0].data[index]['title'].toString(),
                                                    requests[0].data[index]['_id'].toString(),
                                                    requests[0].data[index]["timeRange"]["val"] ,
                                                    requests[0].data[index]["priceRange"]["min"],
                                                    requests[0].data[index]["priceRange"]["max"],
                                                    requests[0].data[index]["timeRange"]["unit"] ,
                                                    requests[0].data[index]["fromAddress"],
                                                    requests[0].data[index]["toAddress"],
                                                    requests[0].data[index]['userId'],
    
                                                    body["data"]["name"],
                                                    "4.7",
                                                    body['data']['isTrusted'],
                                                    body['data']['createTime'],
    
                                                    1,  //filter
                                                    requests[0].data[index]["mod"]
                                                    );
                                                  }
                                                }
                                              } 
                                                return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                            } 
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
                        ),
                        //////////////////////////////
                        //////////////////////////////
                        Row(//This is my on [Fulfilled] Requests
                        children: [
                          Container(//profile photo
                            width: MediaQuery.of(context).size.height*0.065,
                            height: MediaQuery.of(context).size.height*0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              image: const DecorationImage(image: NetworkImage(Config.ImageURL,),
                              )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.values[0],
                            children: [
                              RichText(//username
                              text : TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: <TextSpan>[    
                                  TextSpan(
                                    text:"\t\t${myAcc.name} :",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: MediaQuery.of(context).size.height*0.005,),
                              const Center(child: Text(" This is my on [Fulfilld] Requests :",style:  TextStyle(fontSize: 29, color: Colors.black,fontWeight: FontWeight.bold))),
                              const Center(child: Text("  Requests that has Commented by me and \n  Accept/closed by other",style:  TextStyle(fontSize: 17.5, color: Colors.black,fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(//Closed Requests 
                          height:MediaQuery.of(context).size.height*0.33 ,
                          child: RefreshIndicator(
                            onRefresh: _refresh,
                            child: FutureBuilder(
                              //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                              future: _fetchRequest.fetchMyOnFulfilledRequests(),
                              builder: (context , snapshot){
                                if(snapshot.hasData){
                                http.Response res = snapshot.data as http.Response;
                                List <RequestModel> requests = [] ;
                                var body = jsonDecode(res.body());
                                print(body);
                                if(body["data"].isEmpty){
                                  return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                                }else{ 
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
                                        scrollDirection: Axis.horizontal,
                                        itemCount:requests[0].data.length ,
                                        itemBuilder: (context , index){
                                          return FutureBuilder(
                                            //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                                            future:  _fetchOthersAccount.fetchOthersAccount(requests[0].data[index]['userId']),
                                            builder: (context , snapshot){
                                              if(snapshot.hasData){
                                              http.Response res = snapshot.data as http.Response;
                                                var body = jsonDecode(res.body());
                                                //print(body["data"]["name"]);
                                                print("Done..");
    
                                              if(body["data"].isEmpty){
                                                return const Center(child: Text("NO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                                              }else{ 
                                                switch(snapshot.connectionState){                        
                                                  case ConnectionState.waiting:
                                                    return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                                    
                                                  case ConnectionState.none:
                                                    return const Center(child: Text("Error in connection"),);
                                            
                                                  case ConnectionState.active:
                                                    return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                            
                                                  case ConnectionState.done:
                                                  return OnRequestCard( //sending data to request card
                                                    index,
                                                    requests[0].data[index]['body'].toString(),
                                                    requests[0].data[index]['title'].toString(),
                                                    requests[0].data[index]['_id'].toString(),
                                                    requests[0].data[index]["timeRange"]["val"] ,
                                                    requests[0].data[index]["priceRange"]["min"],
                                                    requests[0].data[index]["priceRange"]["max"],
                                                    requests[0].data[index]["timeRange"]["unit"] ,
                                                    requests[0].data[index]["fromAddress"],
                                                    requests[0].data[index]["toAddress"],
                                                    requests[0].data[index]['userId'],
    
                                                    body["data"]["name"],
                                                    "4.7",
                                                    body['data']['isTrusted'],
                                                    body['data']['createTime'],
    
                                                    1,  //filter
                                                    requests[0].data[index]["mod"]
                                                    );
                                                  }
                                                }
                                              } 
                                                return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                            } 
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
                        ),
    
                      ],
                    );
                  }
                } 
                  //return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                  return  Center(child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("\n\nLoading...\n\n",style :TextStyle(fontSize: 20),),
                      const CircularProgressIndicator(backgroundColor: primaryColor,),
                      const Text("\n\n\n\n Please check Your Connection...",style :TextStyle(fontSize: 30),)
                    ],
                  ),
                );
              }
            )
          ],
    
        ),
      ),
    ),
  );
}
  Future<void> _refresh() async {
    setState(() {});
    return Future.delayed(
      const Duration(seconds: 1)
    );
  }















/*
Future fetchRequests(String id) async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

    var url = Uri.parse( Config.apiURl + Config.getRequestAPI + id );      
    http.Response res = await http.get(url, headers: header);
    if (res.statusCode == 200){
      print("success");
      var body = (json.decode(res.body()));
      print("===============================================");
      print("${body}");
    }else{
      print("${res.statusCode}");
    }
}
*/

}