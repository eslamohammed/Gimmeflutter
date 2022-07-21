
import 'package:flutter/material.dart';
import 'package:gimme/shared/config.dart';





class AlertDialogWidget {

  /*
    description---

    Widget was created to show a specific message to user 
      -it simply used to show two option for me/programmers worked with me in this project
      -it able us to choose one of two Actions
      -***Yes*** is to do something when user press Yes
      -***No***  to do something else No

    How to use---

      -Copy this After import [AlertDialogWidget] class
      -put Your methods [what you need to do / choose from] instead [1] , [2]
        AlertDialogWidget.alartDialog(
          context,
          "Delete ?",
          ()=>{
            [1]
            ///eg. i try to excute delete method 
            DeleteRequest().deleteRequest(context,reqID),
            Navigator.pop(context),
          },
          ()=>{
            [2]
            ///trying to do somthing else
            Navigator.pop(context),
          },
        );
  */


   static alartDialog(BuildContext context , String message , Function onPressed_Yes , Function onPressed_NO  ) async{
      return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("${Config.appName}: Alert dialog."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
//                Text(''),
                Text("$message"),//'Would you like to approve of this message?'
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {return onPressed_Yes();},
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () { return onPressed_NO();},
            ),
          ],
        );
      },
    );
  }


  static void showAlertDialog(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: [
            // submitButton(
            //   buttonText,
            //   onPressed(),
            // ),
            new TextButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            ),
            new TextButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            )
          ],
        );
      },
    );
  }
  }