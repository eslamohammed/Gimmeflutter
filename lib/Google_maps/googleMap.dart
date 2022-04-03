import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimme/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget{
  //const GoogleMaps(Icon icon, {Key? key}) : super(key: key);


  @override
  _GoogleMapsState createState() => _GoogleMapsState();
  
}

// ignore: camel_case_types
class  _GoogleMapsState extends State<GoogleMaps>{



  var myMarkers = HashSet<Marker>(); //collection to store all markers like array return data as a type marker

@override
Widget build(BuildContext context){
  return  Scaffold(
    appBar: AppBar(
      title: Text("GoogleMaps"),
      backgroundColor: primaryColor,
    ),
    body: GoogleMap(
      //mapType: MapType.hybrid,
       initialCameraPosition:
       const CameraPosition(
         target: LatLng(30.033333, 31.233334),
         zoom: 11.0,),    //lag $$ long

      onMapCreated:_onMapCreated,  //after map ready to be used
      
      markers:Set<Marker>.of(myMarkers) , 
    ),//_loginUI(context),
  );
 }

void _onMapCreated(googleMapController){
  setState(() {
    myMarkers.add(
      Marker(
        markerId: MarkerId('1') , 
        position: LatLng(30.47261848797839, 30.926577003080894),  //هندسة منوف 
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'Search for people',
          onTap: (){
            // send lat-long to API
          
            print("Hallooooooooooooo");
          },
          
        ),
      //onDrag: 
      ),
    );//marker id may be from from api
  });
}


 //adding custom marker
  /*
  BitmapDescriptor customMarker = null as BitmapDescriptor ;
  //  BitmapDescriptor ? customMarker ;

  getCustomMarker()async{
    customMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/gimmeMoblieApp.png");
  }

  @override
  void initState() {
    getCustomMarker();
    super.initState();
  }
*/
}
