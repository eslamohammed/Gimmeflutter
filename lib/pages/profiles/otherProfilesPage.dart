// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gimme/Api/Models/requestModel.dart';


import 'package:gimme/main.dart';
import 'package:gimme/requestItem/requestItem.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gimme/config.dart';


class OthersProfilePages extends StatelessWidget {
    final RequestItem _fetchRequest = RequestItem();

  final userName;
  final rate;
  final isTrusted;
  final creationTime;
  
  OthersProfilePages(
    this.userName,
    this.rate,
    this.isTrusted,
    this.creationTime
  );
  double rating =0 ;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
     
     body:  _profilePageUI( context),
    ),
  );
  }

  Widget _profilePageUI(BuildContext context){
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
/*
                  TextButton(
                      child:const Text("Edit profile",style: TextStyle(fontSize: 17.5, color: Colors.white ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                      onPressed: (){
                      },
                      style: ButtonStyle(
                        //maximumSize: Size.infinite,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.0),
                          side: const BorderSide(color: Colors.white),
                        ),
                      )
                    ),
                  ),
                */
                ],
              ),
            ),
          ],
        ),
        SizedBox(height:MediaQuery.of(context).size.height*0.04 ,),
        Center(child: Text("${userName}",style:  TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold))),
        //@:${myAcc.email}
        Center(child: Text("Mail : {user.email}\nPhone : {user.phone}",style:  TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))),
        SizedBox(height:MediaQuery.of(context).size.height*0.02 ,),
        Stack(//rating
          children: [
            Transform.translate(
              offset: const Offset(1,1),
              child: Column(
                children: [
                  Text("Rating: ${rate}",style:  TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                  RatingBar.builder(
                    minRating: 1,
                    itemSize: 35 ,
                    itemBuilder: (context,_)=>Icon(Icons.star, color: Colors.amber,),
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
        Center(child: Text(" Creation time Joind at : ${creationTime}",style:  TextStyle(fontSize: 20, color: Colors.black,))),
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
                    text:"\t\t${userName} :",
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
              Center(child: Text(" ${userName} Requests :",style:  TextStyle(fontSize: 29, color: Colors.black,fontWeight: FontWeight.bold))),
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
                requests.add(RequestModel.fromJson(body)); 
                
                int x =0;
                for (var r in requests[0].data) {
                x++;
                }
                //print(r);
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
                      itemCount:x ,
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
                          requests[0].data[index]["timeRange"]["unit"] ,
                          userName
                        );
                      }
                    ):Container()
                  );
                }
              } 
                return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
              } 
            ),
          ),
        )
      ],
    );

  }

   Future<void> _refresh() async {
    return Future.delayed(
      Duration(seconds: 2)
    );
  }
}