// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:gimme/config.dart';

import 'package:gimme/widget/Pdrawer.dart';
import 'package:gimme/main.dart';

import 'package:gimme/utilies/global_library.dart' as globals ;


class HomeControllerPage extends StatefulWidget {  
  @override
  _HomeControllerPageState createState() =>_HomeControllerPageState();  

}

class _HomeControllerPageState extends State<HomeControllerPage>{

@override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
      title: Text(Config.appName),
      backgroundColor: primaryColor,
      ),
      drawer:PDrawer().widgetBuildDrawer(context),
      body:IndexedStack(
       index : globals.currnetIndex,
       children : screens,          //from main class
      ),   
      bottomNavigationBar: BottomNavigationBar(  //navigating Bar  in the bottom
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: primaryColor,
        currentIndex: globals.currnetIndex,
        unselectedItemColor: Colors.black,
        iconSize: 30,
        unselectedFontSize: 15,
        selectedFontSize: 18,
        onTap: (index) => setState(() => globals.currnetIndex = index),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
        BottomNavigationBarItem(
          icon:Icon(Icons.home),
          label: 'home',
          backgroundColor: primaryColor 
        ), 
        BottomNavigationBarItem(
          icon:Icon(Icons.search),
          label: 'search',
          backgroundColor: primaryColor 
        ),              
        BottomNavigationBarItem(
          icon:Icon(Icons.chat),
          label: 'chat',
          backgroundColor: primaryColor
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.add_box),
          label: 'Add request',
          backgroundColor: primaryColor 
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.add_location_alt),
          label: 'GoogleMap',
          backgroundColor: primaryColor 
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.person),
          label: 'profile',
          backgroundColor: primaryColor,
        ),
      ]),
    );
  }

}