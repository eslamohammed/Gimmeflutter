// ignore_for_file: use_key_in_widget_constructors

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:gimme/Google_maps/directions.dart';
//import 'package:gimme/Google_maps/directions_model.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';
import 'package:gimme/utilies/global_library.dart' as globals ;


String location ='Null, Press Button';
String address = 'search';

var myMarkers = HashSet<Marker>(); //collection to store all markers like array return data as a type marker

class GoogleMaps extends StatefulWidget{

  @override
  GoogleMapsState createState() => GoogleMapsState();

   

  
}
class  GoogleMapsState extends State<GoogleMaps>{
  static const _initialCameraPosition= CameraPosition(
    target: LatLng(30.033333, 31.233334), //LatLng(currentLatLocation(), currentLngLocation()) , //LatLng(30.033333, 31.233334),
    zoom: 11.0,
  );

  late GoogleMapController _googleMapController;

   Marker? _from ;
   Marker? _to ;
   //Directions? _info;
  
  @override
  void dispose(){
    _googleMapController.dispose();
    super.dispose();
  } 

@override
Widget build(BuildContext context){
  return  Scaffold(
    appBar: AppBar(
      title: const Text("GoogleMaps",style:TextStyle( color: Colors.black ,fontWeight: FontWeight.bold,fontSize:25) ,),
      backgroundColor: Colors.white,
      centerTitle: false,
      actions: [
        if(_from !=null)
        TextButton(
          onPressed: ()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target:  _from!.position,
              zoom: 14.5,
              tilt: 50.0
              )
            )
          ) ,
          style: TextButton.styleFrom(
            primary: primaryColor,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)
          ),
          child: const Text("From",style:TextStyle( color: primaryColor ,fontWeight: FontWeight.bold,fontSize:25) ,)
        ),
        if(_to != null)
        TextButton(
          onPressed: ()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target:  _to!.position,
              zoom: 14.5,
              tilt: 50.0
              )
            )
          ) ,
          style: TextButton.styleFrom(
            primary: Colors.red,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)
          ),
          child: const Text("To" ,style:TextStyle( color: Colors.red ,fontWeight: FontWeight.bold,fontSize:25) ,)
        ),
      ],
    ),
    body: GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition:_initialCameraPosition,    //lag $$ long
      onMapCreated: (controller) => _googleMapController = controller,
    // onMapCreated:onMapCreated,  //after map ready to be used
    // markers:Set<Marker>.of(myMarkers),  //array of mrakers any marker is added to on onMapCreated it will be add here
      markers: {
        if(_from != null) _from as Marker,
        if(_to != null) _to as Marker,
      },
      onLongPress: _addMarker,
    ) ,
    floatingActionButton: FloatingActionButton(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
      onPressed: ()=> _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition),
      ),
      child: const Icon(Icons.center_focus_strong),
    ),
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
        print(newPosition.latitude);
        

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

  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(Position position)async {  //methods to give more info of User location //Actually unused now, may be used later
    List placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
//    address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  }


  void _addMarker(LatLng pos) async{
    //(marker)from is not set or (marker)from/(marker)to are both set 
    if (_from == null ||(_from != null && _to != null)){
      //set (marker)from
      setState(() {
        _from = Marker(
        markerId: const MarkerId('Origin'), 
        position: pos ,   //current location is initial position by defualt  
        infoWindow: InfoWindow(
          title: "Gimme mobile  app",
          snippet: 'From',
          onTap: (){
            // send lat-long to API
            debugPrint('==================================');
            debugPrint("----------\n from location of latlng(${_from?.position.latitude},${_from?.position.longitude})");                        
            debugPrint("----------\n from location of latlng(${globals.fromLat},${globals.fromLong })");                        
            debugPrint("--------------------------------");
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        /*
        //draggable: true,
        onDragEnd: ((newPosition) {
          debugPrint("its longtide of drag end : $newPosition...");
          setState(() {
            globals.fromLat  = newPosition.latitude;
            globals.fromLong = newPosition.longitude;
          });
        }),*/      
      );
      _to = null ; 
      
    //  _info = null;

      globals.fromLat  = _from!.position.latitude;
      globals.fromLong = _from!.position.longitude;
      
      });
    }else{
      setState(() {
        _to = Marker(
          markerId: MarkerId('2') , 
          position: pos,        //-0.03 , 0.0 far from first marker location to avoid user see both as one marker
          infoWindow: InfoWindow(
            title: "Gimme mobile app",
            snippet: 'To',
            onTap: (){
              // send lat-long to API
              debugPrint('==================================');
              debugPrint("----------\n To the location of marker 2: latlng(${_to?.position.latitude},${_to?.position.longitude})");  
              debugPrint("----------\n To the location of marker 2: latlng(${globals.toLat},${globals.toLong})");                        
              debugPrint("--------------------------------");
            },
          ),
        //onDrag: 
        //draggable: true,
        //////////////////////////////////////////////////////////
        /*onDragEnd: ((newPosition) {
          debugPrint("Marker #2's LatLng of final drag : $newPosition...");
          print(newPosition.latitude);
          

          setState(() {
            //globals.toLatLong = newPosition;
            globals.toLat = newPosition.latitude;
            globals.toLong = newPosition.longitude;
          });  
        }
        ),*/
        


        );
        globals.toLat  = _to!.position.latitude;
        globals.toLong = _to!.position.longitude;
      });
      /*
      //get directions
      final directions = await Directionss().getDirections(from: _from!.position, to: _to!.position);
      setState(() => _info = directions );
      */
    }

  }

}
