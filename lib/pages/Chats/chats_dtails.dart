import 'package:flutter/material.dart';
import 'package:gimme/main.dart';

class ChatDetails extends StatefulWidget {  
  final userID ;
  ChatDetails(this.userID);
  
  @override
  _ChatDetailsState createState() =>_ChatDetailsState();
}
class _ChatDetailsState extends State<ChatDetails>{
  int count = 0;
  
  @override
  Widget build(BuildContext context){
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
}