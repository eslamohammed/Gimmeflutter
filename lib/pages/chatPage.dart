import 'package:flutter/material.dart';
import 'package:gimme/main.dart';

class ChatPage extends StatefulWidget {  
  @override
  _ChatPageState createState() =>_ChatPageState();
}
class _ChatPageState extends State<ChatPage>{
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