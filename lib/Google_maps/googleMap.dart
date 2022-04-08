// ignore_for_file: use_key_in_widget_constructors

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimme/utilies/global_library.dart' as globals ;
import 'package:google_maps_flutter/google_maps_flutter.dart';


String location ='Null, Press Button';
String address = 'search';

var myMarkers = HashSet<Marker>(); //collection to store all markers like array return data as a type marker

class GoogleMaps extends StatefulWidget{

  @override
  GoogleMapsState createState() => GoogleMapsState();

   

  void hehe (){
    print("hehe $myMarkers");
    print(myMarkers);
  //  print(fromlat);

  }

}
// ignore: camel_case_types
class  GoogleMapsState extends State<GoogleMaps>{
/*
double ? fromLat ;
double ? fromLong ;
double ? toLat ;
double ? toLong ;
*/
/*
callBack(x , y){
  setState(() {
    fromLat = x;
    fromLong= y;
  });
}
*/
//  List <Marker> markers = [];  // list that contain from & to markers
//var myMarkers = HashSet<Marker>(); //collection to store all markers like array return data as a type marker
//double get data => fromLat ;

@override
Widget build(BuildContext context){
  return  Scaffold(/*
    appBar: AppBar(
      title: const Text("GoogleMaps"),
      backgroundColor: primaryColor,
    ),*/
    body: Stack(
      children: [
      GoogleMap(
       initialCameraPosition:
       const CameraPosition(
         target: LatLng(30.033333, 31.233334), //LatLng(currentLatLocation(), currentLngLocation()) , //LatLng(30.033333, 31.233334),
         zoom: 11.0,),    //lag $$ long
       onMapCreated:onMapCreated,  //after map ready to be used
       markers:Set<Marker>.of(myMarkers),  //array of mrakers any marker is added to on onMapCreated it will be add here
      ),
      Center(child: Text("lat long(${globals.fromLat} , ${globals.fromLong})"),),
      ],
    ) ,
  );
 }

 void onMapCreated(googleMapController)async{
  double  lat = await currentLatLocation() as double;
  double  lng = await currentLngLocation() as double;

  Marker fromMarker = Marker(
        markerId: MarkerId('1'), 
        position: LatLng( lat , lng),   //current location is initial position by defualt  
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'From',
          onTap: (){
            // send lat-long to API
            debugPrint('==================================');
            debugPrint("----------\n from location of latlng(${globals.fromLat},${globals.fromLat})");                        
            debugPrint("--------------------------------");
          },
        ),
      draggable: true,
      /*
      onDragStart:((newPosition) {
        debugPrint("its longtide of start drag: $newPosition...");
        startLat = newPosition.latitude;
        startLong = newPosition.longitude;
      }),*/
      //////////////////////////////////////////////////////////
      onDragEnd: ((newPosition) {
        debugPrint("its longtide of drag end : $newPosition...");
        setState(() {
          globals.fromLat  = newPosition.latitude;
          globals.fromLong = newPosition.longitude;
        });
      }),      
     );
  Marker toMarker = Marker(
        markerId: MarkerId('2') , 
        position: LatLng( lat -0.03 , lng+0.0 ),        //-0.03 , 0.0 far from first marker location to avoid user see both as one marker
        infoWindow: InfoWindow(
          title: "Gimme mobile app",
          snippet: 'To',
          onTap: (){
            // send lat-long to API
            debugPrint('==================================');
            debugPrint("----------\n To the location of marker 2: latlng(${globals.toLat},${globals.toLong})");                        
            debugPrint("--------------------------------");
          },
        ),
      //onDrag: 
      draggable: true,
      //////////////////////////////////////////////////////////
      onDragEnd: ((newPosition) {
        debugPrint("Marker #2's LatLng of final drag : $newPosition...");

        setState(() {
          //globals.toLatLong = newPosition;
          globals.toLat = newPosition.latitude;
          globals.toLong = newPosition.longitude;
        });  
      }),
    );
          
  setState((){
    myMarkers.add(fromMarker);   //from Marker
    myMarkers.add(toMarker);  //To Marker
  });
}
  ///*** 2 methods to bring user current location using Gps 
  Future currentLatLocation()async{  //Getting Users current Latitude
      Position position = await _getGeoLocationPosition();
      location ='Lat: ${position.latitude} , Long: ${position.longitude}';
      //GetAddressFromLatLong(position);     //calling func to printing location in details [adress,street,....] it is going to used later. 
      return position.latitude;
  }

  Future currentLngLocation()async{   //Getting Users current Longitude
      Position position = await _getGeoLocationPosition();
      location ='Lat: ${position.latitude} , Long: ${position.longitude}';
      //GetAddressFromLatLong(position);    //calling func to printing location in details [adress,street,....] it is going to used later.
      return  position.longitude ;
  }

  Future<Position> _getGeoLocationPosition() async {    // everything is documented below 
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position)async {  //methods to give more info of User location //Actually unused now, may be used later
    List placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
//    address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  }

}
