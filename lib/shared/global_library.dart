library global_library;

import 'package:gimme/main.dart';
import 'package:jwt_decode/jwt_decode.dart';



double  fromLat =0.0;
double  fromLong =0.0 ;
double  toLat= 0.0 ;
double  toLong= 0.0;

int currnetIndex = 0;

List  requestsData = [];
int count=0;
//List <RequestModel> requests = [] ;

  String getUserID(){ //method to decode the token
    // To decode the token
    String? token = prefs.getString("token") ;
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    print(payload);                                     // Print the payload
    print(payload['_id']);                              // Print one of its property(example: email):
    /*DateTime? expiryDate = Jwt.getExpiryDate(token);    //   To get expiry date
                                                        //   Note: The return value from getExpiryDate function is nullable.
    debugPrint("the expire date at : $expiryDate");    //Print the expiry date                               
    bool isExpired = Jwt.isExpired(token);              // To check if token is expired

    print(isExpired);
    // Can be used for auth state
    if (!isExpired) {                                   //   Token isn't expired 
      print("token is not Expired") ;              

      } else {                                          //Token is expired
      print("token is not Expired") ;
  }*/
  return payload['_id'] ;
  }
  