// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:gimme/Chats/chats_dtails.dart';

class ChatPage extends StatefulWidget {  
  @override
  _ChatPageState createState() =>_ChatPageState();
}
class _ChatPageState extends State<ChatPage>{
  int count = 0;
  
  @override
/*  Widget build(BuildContext context){
    return Scaffold(
       appBar:  AppBar(
      title:const Text('Chats'),
      backgroundColor: primaryColor,
     ),
     body: Center(
       child: Text("chat $count" , style: TextStyle(fontSize: 45),),
     ),
     floatingActionButton: FloatingActionButton(
      onPressed: (){
      setState(() {
      count++;
        });
      }, 
      child: Icon(Icons.abc) ,),
   );
 }
*/
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        actions: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  //three pop Button
                },
              ),
            ],
          ),
        ],
        title: const Text("Gimme's App"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {
                      //open camera using imagePicker
                    },
                    icon: Icon(Icons.camera_alt),
                  ),
                  //SizedBox(
                  // width: 20,
                  //),
                  TextButton(
                    onPressed: () {
                      ///navegate inside SubsScreen/SubWidget of chat page
                    },
                    child: const Text(
                      'CHATS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      /// this part for global design and responsible for Status
                      /// in our project this feature is not needed 
                    },
                    child: const Text(
                      'STATUS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      /// this part for global design and responsible for Calls
                      /// in our project this feature is not needed 
                    },
                    child: const Text(
                      'CALLS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    width: 0.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height:  MediaQuery.of(context).size.height*0.725,
              width:  MediaQuery.of(context).size.width,
              child: ListView.separated(
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 17.5,
                      ),
                  itemCount: 15 ///here we have to set the number of chat Boxes 
                  ///it depend on number of users that current user chated with before
                  ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatItem() => InkWell(
    onTap: () => 
      ///navigate to message Box
      ///route other user id here 
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetails("ID of forgine user"))),
    
    child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  Config.user2ndImageURL),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10.0),
                      child: Text(
                        'Eslam Mohamed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    SizedBox(width:  MediaQuery.of(context).size.width*0.25,),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 100.0),
                      child: Text('8:55 PM'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: Text(
                    'Hello My Friend My Name Is Ahmed',
                    style: TextStyle(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
  );
}