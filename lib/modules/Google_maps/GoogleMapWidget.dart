// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
    
  @override
  GoogleMapWidgetState createState() => GoogleMapWidgetState(double);

}
class  GoogleMapWidgetState extends State<GoogleMapWidget>{

  int check =0;
  final x;
  GoogleMapWidgetState(this.x);

  var myMarkers = HashSet<Marker>();
  
  @override
  Widget build(BuildContext context) {
    return viewGMapLocation(
      context,
    );
  }

  Widget viewGMapLocation(BuildContext context, ){
    return 
   check!= 0 ? Center(child: Text("GoogleMap ${x} Location"),):
   GoogleMap(
       initialCameraPosition:
       const CameraPosition(
         target: LatLng(30.033333, 31.233334), //LatLng(currentLatLocation(), currentLngLocation()) , //LatLng(30.033333, 31.233334),
         zoom: 11.0,),    //lag $$ long
       onMapCreated:onMapCreated,  //after map ready to be used
       markers:Set<Marker>.of(myMarkers),  //array of mrakers any marker is added to on onMapCreated it will be add here
      );
  }


  
 void onMapCreated(googleMapController) {

     Marker fromMarker = const Marker(
        markerId: MarkerId('1'), 
        position: LatLng(30.033333,31.233334 ),//lat , lng),   //current location is initial position by defualt  
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'From',
        ),
     );
        setState(() {
    myMarkers.add(fromMarker);
   });

/*
  Marker fromMarker = Marker(
        markerId: MarkerId('1'), 
        position: LatLng(30.033333,31.233334 ),//lat , lng),   //current location is initial position by defualt  
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'From',
          onTap: (){
            // send lat-long to API
            debugPrint('================${x}==================');
            //debugPrint("----------\n from location of latlng(${globals.fromLat},${globals.fromLat})");                        
            debugPrint("--------------------------------");
          },
        ),
     );
  Marker toMarker = Marker(
        markerId: MarkerId('2') , 
        position: LatLng( 31.233334 , 31.233334 ),        //-0.03 , 0.0 far from first marker location to avoid user see both as one marker
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'To',
          onTap: (){
            // send lat-long to API
            debugPrint('==================================');
            //debugPrint("----------\n To the location of marker 2: latlng(${globals.toLat},${globals.toLong})");                        
            debugPrint("--------------------------------");
          },
        ),
  
      );

    setState(() {
      
    myMarkers.add(fromMarker);   //from Marker
    myMarkers.add(toMarker);  //To Marker
    
    });*/
}
  
}
/*

                  //while(snapshot.data == null);

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


 */