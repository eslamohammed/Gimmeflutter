import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/profileModel.dart';

import 'package:gimme/main.dart';

import 'package:gimme/pages/loginPage/login_page.dart';
import 'package:gimme/pages/notificationPage.dart';
import 'package:gimme/pages/profiles/fetchAccountsData.dart';
import 'package:gimme/pages/profiles/profilePage.dart';



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
    //const String name = "eslam";
    //String email = "eslam@gmail.com";
    //const urlImage = Config.ImageURL;
    /*Drawer(
      child: Material(
        //color
        child: ListView(
          children: [
            /*buildHeader(
              UrlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePages())),
            ),*/

                
        UserAccountsDrawerHeader(
          onDetailsPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePages())),
          accountName: Text(name ,),   //FetchDataAPIRequest().profileEmail as String,      //from account token
          accountEmail: Text(email),
          arrowColor: Colors.black,
          decoration: BoxDecoration(color: Colors.white),
          currentAccountPicture :  CircleAvatar(
          backgroundImage:  NetworkImage(urlImage), 
          backgroundColor: Colors.white,         
          ),
        ),
              

            const Padding(
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

            const SizedBox(
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
            const SizedBox(
              height: 24,
            ),
            buildMenuItem(
              text: 'update',
              icon: Icons.update,
              //onCliced: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>)),

              //waiting for next version updates on app store
            ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15, left: 15),
              child: Divider(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            buildMenuItem(
              text: 'Setting & Privacy',
              icon: Icons.settings,
              //onCliced: ()=>()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Home())),
            ),
            const SizedBox(
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
  

     */
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
                      

                    const Padding(
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

                    const SizedBox(
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
                    const SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'update',
                      icon: Icons.update,
                      //onCliced: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>)),

                      //waiting for next version updates on app store
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    buildMenuItem(
                      text: 'Setting & Privacy',
                      icon: Icons.settings,
                      //onCliced: ()=>()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Home())),
                    ),
                    const SizedBox(
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
