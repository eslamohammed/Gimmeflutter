


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds ;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });
  factory Directions.fromMap(Map<String,dynamic> map){
    //check if route is not available
    if ((map['routes'] as List).isEmpty) return null as Directions;

    //get route infos
    final data = Map<String,dynamic>.from(map['route'][0]); 

    //Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    
    //the val of local variable bounds
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'],northeast['lng']),
      southwest: LatLng(southwest['lat'],southwest['lng']), //southwest['lat'], northeast: northeast['lng']);
    );

    //Distance & Duration
    String dis ='';
    String dur ='';

    if((data['legs']as List).isNotEmpty){
      final leg = data['legs'][0];

      dis = leg['distance']['text'];
      dur = leg['duration']['text'];

    }

    return Directions(
      bounds: bounds,
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: dis,
      totalDuration: dur,
      );


  }
}
