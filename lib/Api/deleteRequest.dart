import 'package:flutter/material.dart';
import 'package:gimme/controller/HomeController.dart';
import 'package:gimme/utilies/config.dart';
import 'package:gimme/main.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

class DeleteRequest{

  ///Delete requests 
  Future deleteRequest(BuildContext context, String id) async {
    Map<String, String> header = {
      "Authorization": "Bearer " + (prefs.getString("token") as String),
    };

    var url = Uri.parse(
        Config.apiURl + Config.requestAPI + Config.deleteRequestAPI + id);
    var response = await http.delete(url, headers: header);

    if (response.statusCode == 200) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        " Request has been deleted !!! ",
        "Ok",
        () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeControllerPage()));
        },
      );
    } else if (response.statusCode == 400) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        " ${response.statusCode} Bad Request! , Invalid Syntax : request is not deleted ",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
      print("reject");
    } else if (response.statusCode == 403) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Eror ${response.statusCode} : Forbidden!!,\n\nCan't perform this action / Can't delete : must be closed ",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
      print("reject");
    } else if (response.statusCode == 404) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Error ${response.statusCode}: Not Found!,\t Request not found ",
        "Ok",
        () {
          Navigator.pop(context);
        },
      );
      print("reject");
    }
  }

}