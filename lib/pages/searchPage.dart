// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gimme/main.dart';
import 'package:gimme/widget/customInputTextField.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'addRequest.dart';

class SearchPage extends StatefulWidget {  
  @override
  _SearchPageState createState() =>_SearchPageState();
}
class _SearchPageState extends State<SearchPage>{
  final TextEditingController _searchTextEditingController= TextEditingController();

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
      title:const Text('Home' , style: TextStyle(color: Colors.black , fontSize: 47.5 ,fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation:0,  
      automaticallyImplyLeading: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new , color: primaryColor, size: 35,),
      onPressed: ()=> Navigator.pop(context , false),)   
      ),     
     body: _searchUI(context),
    //////////////////
   );
 }
 
Widget _searchUI(BuildContext context){
return SafeArea(
  child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
  SizedBox(
  width: MediaQuery.of(context).size.width,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: HexColor("#E5E5E5"),
        borderRadius: BorderRadius.circular(50)
        ),
        child: CustomInputTextFieldWidget(hintText: "Search Store",
         secure: false, ccontroller:_searchTextEditingController )
        
        ),
    ),
  
   Padding(    
   padding: const EdgeInsets.all(15),
   child: Center( 
   child: FlatButton(onPressed: () async {
     // function to take data from search to return similar data from home request list & api 
    }
    ,child: Padding(
      padding: const EdgeInsets.all(12.5),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: MediaQuery.of(context).size.width*0.5,
      child: const Center(
        child: Text("Search", style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:27.5,),),
          ),
        ),
       ),
      color: primaryColor,
      ),
     ),
    ),
   
   Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.values[3],
    children: [
  //// it will be impelemented later.. 
    
  Padding( //Add Request
   padding: const EdgeInsets.only(right: 10 , top: 10 , bottom: 10),
    child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/5,          
    decoration: const BoxDecoration(   
            color: Colors.white,
            borderRadius:  BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20))
            ),  
    
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.start,
    
     children: [
     Padding(    //Need Something..!!!
     padding: const EdgeInsets.only(top :10.0 , left: 5),
     child: Text("Need Something..!!!" ,
     style: TextStyle(
     color: primaryColor,
     fontWeight: FontWeight.bold,
     fontSize: 15 ,
    ),
   ),
 ),
    
     Padding( //devider
       padding: const EdgeInsets.only(top:3 , bottom: 3 ,right: 20 , left: 5),
       child: Divider(color: primaryColor),
     ),    
  
     Padding( // AddRequest Button
     padding: const EdgeInsets.only(top :5.0),
     child: Center(
     child: FlatButton(onPressed: () {
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddRequest()));
      
      },
     child: Padding(
     padding: const EdgeInsets.all(10),
     child: SizedBox(
     width: MediaQuery.of(context).size.width*0.5,
     child: const Center(
     child: Text("Add Request" , style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:20,),),
    ),
    ),
   ),
    color: primaryColor,
   ),
  ),  
 ),
]),      

),
),
   

   ],
   )
  ]
  ),
 ),
],
),
),
);  
}

}