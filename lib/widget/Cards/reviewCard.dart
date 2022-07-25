import 'package:flutter/material.dart';
import 'package:gimme/Api/Comment/deleteComment.dart';
import 'package:gimme/Api/review/fetchReview.dart';
import 'package:gimme/modules/Comments/editComment.dart';
import 'package:gimme/shared/config.dart';
import 'package:gimme/main.dart';

import 'package:gimme/Api/user/fetchAccountsData.dart';
import 'package:gimme/Models/CommentsModel.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;


class ReviewCard extends StatelessWidget {
   ReviewCard(
     //{ Key? key }
     this.timeUnits,
     this.timeValue,
     this.commentID,
     this.commenterUserID,
     this.text,
     this.price,
     this.mod,
     this.reqId, {Key? key}
     ) : super(key: key);

  final FetchReviews _fetchReviews = FetchReviews();
  final  String timeUnits;
  final  dynamic timeValue;
  final  String commentID;
  final  dynamic commenterUserID;
  final  dynamic text;
  final  dynamic price;
  final  dynamic mod;
  final  String reqId;

  @override
  Widget build(BuildContext context) {
    return _ownCommentsCard(
      context,
      timeUnits,
      timeValue,
      commentID,
      commenterUserID,
      text,
      price,
      mod,
      reqId
    );
  }

    
  Widget _ownCommentsCard(
    BuildContext context, /*, String id*/
    String timeUnits,
    dynamic timeValue,
    String commentID,//user { request owner/created by} ID
    String commenterUserID, //user {2nd part : current user who'm make the comment} ID
    String text,
    dynamic price,
    dynamic mod,
    String requestID
    ){
    return Card(  
      elevation: 6,
      margin: const EdgeInsets.all(12.5),
      child: FutureBuilder(
        future: _fetchReviews.fetchReview("6298b4b47673a4bee18a7315"),//commenterUserID),
        builder: (context,snapshot){
          if (snapshot.hasData){
            http.Response res = snapshot.data as http.Response;

            print(res.body());
            List reviewers = [] ;
              var body = jsonDecode(res.body()); 
              reviewers.add(CommentModel.fromJson(body));
              //print("MyreviewCard :${body}");
              switch(snapshot.connectionState){                        
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);
                  
                case ConnectionState.none:
                  return const Center(child: Text("Error in connection"),);

                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,),);

                case ConnectionState.done:
                return Center(child: Text("S"),);
              }
            }
            return const Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
        },
      ),
    );
  }


}

/*


                Column(
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

                          SizedBox(width: MediaQuery.of(context).size.width*0.01),
                          
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
                                    Navigator.push(context , MaterialPageRoute( 
                                      builder: (context) => EditComment( reqId ),
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
                              child: Row(//price & units & delete
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(// EGP
                                    height: MediaQuery.of(context).size.height*0.075,
                                    width: MediaQuery.of(context).size.width*0.2,
                                    child: TextButton(
                                      child: Text("${price}  EGP",style: const TextStyle(fontSize: 15 , color: primaryColor ,),) ,//Icon(Icons.ac_unit_sharp), // city name from location
                                      onPressed: (){
                                        print("Request ID :"+reqId);
                                        print("Comment ID :"+commentID);
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

                                  SizedBox(width: MediaQuery.of(context).size.width*0.01,),

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
                                        DeleteComment().deleteComment(context,requestID,commentID)

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
              
*/
 */