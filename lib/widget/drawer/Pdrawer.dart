import 'package:flutter/material.dart';
import 'package:gimme/Models/profileModel.dart';


import 'package:gimme/main.dart';
import 'package:gimme/modules/review/addReview.dart';

import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:gimme/modules/notification/notificationPage.dart';
import 'package:gimme/Api/user/fetchAccountsData.dart';
import 'package:gimme/pages/profiles/profilePage.dart';
import 'package:gimme/modules/Payment/PaymentScreen.dart';
import 'package:gimme/pages/qr/qr_create_page.dart';
import 'package:gimme/widget/Cards/reviewCard.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;
//import '../pages/notificationPage.dart';

class PDrawer {
    final FetchAccounts _fetchMyAccount = FetchAccounts();

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onCliced,
  }) {
    const color = primaryColor;
    const hoverColor = primaryColor;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onCliced,
    );
  }

  Widget widgetBuildDrawer(BuildContext context , urlImage) {
    return FutureBuilder(
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
            return Drawer(
              child: Material(
                child: ListView(
                  children: [ 
                    UserAccountsDrawerHeader(
                      onDetailsPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePages())),
                      accountName: Text("${myAcc.name}"),   //FetchDataAPIRequest().profileEmail as String,      //from account token
                      accountEmail: Text("${myAcc.email}"),
                      arrowColor: Colors.black,
                      decoration: BoxDecoration(color: Colors.white),
                      currentAccountPicture :  CircleAvatar(
                      backgroundImage:  NetworkImage(urlImage), 
                      backgroundColor: Colors.white,         
                      ),
                    ),
                      

                    Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    buildMenuItem(
                      text: 'profile page',
                      icon: Icons.people,
                      onCliced: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProfilePages())),
                    ),

                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'notification',
                      icon: Icons.notifications_outlined,
                      onCliced: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NotificationPage()))
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'update',
                      icon: Icons.update,
                      //onCliced: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>)),

                      //waiting for next version updates on app store
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'Payment',
                      icon: Icons.update,
                      onCliced: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen(key: Key("key"),))),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    
                    buildMenuItem(
                      text: 'test',
                      icon: Icons.update,
                      onCliced: () => {} //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddReview())),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'test2',
                      icon: Icons.update,
                      onCliced: () =>  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>QRCreatePage(
                       "",""
                      ))),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'test add review',
                      icon: Icons.update,
                      onCliced: () =>  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>AddReview(
                       ""
                      ))),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'test review card',
                      icon: Icons.update,
                      onCliced: () =>  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>ReviewCard(
                       "","","","","","","","",
                      ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'Setting & Privacy',
                      icon: Icons.settings,
                      //onCliced: ()=>()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Home())),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 10, 86, 114),
                      ),
                      title: Text(
                        'LogOut',
                        style: const TextStyle(color: Color.fromARGB(255, 10, 86, 114)),
                      ),
                      hoverColor: Colors.black,
                      onTap: () async => {
                        await prefs.remove('token'), //remove token
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login_page())),
                      },
                    ), //success = await prefs.remove('counter');,
                  ],
                ),
              ),
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
              ),);
      }
    );
  }

  Function(int p1) onRatingSelected() {
    return (int ) async =>{};
  }
/*
  buildHeader({
    required String UrlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Row(children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(UrlImage),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 5, 29, 68)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 5, 29, 68)),
                ),
              ],
            ),
            const Spacer(),
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromARGB(255, 10, 86, 114),
              child: Icon(
                Icons.add_comment_outlined,
                color: Colors.white,
              ),
            )
          ]),
        ),
      ),
    );
  }
  */
  
}
