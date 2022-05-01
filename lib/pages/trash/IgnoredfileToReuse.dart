// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gimme/widget/Pdrawer.dart';

class HomeX extends StatefulWidget {  
  @override
  _HomeXState createState() =>_HomeXState();  

}

/*
/*DropDown
  void minDropDownCallback(double? selectedprice){
    if(selectedprice is double){
      setState(() {
        _minDropDownValue = selectedprice ;
      });
    }
  }
  
  void minTimeDropDownCallback(double? selectedprice){
    if(selectedprice is double){
      setState(() {
        _mintimeDropDownValue = selectedprice ;
      });
    }
  }
*/
 
 */
/*profile builder
        Column(
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
               child: Center(child: Text(""),
  
               
               
               ), //photo
               ),
              Transform.translate(
                offset: Offset(
                  MediaQuery.of(context).size.height*0.175,
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
                    TextButton(
                        child:const Text("Edit profile",style: TextStyle(fontSize: 17.5, color: Colors.white ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                        onPressed: (){
                          //metthod to edit
                          _fetchMyAccount.fetchMyAccount();
                        },
                        style: ButtonStyle(
                          //maximumSize: Size.infinite,
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                            side: BorderSide(color: Colors.white),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.07 ,),
          Center(child: Text("  Userame  :",style:  TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold))),
          SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
          Stack(
            children: [
              Transform.translate(
                offset: Offset(1,1),
                child: Column(
                  children: [
                    Text("Rating: ${rating}",style:  TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                    RatingBar.builder(
                      minRating: 1,
                      itemSize: 30 ,
                      itemBuilder: (context,_)=>Icon(Icons.star, color: Colors.amber,),
                      updateOnDrag: true,
                      onRatingUpdate: (rating){
                        //review here
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(child: Text(" creation time Joind at :",style:  TextStyle(fontSize: 20, color: Colors.black,))),
          SizedBox(height:MediaQuery.of(context).size.height*0.01 ,),
  
          Row(
           children: [
            Container(//profile photo
              width: MediaQuery.of(context).size.height*0.065,
              height: MediaQuery.of(context).size.height*0.065,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                image: DecorationImage(image: NetworkImage(Config.ImageURL,),
                )
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.values[0],
              children: [
                //Container(height: MediaQuery.of(context).size.height*0.005,),
                Text("  Userame  :",style:  TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                Divider(height: MediaQuery.of(context).size.height*0.005,),
                const Center(child: Text(" This is my profile Requests :",style:  TextStyle(fontSize: 29, color: Colors.black,fontWeight: FontWeight.bold))),
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
                 future: _fetchRequest.fetchRequests(getUserID()),
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
                             requests[0].data[index]['body'].toString(),
                             requests[0].data[index]['title'].toString(),
                             requests[0].data[index]['_id'].toString(),
                             requests[0].data[index]["timeRange"]["val"] ,
                             requests[0].data[index]["priceRange"]["min"],
                             requests[0].data[index]["priceRange"]["max"],
                           );
                         }
                       ):Center(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: <Widget> [
                             Text('\t\t\t\t\t\t\t\t\t\t\t\tNo Requests here \n{ get / search for request first}' , style: TextStyle(fontSize: 22)),
                             FloatingActionButton( //defualt for adding req  
                               backgroundColor: primaryColor,
                               child: Icon(Icons.add , color: Colors.white,),
                               onPressed: (){
                                 //add request here
                             })
                           ]
                         ),
                       )
                     );
                   }
                 } 
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
               } 
             ),
              ),
          )
        ],
      )
*/   
/*//Logo
          Container(    //Logo
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  ],
              ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(110),
                 bottomRight: Radius.circular(110),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(  
                alignment : Alignment.center,
                child: Image.asset("assets/gimmeMoblieApp.png",
                width: 250,
                fit: BoxFit.contain,),
                ), 
            ],
            ),
          ),
*/

class _HomeXState extends State<HomeX>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
    //  drawer:PDrawer().widgetBuildDrawer(context),   //
   );
 }
}

// if design want dragdrop buttom
/*
    Padding(//dopr down button to choose  time range
     padding: const EdgeInsets.only(right: 10 , left: 10),
      child: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height / 12 ,    
       decoration: const BoxDecoration(
       color: Colors.white,
      ),  

    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.center,         
      children: [

      Container(                 
        width: MediaQuery.of(context).size.width/1.9,
        decoration: const BoxDecoration(  //from-to box decoration 
        color:Colors.white,
      ),
      child: const Text("Delivery range time ..." , style: TextStyle(color: primaryColor, fontSize: 16 , fontWeight: FontWeight.bold),),
    ),

      //SizedBox(      width: MediaQuery.of(context).size.width/8,),           
      
      
         Container( // time range DropdownButton
         width: MediaQuery.of(context).size.width/3,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(50),
           color: primaryColor,
           
         ),      
         child: DropdownButton(items: [
         DropdownMenuItem<double>(child: Text("  30:00   min "),value: 30*60, ),
         DropdownMenuItem<double>(child: Text("  60:00   min "),value: 60*60, ),
         DropdownMenuItem<double>(child: Text("  120:00  min"),value:  2*60*60, ),
         DropdownMenuItem<double>(child: Text("  12:00:00 hour "),value:  12 * 60 * 60, ),
         DropdownMenuItem<double>(child: Text("  1 Day"),value:  24*60*60, ),
        ],
          value: _mintimeDropDownValue,
          onChanged: minTimeDropDownCallback,
          iconSize: 17.0,
          
          iconEnabledColor: Colors.white,
          iconDisabledColor: primaryColor,
          focusColor: primaryColor,
          icon: const Icon(Icons.timer_rounded , color: Colors.white,),

          dropdownColor: primaryColor,
          borderRadius: BorderRadius.circular(30),
          isExpanded: true,
          style: TextStyle(color: Colors.white  , fontSize:15 ),
          ),
 
          ),
      
    ],
   ),
  ),       
 ),
 ),
*/
/*    Padding(   
     padding: const EdgeInsets.only(right: 10 ,),
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      decoration: const BoxDecoration(  //from-to box decoration 
      color: Colors.white,),

      child: Center( //from & to
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.75,
        child: Row(
      children: [
       
      Container(      //from
        height: MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.6,  
        

        child:TextButton(onPressed: () async{ //navigation to GoogleMaps to place marker
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
        
          /*Position position = await _getGeoLocationPosition();
          location ='Lat: ${position.latitude} , Long: ${position.longitude}';
          GetAddressFromLatLong(position);

          //GoogleMaps();
          print("hi");



          
          CupertinoAlertDialog(
            title: Text("Choose Location"),
            content: Text("Current location Or Another on ?"), 
            actions: [
              FlatButton(onPressed: (){}, child: Text("Current location")),
              FlatButton(onPressed: (){}, child: Text("Google map"))
            ],
          );*/
        },
        child: SizedBox(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width*0.5,
        child: const Center(
        child: Text("Select Location" , style: TextStyle(color:Colors.white, fontSize:17,),),
            ),
           ),
          ),
        color: primaryColor,
        ),
      
      /*Container( //
        height: MediaQuery.of(context).size.height*0.1,
        width: MediaQuery.of(context).size.width*0.33,
        decoration: const BoxDecoration(color:primaryColor,),
          child: Center(child: Text("Hint \nclick select Loctations [S/D {from} & {to}] Coordinante on Google-Maps in Homepage Bar " ,  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18 ,color: Colors.white),)),
       ),       */
      ],
     ),
    ),
   ),
  ), 
 ),
    */


/*
@override
 void initState(){
   intilize();
   super.initState();
 }*/
/* 
intilize()async{
  double  lat = await currentLatLocation() as double;
  double  lng = await currentLngLocation() as double;
  
  Marker firstMarker = Marker(
        markerId: MarkerId('1') , 
        position: LatLng( lat , lng),   //current location is initial position by defualt  
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'From',
          onTap: (){
            // send lat-long to API
            print('==================================');
            debugPrint("--------------------------------");
            debugPrint("----------\n Start latlng($startLat,$startLong)");
            debugPrint("----------\n End   latlng($endlat,$endlong)");
                        
            print("Hallooooooooooooo");
          },
        ),
      //onDrag: 
      draggable: true,
      // position: LatLng(value.latitude, value.longitude),

      onDragStart:((newPosition) {
        debugPrint("its longtide of start drag: $newPosition...");
        startLat = newPosition.latitude;
        startLong = newPosition.longitude;
      }),
      //////////////////////////////////////////////////////////
      onDragEnd: ((newPosition) {
        debugPrint("its longtide of drag end : $newPosition...");
        endlat = newPosition.latitude;
        endlong = newPosition.longitude;
      }),
      
     );
  
  Marker secondMarker = Marker(
        markerId: MarkerId('2') , 
        position: LatLng( lat -5.0 , lng-5.0 ),        //-5 , -5 far from first marker location to avoid user see both as one marker
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'To',
          onTap: (){
            // send lat-long to API
            print('==================================');
            debugPrint("--------------------------------");
            debugPrint("----------\n Start latlng($startLat,$startLong)");
            debugPrint("----------\n End   latlng($endlat,$endlong)");
                        
            print("Hallooooooooooooo");
          },
        ),
      //onDrag: 
      draggable: true,
      // position: LatLng(value.latitude, value.longitude),

      onDragStart:((newPosition) {
        debugPrint("its longtide of start drag: $newPosition...");
        startLat = newPosition.latitude;
        startLong = newPosition.longitude;
      }),
      //////////////////////////////////////////////////////////
      onDragEnd: ((newPosition) {
        debugPrint("its longtide of drag end : $newPosition...");
        endlat = newPosition.latitude;
        endlong = newPosition.longitude;
      }),
      
     );

      ///***adding both markers to the map
  //markers.add(firstMarker);
  //markers.add(secondMarker);


  */
}
*/
/*

// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gimme/Api/Models/fetchRequestOpenModel.dart';
import 'package:gimme/Api/fetchDataAPIRequest.dart';
import 'package:gimme/config.dart';
import 'package:gimme/pages/Home.dart';
import 'package:gimme/pages/addRequest.dart';
import 'package:gimme/widget/Pdrawer.dart';
import 'package:gimme/widget/customInputTextField.dart';
import 'package:gimme/main.dart';


class HomePage extends StatefulWidget {  
  @override
  _HomePageState createState() =>_HomePageState();  

}


class _HomePageState extends State<HomePage>{
   final TextEditingController _searchTextEditingController= TextEditingController();

/*  final TextEditingController _toTextEditingController= TextEditingController();  
  final TextEditingController _fromTextEditingController= TextEditingController();
  final TextEditingController _requestDataTextEditingController= TextEditingController();
*/ 

  void dispose(){
    _searchTextEditingController.dispose();
    super.dispose();
  }
/*  void dispose(){
   /* _toTextEditingController.dispose();
    _fromTextEditingController.dispose();
    _requestDataTextEditingController.dispose();*/
    super.dispose();
  }*/

@override

final FetchDataAPIRequest _fetchDataAPIRequest = FetchDataAPIRequest();

  void iniState(){
    _fetchDataAPIRequest.fetchDataAPIRequest();
    super.initState();

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: primaryColor,
      appBar:  AppBar(
      title: Text(Config.appName),
      centerTitle: true,
      backgroundColor: primaryColor,
     ),
      drawer:PDrawer().widgetBuildDrawer(context),   //
      body:Center(
       child:_homePageUI(context), 
       /*ListView.builder(itemCount: 2,
      itemBuilder: (context, index)
      {
        return addRequestCard();
      }
      ), */
      )
    );
  }
//Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String);
  //print(payload[]);

Widget _homePageUI(BuildContext context){
  return SingleChildScrollView(
   child: Column(
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
   

  Padding(  //search
    padding: const EdgeInsets.only(top: 5,right: 10),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/5,          
      decoration: const BoxDecoration(   
              color: Colors.white,
              borderRadius:  BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25))
              ),  
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,

      children: [
       Padding(
         padding: const EdgeInsets.only(left: 5 , right: 20),
         child: CustomInputTextFieldWidget(hintText: "Search", secure: false, ccontroller: _searchTextEditingController),
       ),
       
       Padding(
         padding: const EdgeInsets.only(top : 10),
         child: Padding(
           padding: const EdgeInsets.only(right: 20 , bottom : 5),
           child: Container(
           decoration: const BoxDecoration(   
                  color: primaryColor,
                  borderRadius:  BorderRadius.all(Radius.circular(10),)
                  ),
           child: 
               FlatButton(onPressed: (){
                 //// take data from _searchTextEditingController then compare it with all data in API to get similar requests
               
               },
              child: const Text("search" , 
              style: TextStyle( color: Colors.white, fontSize: 15 , fontWeight: FontWeight.bold,),),
           ),
      ),
         ),
       ),
    ]),
   ),
  ),    

  ////////////////////////////////////
    
  Padding( //All request here

  padding: const EdgeInsets.only(right: 10 , top: 10 , left: 5  ),
   child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height*5 ,
    decoration: const BoxDecoration(  // box decoration 
            color: Colors.white,
            borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),            
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25))
            ),             
           //posts & requests & comments
    child:Column(    
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    children:  <Widget>[
     
     Padding( // Welcome All Requests is here...
      padding: EdgeInsets.all(8.0),
      child:  Text("Welcome All Requests is here..." ,
      style: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 15 ,
    ),
   ),

),

     Padding( //divider
       padding: const EdgeInsets.only( right: 20),
       child: Divider(color: primaryColor,),
     ),

    /// here [list of requests from Api] it will be designed later
     Container( // here

      child: addRequestCard()
    ),
    /*ListView.builder(itemCount: 2,
      itemBuilder: (context, index)
      {
        return addRequestCard();
      }
      ), */


],
),
       
       
       /* FlatButton(child: Text("eslam" , style: TextStyle(color: Colors.black , fontSize: 50)),
           onPressed: (){
              FetchDataAPIRequest().fetchDataAPIRequest();
            },),*/
       ),
  ),
   
    ////////////////////////////////////

    ],    
  
   ),
  );
  
 }

Widget addRequestCard(){
  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Container(
         width: MediaQuery.of(context).size.width*0.8,
         child: Column(
          children: [
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("datadatadatatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata " ,),
            ),
      
           Card(
            child:Image.network("https://images.unsplash.com/photo-1647960611692-39bb707eacf6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60" , width: 250, height: 250, fit: BoxFit.cover,),
            ),      
          ],
      ),
       ),
    
    
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1647989818649-62012bb4c0bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"),fit: BoxFit.cover)
            ),
           ),
        Text("@username",style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),),

         ],
       ),
    
    ]),
  );
}

}
    /*
     Center(
              child: Center(
                child: FlatButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_page()));
                },
                child: const Text("login page"),
                ),
              ),
            ),
     Center(
              child: Center(
                child: FlatButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Register_page()));
                },
                child: const Text("register page"),
                ),
              ),
            ),
    */
    



 */