// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, non_constant_identifier_names, unused_field

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gimme/config.dart';
import 'package:gimme/main.dart';
import 'package:gimme/pages/Search/SearchRequestDetails.dart';
import 'package:gimme/pages/Search/searchRequestModel.dart';
import 'package:gimme/pages/profiles/fetchAccountsData.dart';
import 'package:gimme/pages/profiles/otherProfilesPage.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:gimme/widget/customInputTextField.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {  
  @override
  _SearchPageState createState() =>_SearchPageState();
}
class _SearchPageState extends State<SearchPage>{
  final TextEditingController _From= TextEditingController();
  final TextEditingController _To= TextEditingController();

  final FetchAccounts _fetchOthersAccount = FetchAccounts();
  String searchString = "";
  int filter = 0;
  
  
  @override
  void dispose(){
    _From.dispose();
    _To.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
      title:const Text('Home' , style: TextStyle(color: Colors.black , fontSize: 47.5 ,fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation:0,  
      automaticallyImplyLeading: true,
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new , color: primaryColor, size: 35,),
      onPressed: ()=> {}//Navigator.pop(context , false),
      )   
      ),     
     body: _searchUI(context),
    //////////////////
   );
 }
 
  ///The first part search screen
  ///it used for inserting & Controlling inserted data By user 
  Widget _searchUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                
                Padding( //From
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(color: HexColor("#E5E5E5"),
                    borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomInputTextFieldWidget(hintText: "\t\t From ",
                      secure: false, ccontroller:_From ),
                    )
                  ),
                ),
            
                Padding( //To
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(color: HexColor("#E5E5E5"),
                    borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomInputTextFieldWidget(hintText: "\t\t To ",
                      secure: false, ccontroller:_To ),
                    )
                  ),
                ),
            
                Center( //search
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height *0.075,
                  
                    decoration: const BoxDecoration(  
                    color: Colors.black12,
                    borderRadius:  BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                    )
                  ),    

                    child: Center( //Add request button & calling Addrequest() Function function;
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(onPressed: () async{//Calling search() function

                      setState(() {
                        filter++;
                      });              

                    },
                    child: Padding(//Add Request
                    padding: const EdgeInsets.all(12.5),
                    child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: const Center(
                    child: Text("  Search" , style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize:25,),),
                      ),
                      ),
                    ),
                    color: primaryColor,
                    shape: const StadiumBorder(),
                        ),
                      ),
                    ), 
                  ),
                ),
            ],
            
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top :10.0),
              child: SizedBox(
                child: filter != 0 ? RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder(
                  //initialData: [ _fetchRequest.fetchRequests(getUserID())],
                  future: getSearchedRequest(_To.text ,_From.text),
                  builder: (context , snapshot){
                    if(snapshot.hasData){
                    http.Response res = snapshot.data as http.Response;
                    var body = jsonDecode(res.body());
                    //print("${body["data"].isEmpty}");
                    //print("${body["data"]}");
                    print("${body["data"][0]["timeRange"]["unit"]}");

                    if(body["data"].isEmpty){
                      return const Center(child: Text("\n\n\n\n   NO Result\nInvalid syntax", style :TextStyle(fontSize: 45 , fontWeight: FontWeight.bold),));
                    }else{
                      List <SearchRequestModel> resultReq = [] ;
                        resultReq.add(SearchRequestModel.fromJson(body));
                        switch(snapshot.connectionState){                        
                          case ConnectionState.waiting:
                            return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                            
                          case ConnectionState.none:
                            return const Center(child: Text("Error in connection"),);
              
                          case ConnectionState.active:
                            return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
              
                          case ConnectionState.done:
                            return SizedBox(
                              height: 720,
                              width: MediaQuery.of(context).size.width,
                              child:// resultReq[0].data[x].isNotEmpty
                                    //?
                                    ListView.builder(
                                      itemCount:resultReq[0].data.length,
                                      itemBuilder: (context , index){
                                        return reqResultCard(///routing data to request card
                                          context,
                                          resultReq[0].data[index]['body'].toString(),
                                          resultReq[0].data[index]['title'].toString(),
                                          resultReq[0].data[index]['_id'].toString(),
                                          resultReq[0].data[index]["timeRange"]["val"] ,
                                          resultReq[0].data[index]["priceRange"]["min"],
                                          resultReq[0].data[index]["priceRange"]["max"],
                                          resultReq[0].data[index]['fromAddress'],
                                          resultReq[0].data[index]['toAddress'],
                                          resultReq[0].data[index]['userId'],
                                          resultReq[0].data[index]["timeRange"]["unit"] ,

                                        );
                                      }
                                    )//: Center(child: Image.asset("path/image/img.png")),
                                  /*
                                  Column(
                                children: <Widget> [

                                  Padding(
                                  padding: const EdgeInsets.all(8.0) ,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState((){
                                        searchString = value; 
                                      });
                                    },
                                    controller: _To,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                                  Expanded(
                                    child :
                                  ),
                                ],
                              ),*/
                                );
                              }
                            }
                          } 
                          return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                    } 
                  ),
                ):const Center(child: Text("\n\n\n\nNo Result", style :TextStyle(fontSize: 45),)),
              ),
            ),
          ),
        ],
      ),
    );  
  }
  
  ///featching all result requests from search
  Future <http.Response> getSearchedRequest(String to , String from) async{
    var header = {"Authorization":"Bearer " + (prefs.getString("token") as String)};

    var url = Uri.parse(Config.apiURl+Config.requestAPI+Config.searchRequestAPI+to+Config.searchFromRequestAPI+from);  //payload['_id']);//Config.apiURl+ Config.getRequestAPI);
    return await http.get(url, headers: header);
  }
  ///waiting untill refreshing 
    Future<void> _refresh() async {
    return Future.delayed(
      const Duration(seconds: 2)
    );
  }

  ///UI widget to show the result data
  ///Data mapping card in UI
   Widget reqResultCard (
   BuildContext context,
   String reqBody,
   String reqTitle,
   String reqID,
   dynamic reqtimerange,
   dynamic reqminPrice,
   dynamic reqmaxPrice,
   dynamic fromAddress,
   dynamic toAddress,
   dynamic requesterID,
   dynamic reqtimeunit,

   )
   {return InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchRequestDetails(reqBody,reqTitle,reqID,reqtimerange,reqminPrice,reqmaxPrice,reqtimeunit))),
    child: FutureBuilder(
        future: _fetchOthersAccount.fetchOthersAccount(requesterID),
        builder: (context,snapshot){
          if (snapshot.hasData){
            http.Response res = snapshot.data as http.Response;
              var body = jsonDecode(res.body()); 
              if (body["status"]==true) {
                switch(snapshot.connectionState){                        
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                  
                case ConnectionState.none:
                  return const Center(child: Text("Error in connection"),);

                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);

                case ConnectionState.done:
                  return Card(
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
                              height: MediaQuery.of(context).size.height*0.21,
                              width: MediaQuery.of(context).size.width,
                              child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
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
                                          ///making Username routalbe  
                                          ///navigating to user page
                                          text:"\t\t${body['data']['name']} ", //Show user name
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            //decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                          ..onTap = (){ // route to this Othor accounts page
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> OthersProfilePages(
                                              ///User infos
                                              ///The data comming from API
                                              body['data']['name'],
                                              "rate",
                                              body['data']['isTrusted'],
                                              body['data']['createTime']
                                              )));
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                    width: MediaQuery.of(context).size.width*0.66,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //title
                                          Text("#$reqTitle ",style: const TextStyle(fontSize: 33, color: Colors.black ,fontWeight: FontWeight.bold), ),   //waiting for API data
                                          const Divider(color: primaryColor,),
                                          //body
                                          Text( "//  $reqBody  ",style: const TextStyle(fontSize: 20, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data
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
                            height: MediaQuery.of(context).size.height*0.075,
                            width: MediaQuery.of(context).size.width,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [ 
                                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
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
                                          width: MediaQuery.of(context).size.width*0.35,
                                          child: TextButton(
                                            child:Row(
                                              //mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                              Center(child: Text(fromAddress,style: const TextStyle(fontSize: 15,color: primaryColor ,),)),
                                              SizedBox(width:MediaQuery.of(context).size.width*0.001,),
                                              const Icon(Icons.arrow_forward , color: primaryColor,),
                                              ],
                                            ),//Icon(Icons.ac_unit_sharp), // city name from location
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
                                            width: MediaQuery.of(context).size.width*0.35,
                                            child: TextButton(
                                              child:  Text(toAddress,style: const TextStyle( fontSize: 20,color: primaryColor ,),), // city name from location
                                              onPressed: ()async{
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
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
              }
            }
          return const Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
        },
      ),
    );
  }

}

/*



 */