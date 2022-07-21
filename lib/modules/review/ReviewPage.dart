
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gimme/modules/Review/review.dart';
import 'package:gimme/shared/components/components.dart';
//import 'package:gimme/modules/review/review.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewPage createState() => _AddReviewPage();
}

class _AddReviewPage extends State<AddReview> {
   int? _rating;
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading:const Icon(Icons.arrow_back),
          title: const Text("Review Page")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Rate This User',
              style: TextStyle(color: Colors.black,fontSize: 30,),),
              const SizedBox(
                height: 10,
              ),
              Rating((rating) {
                setState(() {
                  _rating = rating;
                });
              }, 5),
              SizedBox(
                  height: 44,
                  child: (_rating != null && _rating != 0)
                      ? Text("You selected $_rating rating",
                          style: const TextStyle(fontSize: 18))
                      : const SizedBox.shrink()),
              const Text('Add Comment ',
              style: TextStyle(color: Colors.black,fontSize: 30,),),
              const SizedBox(
                height: 10,
              ),
                  defaultTextField(
                    controller: commentController, 
                    label: 'Write Your Review', 
                    prefix:  Icons.comment, 
                    type: TextInputType.text, 
                    validate: (String? value ) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                      }
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultBtn(
                    text: 'Add Review',
                    function: () {
                      
                        print("email ${commentController.text} ");
                        print("password $_rating ");

                    },
                  ),

            ],
          ),
        ));
  }
}
