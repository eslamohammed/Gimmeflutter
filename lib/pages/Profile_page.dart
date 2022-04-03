import 'package:flutter/material.dart';
//import 'package:gimme/Api/fetchDataAPIRequest.dart';
import 'package:gimme/main.dart';
//import 'package:snippet_coder_utils/hex_color.dart';

//FetchDataAPIRequest y = FetchDataAPIRequest();
// ignore: camel_case_types
class Profile_page extends StatelessWidget {
  final String email = ""; //y.profileEmail ;
  final String name = "";  //y.profileName;
  final String urlImage;

   Profile_page({
    Key?key,
     email,
     name,
     required final this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
     appBar: AppBar(
      title : Text(name),
      centerTitle: true,
      backgroundColor: primaryColor,

    ),
     body: _homePageUI(context),
   ),
  );
}

Widget _homePageUI(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/6,          
        decoration: const BoxDecoration(   
              color: primaryColor,
        borderRadius:  BorderRadius.only(
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25))
        ),  
          child: Text("hi"),
        ),
        /*Image.network(
        urlImage,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
     ),*/


    ],
    ),
   );
}




} 