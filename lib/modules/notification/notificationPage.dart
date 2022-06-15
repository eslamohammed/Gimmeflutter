import 'package:flutter/material.dart';
import 'package:gimme/modules/Google_maps/getLatLong.dart';
import 'package:gimme/main.dart';
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Notification Page"),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: GetLatLong(),
        ),
      );
}
