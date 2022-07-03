// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps


import 'package:flutter/material.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';
import 'package:gimme/Models/CommentsModel.dart';
import 'package:gimme/modules/Comments/editComment.dart';

import 'package:gimme/Api/fetchMyComment.dart';
import 'package:gimme/controller/HomeController.dart';
import 'package:gimme/Api/fetchAccountsData.dart';
import 'package:gimme/widget/Cards/CommentCard.dart';
import 'package:gimme/widget/Cards/MyCommentCard.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gimme/shared/global_library.dart' as globals;
import 'package:snippet_coder_utils/FormHelper.dart';



class ShowSearchedReqComments extends StatefulWidget {
  
  final reqId ;
  ShowSearchedReqComments(this.reqId); //wedget.id

  @override
  ShowSearchedReqCommentsState createState() => ShowSearchedReqCommentsState();
}

class ShowSearchedReqCommentsState extends State<ShowSearchedReqComments> {
  
  final FetchMyComments _fetchComments = FetchMyComments();
  final FetchAccounts _fetchOthersAccount = FetchAccounts();

  @override
  void initState() {
    //_fetchOthersAccount.fetchOthersAccount("");
    _fetchComments.fetchMyComment(widget.reqId);  //id=RequestID
    //_fetchRequest.fetchRequests(getUserID());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
      title:const Text('Comments' , style: TextStyle(color: Colors.black , fontSize: 45 ,fontWeight: FontWeight.bold),),
      toolbarHeight: 65,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation:0,  
      automaticallyImplyLeading: true,
      leading: TextButton(
      child:const Text("Back",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 22, color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
      onPressed: ()=> Navigator.pop(context),
        //()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()))          
       )   
      ),
     body:SafeArea(
       child: SingleChildScrollView(
         child: Column(
           children: [
             RefreshIndicator(
                  onRefresh: _refresh,
                  child: FutureBuilder(
                    future: _fetchComments.fetchMyComment(widget.reqId),
                    //future: fetchMyComment(widget.id),
                    builder: (context , snapshot){
                      if(snapshot.hasData){
                      http.Response res = snapshot.data as http.Response;
                      var body = jsonDecode(res.body()); 
                      print("hi :${body}");
                        if (body['data'].isEmpty){
                          print("no comments");
                          return Center(child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text("\n\n\n\n\n\n\n\n\nNo Comments Exist...",style: TextStyle(color: Colors.black , fontSize: 35 ,fontWeight: FontWeight.bold),),
                              const Text("Add one to be first Commenter",style: TextStyle(color: Colors.black , fontSize: 35 ,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        );
                        }else{
                          print("${body}");
                          print("showSearchedReqComments");
                          //List <SearchedReqCommentsModel> comments = [] ;
                          //comments.add(SearchedReqCommentsModel.fromJson(body)); 
                          List comments =[];
                          comments.add(body);
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
                              child :ListView.builder(
                                itemCount:comments[0]['data'].length ,
                                itemBuilder: (context , index){
                                  return comments[0]['data'][index]['userId'] == globals.getUserID()? MyCommentCard(
                                    comments[0]['data'][index]['time']['unit'],
                                    comments[0]['data'][index]['time']['val'],
                                    comments[0]['data'][index]['_id'],
                                    comments[0]['data'][index]['userId'],
                                    comments[0]['data'][index]['text'],
                                    comments[0]['data'][index]['price'],
                                    comments[0]['data'][index]['mod'],
                                    widget.reqId,
                                    key: Key("${index}"),
                                  ):CommentCard(
                                    widget.reqId,
                                    comments[0]['data'][index]['time']['unit'],
                                    comments[0]['data'][index]['time']['val'],
                                    comments[0]['data'][index]['_id'],
                                    comments[0]['data'][index]['userId'],
                                    comments[0]['data'][index]['text'],
                                    comments[0]['data'][index]['price'],
                                    comments[0]['data'][index]['mod'],
                                    key: Key("${index}"),
                                  );
                                }
                              )
                            );
                          }
                        } 
                    }else{
                      return const Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
                    }
                  } 
                ),
              ),
           ],
         ),
      ),
     ),
    ); //_commentsCard(context , widget.id);
  }
  
  
  Widget _commentsCard(
    BuildContext context, /*, String id*/
    String timeUnits,
    dynamic timeValue,
    String userID,//user { request owner/created by} ID
    String commenterUserID, //user {2nd part : current user who'm make the comment} ID
    String text,
    dynamic price,
    dynamic mod,

    ){
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(12.5),
      child: FutureBuilder(
        future: _fetchOthersAccount.fetchOthersAccount(commenterUserID),
        builder: (context,snapshot){
          if (snapshot.hasData){
            http.Response res = snapshot.data as http.Response;
            List commenters = [] ;
              var body = jsonDecode(res.body()); 
              commenters.add(CommentModel.fromJson(body)); 
              switch(snapshot.connectionState){                        
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                  
                case ConnectionState.none:
                  return const Center(child: Text("Error in connection"),);

                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);

                case ConnectionState.done:
                return Column(
                  children:[
                    Container(
                      decoration: BoxDecoration(
                        color:Colors.white ,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width,
                        child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding( //photo
                                padding: const EdgeInsets.only(top: 8 , left: 8 ,bottom: 8),
                                child:Container(//profile photo
                                width: MediaQuery.of(context).size.width*0.17,
                                height: MediaQuery.of(context).size.height*0.06,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(Config.user2ndImageURL,scale:10 ), fit: BoxFit.fill
                                  )
                                ),
                              ),
                            ),

                          const SizedBox(width: 5,),
                          Container(//*** title && body
                          decoration: const BoxDecoration(color:Colors.white,),
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width*0.535,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( "${commenters[0].data['name']}  ",style: const TextStyle(fontSize: 25, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data
                                const Divider(color: primaryColor,),
                                //comment text
                                Text( "${text}  ",style: const TextStyle(fontSize: 15, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data
                              ],
                            ),
                          ),
                        ),
                        /*  
                          Padding(//Accept
                              padding: const EdgeInsets.only(top:5.0 , right: 5),
                              child: SizedBox(//Accept
                                height: MediaQuery.of(context).size.height*0.04,
                                width: MediaQuery.of(context).size.width*0.2,
                                child: TextButton(
                                  child:const Text("Accept",style: TextStyle(fontSize: 15 , color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                  onPressed: (){
                                    print(globals.getUserID());
                                    if (globals.getUserID() == "624ea47be96ec076cbce6e5b"){
                                      print(true);
                                    }else{
                                      print(false);
                                    }
                                    //Accept method || close request method
                                  },
                                  style: ButtonStyle(
                                    //maximumSize: Size.infinite,
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(color: primaryColor),
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ),
                        */
                        ],
                      ) ,
                    ),
                    
                    Container( 
                      decoration: const BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width,
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        
                          Padding(
                          padding: const EdgeInsets.only(bottom: 5.0 ,top: 5),
                          child: Container(
                            decoration: BoxDecoration(color:Colors.white,
                            borderRadius: BorderRadius.circular(10),),
                            height: MediaQuery.of(context).size.height*0.12,
                            width: MediaQuery.of(context).size.width*0.9,
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(//60 EGP
                                    height: MediaQuery.of(context).size.height*0.075,
                                    width: MediaQuery.of(context).size.width*0.2,
                                    child: TextButton(
                                      child: Text("${price}  EGP",style: const TextStyle(fontSize: 15 , color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                      onPressed: (){

                                      },
                                      style: ButtonStyle(
                                        //maximumSize: Size.infinite,
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: const BorderSide(color: primaryColor),
                                        ),
                                      )
                                    ),
                                  ),
                                ),    

                                  const SizedBox(width: 5,),

                                  SizedBox(//3d
                                      height: MediaQuery.of(context).size.height*0.075,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: TextButton(
                                        child:  Text("${timeValue} ${timeUnits} ",style: const TextStyle( fontSize: 20,color: primaryColor ,),), // city name from location
                                        onPressed: (){
                                          print("${commenters[0].data}");
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: const BorderSide(color: primaryColor),
                                          ),
                                        )
                                      ),
                                    ),
                                  ),

                                  Container(//for UI
                                    decoration: BoxDecoration(color:Colors.white,
                                    borderRadius: BorderRadius.circular(10),),
                                    width: MediaQuery.of(context).size.width*0.425
                                  ),
                                  const SizedBox(width: 17.5,),
                                  Center(
                                    child: IconButton(
                                      color: Colors.white,
                                      iconSize: 39,
                                      icon: const Icon(Icons.email),
                                      onPressed: ()=>{
                                        //navigating to massage with this user
                                      },
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
                );
              }
            }
            return const Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
        },
      ),
    );
  }
  
  Widget _ownCommentsCard(
    BuildContext context, /*, String id*/
    String timeUnits,
    dynamic timeValue,
    String userID,//user { request owner/created by} ID
    String commenterUserID, //user {2nd part : current user who'm make the comment} ID
    String text,
    dynamic price,
    dynamic mod,

    ){
    return Card(  
      elevation: 6,
      margin: const EdgeInsets.all(12.5),
      child: FutureBuilder(
        future: _fetchOthersAccount.fetchOthersAccount(commenterUserID),
        builder: (context,snapshot){
          if (snapshot.hasData){
            http.Response res = snapshot.data as http.Response;
            List commenters = [] ;
              var body = jsonDecode(res.body()); 
              commenters.add(CommentModel.fromJson(body));
              print(body);
              print(commenters[0].data);
              switch(snapshot.connectionState){                        
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                  
                case ConnectionState.none:
                  return const Center(child: Text("Error in connection"),);

                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);

                case ConnectionState.done:
                return Column(
                  children:[
                    Container(
                      decoration: BoxDecoration(
                        color:Colors.white ,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width,
                        child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding( //photo
                                padding: const EdgeInsets.only(top: 8 , left: 8 ,bottom: 8),
                                child:Container(//profile photo
                                width: MediaQuery.of(context).size.width*0.17,
                                height: MediaQuery.of(context).size.height*0.06,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(Config.user2ndImageURL,scale:10 ), fit: BoxFit.fill
                                  )
                                ),
                              ),
                            ),

                          const SizedBox(width: 5,),
                          Container(//*** title && body
                          decoration: const BoxDecoration(color:Colors.white,),
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width*0.535,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( "${commenters[0].data['name']}  ",style: const TextStyle(fontSize: 25, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data
                                const Divider(color: primaryColor,),
                                //comment text
                                Text( "${text}  ",style: const TextStyle(fontSize: 15, color: Colors.black , fontWeight: FontWeight.bold),),    //waiting for API data
                              ],
                            ),
                          ),
                        ),
                          
                          Padding(//Edit
                              padding: const EdgeInsets.only(top:5.0 , right: 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height*0.04,
                                width: MediaQuery.of(context).size.width*0.2,
                                child: TextButton(
                                  child:const Text("Edit",style: TextStyle(fontSize: 20 , color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                  onPressed: () =>//Edit [methods] page
                                    Navigator.push(context , MaterialPageRoute( builder: (context) => EditComment(
                                          widget.reqId
                                        ),
                                      ),
                                    ),//routing to edit page,
                                  
                                  style: ButtonStyle(
                                    //maximumSize: Size.infinite,
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(color: primaryColor),
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) ,
                    ),
                    
                    Container( 
                      decoration: const BoxDecoration(color:Colors.white),
                      height: MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width,
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                          padding: const EdgeInsets.only(bottom: 5.0 ,top: 5),
                          child: Container(
                            decoration: BoxDecoration(color:Colors.white,
                            borderRadius: BorderRadius.circular(10),),
                            height: MediaQuery.of(context).size.height*0.12,
                            width: MediaQuery.of(context).size.width*0.9,
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(// EGP
                                    height: MediaQuery.of(context).size.height*0.075,
                                    width: MediaQuery.of(context).size.width*0.2,
                                    child: TextButton(
                                      child: Text("${price}  EGP",style: const TextStyle(fontSize: 15 , color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                      onPressed: (){

                                      },
                                      style: ButtonStyle(
                                        //maximumSize: Size.infinite,
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: const BorderSide(color: primaryColor),
                                        ),
                                      )
                                    ),
                                  ),
                                ),    

                                  const SizedBox(width: 5,),

                                  SizedBox(//Time value & unit
                                      height: MediaQuery.of(context).size.height*0.075,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: TextButton(
                                        child:  Text("${timeValue} ${timeUnits} ",style: const TextStyle( fontSize: 20,color: primaryColor ,),), // city name from location
                                        onPressed: (){
                                          print("${commenters[0].data}");
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: const BorderSide(color: primaryColor),
                                          ),
                                        )
                                      ),
                                    ),
                                  ),

                                  Container(//for UI
                                    decoration: BoxDecoration(color:Colors.white,
                                    borderRadius: BorderRadius.circular(10),),
                                  width: MediaQuery.of(context).size.width*0.425),
                                  const SizedBox(width: 17.5,),
                                  Center(//Delete comment
                                    child: IconButton(
                                      color: Colors.black,
                                      iconSize: 39,
                                      icon: const Icon(Icons.delete),
                                      onPressed: ()=>{ ///calling delete comment method
                                        _deleteComment(context,widget.reqId)
                                      },
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
                );
              }
            }
            return const Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
        },
      ),
    );
  }



Future  _deleteComment(BuildContext context ,String id) async{ 
  
  Map<String,String> header = { "Authorization":"Bearer " + (prefs.getString("token") as String),};

    var url = Uri.parse(Config.apiURl+Config.commentAPI+ id);
    var response = await http.delete(url , headers: header);

    if(response.statusCode == 200){
    var body = jsonDecode(response.body());
    print(body["status"]);
      if (body["status"]== true){
      FormHelper.showSimpleAlertDialog(
        context, 
        Config.appName,
        "Success : Comment has been deleted !!!",
        "Ok", 
        (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()));  
      },);
      } else {
        FormHelper.showSimpleAlertDialog(
        context, 
        Config.appName,
        "Faild : Something went Error !!!",
        "Ok", 
        (){
        Navigator.pop(context);  
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeControllerPage()));  
      },);
      }
    }else if (response.statusCode == 404){
      FormHelper.showSimpleAlertDialog(
      context, 
      Config.appName,
      "Error ${response.statusCode}: Comment doens't exist ",
      "Ok", 
      (){
      Navigator.pop(context);  
    },);
    }  
  }

Future<void> _refresh() async {
  setState(() {});
    return Future.delayed(
      const Duration(milliseconds: 500)
    );
  }

}