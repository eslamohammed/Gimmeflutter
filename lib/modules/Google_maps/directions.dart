import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gimme/modules/Google_maps/.env.dart';
import 'package:gimme/modules/Google_maps/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directionss{
  static const _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  Directionss({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng? from,
    @required LatLng? to,
  })async{
    final res = await _dio.get(
      _baseUrl,
      queryParameters: {
        'from': '${from!.latitude},${from.longitude}',
        'to': '${to!.latitude},${to.longitude}',
        'key': googleAPIKey, 
      }
    );

    if (res.statusCode == 200){
      return Directions.fromMap(res.data);
    }
    return null as Directions;

  }

}