// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gimme/main.dart';
import 'package:gimme/pages/HomeController.dart';
import 'package:gimme/pages/profiles/profilePage.dart';
import 'package:gimme/requestItem/requestDetails.dart';

import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';


import '../config.dart';

class RequestItem extends StatelessWidget { 

  @override
  Widget build(BuildContext context){

    
    return Container() ;
 }
  
 Widget requestCard (
   BuildContext context,
   int index,
   String reqBody,
   String reqTitle,
   String reqID,
   dynamic reqtimerange,
   dynamic reqminPrice,
   dynamic reqmaxPrice,
   dynamic timeUnits,
   dynamic username,
   )
   {return InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestDetails(reqBody,reqTitle,reqID,reqtimerange,reqminPrice,reqmaxPrice,timeUnits))),
  
  /* onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
      return RequestDetails(reqBody,reqTitle,reqID,reqtimerange,reqminPrice,reqmaxPrice);
    })), */
  
  /*  onTap: (){Navigator.push(
      context, 
      MaterialPageRoute(builder: (context)=>RequestDetails(reqBody,reqTitle,reqID,reqtimerange,reqminPrice,reqmaxPrice))
    );},*/
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
        ),
        elevation: 6,
        margin: const EdgeInsets.all(11),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color:Colors.white ,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),),
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width,
                  child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left:8.0,top: 15),
                            child: CircleAvatar(radius: 30, backgroundImage: NetworkImage(Config.ImageURL),),
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*0.005 ,),
                          
                          RichText(//username
                          text : TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            children: <TextSpan>[
                              
                              TextSpan(
                                text:"\t\t$username",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  //decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                ..onTap = (){ // route to this account page
                                //  Navigator.pushNamed(context, "/login");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePages()));
                                  }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Padding( //photo
                      padding: const EdgeInsets.only(top: 8 , left: 8 ,bottom: 8),
                      child:Container(//profile photo
                      width: MediaQuery.of(context).size.height*0.065,
                      height: MediaQuery.of(context).size.height*0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        image: DecorationImage(image: NetworkImage(Config.ImageURL,),
                        )
                      ),
                    ),
                        /*Container(/// Image if exist
                        decoration: BoxDecoration(color:Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2, 
                        child: Image.asset("assets/gimmeMoblieApp.png", //here we receive an image from API instead this ***Logo
                          width: 250,
                          fit: BoxFit.contain,),
                      ),*/
                    ),*/
                    Padding(//*** title && body
                      padding: const EdgeInsets.all(8.0),
                      child: Container(//*** title && body
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(color:Colors.white,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),),
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width*0.73,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title
                              Text("#${reqTitle} ",style: TextStyle(fontSize: 33, color: Colors.black ,fontWeight: FontWeight.bold), ),   //waiting for API data
                              const Divider(color: primaryColor,),
                              //body
                              Text( "//  ${reqBody}  ",style: TextStyle(fontSize: 20, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ) ,
              ),
              
              Container( 
                decoration: const BoxDecoration(color:Colors.white),
                height: MediaQuery.of(context).size.height*0.08,
                width: MediaQuery.of(context).size.width,
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [ 
                    Padding(//deleteRequest 
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                      child: const Icon(Icons.delete,color: Colors.black, ),
                      heroTag: "${index}}",
                      backgroundColor: primaryColor,
                      onPressed: (){
                        print(reqID);
                        deleteRequest(context,reqID); //sending object id to be deleted
                      }),
                    ),
                   /* Padding(//just for margin
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color:Colors.white,
                        borderRadius: BorderRadius.circular(10),),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.25,
                      ),
                    ),*/
                    Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Container(
                      decoration: BoxDecoration(color:Colors.white,
                      borderRadius: BorderRadius.circular(10),),
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width*0.75,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.06,
                              width: MediaQuery.of(context).size.width*0.3,
                              child: TextButton(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  const Text("From{'/'/'} ",style: TextStyle(fontSize: 15,color: primaryColor ,),),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.05,),
                                  const Icon(Icons.arrow_forward , color: primaryColor,),
                                ],) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                onPressed: (){
                                  debugPrint(prefs.getString("token") as String);
                                },
                                style: ButtonStyle(
                                  //maximumSize: Size.infinite,
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                    side: const BorderSide(color: primaryColor),
                                  ),
                                )
                              ),
                            ),
                          ),    

                            const SizedBox(width: 10,),
      
                            SizedBox(
                                height: MediaQuery.of(context).size.height*0.06,
                                width: MediaQuery.of(context).size.width*0.3,
                                child: TextButton(
                                  child: const Text("To {'/'x/'}",style: TextStyle( fontSize: 20,color: primaryColor ,),), // city name from location
                                  onPressed: ()async{
                                    print("=============="); 
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.0),
                                      side: const BorderSide(color: primaryColor),
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
 }

 Future <http.Response> fetchRequests() async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

    var url = Uri.parse( Config.apiURl + Config.getAllRequestAPI);      
    return await http.get(url, headers: header); 
}
 
 Future  deleteRequest(BuildContext context ,String id) async{ 
  
  Map<String,String> header = { "Authorization":"Bearer " + (prefs.getString("token") as String),};

    var url = Uri.parse(Config.apiURl+Config.requestAPI+Config.deleteRequestAPI + id);
    var response = await http.delete(url , headers: header);

    if(response.statusCode == 200){
    FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      " Request has been deleted !!! ",
      "Ok", 
      (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()));  
    },);
    }else if (response.statusCode == 400){
      FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      " ${response.statusCode} Bad Request! , Invalid Syntax : request is not deleted ",
      "Ok", 
      (){
      Navigator.pop(context);  
    },);
      print("reject");
    }else if (response.statusCode == 403){
      FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      "Eror ${response.statusCode} : Forbidden!!,\n\nCan't perform this action / Can't delete : must be closed ",
      "Ok", 
      (){
      Navigator.pop(context);  
    },);
      print("reject");
    }else if (response.statusCode == 404){
      FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      "Error ${response.statusCode}: Not Found!,\t Request not found ",
      "Ok", 
      (){
      Navigator.pop(context);  
    },);
      print("reject");
    }  
  }




 
/*
 Future getRequest(String id) async{//requestData List
  bool?  status ;
  String?  msessage ;
  dynamic data;
  String?  title, bodii;
  double? fromLocation , toLocation;
  int  priceRangemin,  priceRangemax , timeRange ;
  
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

  //  Map<String, dynamic> payload = Jwt.parseJwt(prefs.getString("token") as String); // will be putted instead 624e9ebce96ec076cbce6e53
    var url = Uri.parse( Config.apiURl + Config.getRequestAPI + id );  //payload['_id']);//Config.apiURl+ Config.getRequestAPI);
    http.Response  response = await http.get(url, headers: header); 
    if(response.statusCode == 200){
   var body = (json.decode(response.body()));
    
    globals.requestsData.add(body);

    print((globals.requestsData));   //[first iteration added to list requestsData ][first data[body]]
    print((globals.requestsData[0]['status']));   //[first iteration added to list requestsData ][first data[body]]

    msessage = globals.requestsData[0]["msessage"];
    status = globals.requestsData[0]["status"];
    data = globals.requestsData[0]['data'];
    title = globals.requestsData[0]["data"][0]["title"];  
    bodii  = globals.requestsData[0]["data"][0]["body"];
 
    fromLocation = globals.requestsData[0]['data'][0]['fromLocation']['coordinates'][1];
    toLocation   = globals.requestsData[0]['data'][0]['fromLocation']['coordinates'][1];
    priceRangemin= globals.requestsData[0]["data"][0]["priceRange"]["min"];
    priceRangemax= globals.requestsData[0]["data"][0]["priceRange"]["max"];   
    timeRange    = globals.requestsData[0]["data"][0]["timeRange"]["val"];

    print("==============================");
    print("${data}");
    print("==============================");
    print("${msessage}");
    print("${status}");
    print("${bodii}");
    print("${title}");
    print("${fromLocation}");
    print("${toLocation}");
    print("${priceRangemin}");
    print("${priceRangemax}");
    print("${timeRange}");
        
  } else{
      print("reject");
    }

    return globals.requestsData ;
 
  }

*/
 
 

/*
 Future fetchRequest(String id) async{
   List <RequestModel> requests = [] ;
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

    var url = Uri.parse( Config.apiURl + Config.getRequestAPI + id );  
    http.Response  response = await http.get(url, headers: header); 

    if(response.statusCode == 200){
      print(response.statusCode);
      var body = jsonDecode(response.body()); 
      debugPrint("==============================================");
      requests.add(RequestModel.fromJson(body));
      print("${requests.length} :  ${requests[0].body}");
      debugPrint("==============================================");
      print(requests[0].data);
      List<Map<String, dynamic>> r =[];
      r.add(body);
      print(r[0]['body']);
      return r;
      
      }else{
        print(response.statusCode);
        print("reiect");
        //return null;
      }      
    }
*/
 

/*
 Future editRequest(String id) async {
  
  Map<String, String>header = {'Content-Type': 'application/json; charset=UTF-8',};
   String bodii = json.encode({
        "title" : _titleTextEditingController.text,
        "body" : _bodyTextEditingController.text,
        "fromLocation" : {
                "type" : "Point",
                "coordinates" : [globals.fromLat, globals.fromLong]
        },
        "toLocation" : {
                "type" : "Point",
                "coordinates" : [globals.toLat, globals.toLong]
        },
        "priceRange" : {
            "min" : _minPricreTextEditingController.text,
            "max" : _maxPricreTextEditingController.text
        },
        "timeRange" : {
            "val" : _timeRangeTextEditingController.text
        }
    });
  var url = Uri.parse(Config.apiURl+Config.requestAPI+Config.editRequestAPI + id);
  var response = await http.put(url,body: bodii,headers: header);
  if (response.statusCode == 200) {
    print("success");
  } else {
    print("faild");
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}  
*/

}