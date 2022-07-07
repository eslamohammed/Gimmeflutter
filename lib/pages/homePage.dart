

// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gimme/Api/request/fetchRequest.dart';
import 'package:gimme/Models/profileModel.dart';
import 'package:gimme/Models/requestModel.dart';

import 'package:gimme/main.dart';
import 'package:gimme/controller/HomeController.dart';
import 'package:gimme/Api/user/fetchAccountsData.dart';
import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:gimme/widget/Cards/requestItem.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class Home extends StatefulWidget {  
  @override
  _HomeState createState() =>_HomeState();  

}
class _HomeState extends State<Home>{
    final FetchAccounts _fetchMyAccount = FetchAccounts();

    FetchRequest _fetchRequest = FetchRequest();

  @override
  void initState() {
    _fetchRequest.fetchRequests();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 65,
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
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder(
            //initialData: [ _fetchRequest.fetchRequests(getUserID())],
            future: _fetchRequest.fetchRequests(),
            builder: (context , snapshot){
              if(snapshot.hasData){
              http.Response res = snapshot.data as http.Response;
              var body = jsonDecode(res.body()); 
              if(body["data"].isEmpty){
                  return  Center(child: Column(
                    children: [
                      Text("\n\n\n\n\n\n\nNO Request exist\nAdd one first", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),),
                      Container(child: ElevatedButton(child: Text("log out"),
                      onPressed: () async => {
                        await prefs.remove('token'), //remove token
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login_page()
                          )
                        ),
                      },
                      ),),
                    ],
                  ));
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
                        return RefreshIndicator(
                          onRefresh: _refresh,
                          child: FutureBuilder(
                            future: _fetchMyAccount.fetchMyAccount(),
                            builder: (context , snapshot){
                              if(snapshot.hasData){
                                http.Response res = snapshot.data as http.Response;
                                ProfileModel myAcc;
                                var body = jsonDecode(res.body());
                                myAcc = ProfileModel.fromJson(body);
                                //print("hallo its my name ${myAcc.name}");
                                switch(snapshot.connectionState){                        
                                  case ConnectionState.waiting:
                                    return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                                    
                                  case ConnectionState.none:
                                    return const Center(child: Text("Error in connection"),);
                        
                                  case ConnectionState.active:
                                    return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                        
                                  case ConnectionState.done:
                                  return RequestItem( //sending data to request card
                                    index,
                                    requests[0].data[index]['body'].toString(),
                                    requests[0].data[index]['title'].toString(),
                                    requests[0].data[index]['_id'].toString(),
                                    requests[0].data[index]["timeRange"]["val"] ,
                                    requests[0].data[index]["priceRange"]["min"],
                                    requests[0].data[index]["priceRange"]["max"],
                                    requests[0].data[index]["timeRange"]["unit"] ,
                                    requests[0].data[index]["fromAddress"] ,
                                    requests[0].data[index]["toAddress"] ,
                                    requests[0].data[index]['userId'],
                                    myAcc.name,
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
                          ),
                        );
                        /*RequestItem().requestCard( //sending data to request card
                          context,
                          index,
                          requests[0].data[index]['body'].toString(),
                          requests[0].data[index]['title'].toString(),
                          requests[0].data[index]['_id'].toString(),
                          requests[0].data[index]["timeRange"]["val"] ,
                          requests[0].data[index]["priceRange"]["min"],
                          requests[0].data[index]["priceRange"]["max"],
                          requests[0].data[index]["timeRange"]["unit"] ,
                          "My Account",
                        );*/
                      }
                    ):Container()
                  );
                }
              }
            } 
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
          ),
        ),
      )
    ),
  ); 
}

  Future<void> _refresh() async {
    setState(() {});
    return Future.delayed(
      const Duration(seconds: 1)
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

