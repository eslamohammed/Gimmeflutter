import 'package:flutter/material.dart';
import 'package:gimme/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateStripeAccount extends StatefulWidget {
  const CreateStripeAccount(
    this.StripeUrl,
    { Key? key }) : super(key: key);
  final StripeUrl;
  @override
  _CreateStripeAccountState createState() => _CreateStripeAccountState();
}

class _CreateStripeAccountState extends State<CreateStripeAccount> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gimme Srtipe Account"),
        backgroundColor:primaryColor,
        actions: [
          IconButton(
            onPressed: () async{
              controller.reload();
            },
            icon: Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () async{
              if(await controller.canGoBack()){
                controller.goBack();
              }
            },
            icon: Icon(Icons.update),
          ),
          
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.StripeUrl,//'https://www.youtube.com/watch?v=qDl8F2MElms',//widget.StripeUrl,
        onWebViewCreated: (controller){
          this.controller = controller;
        },
      ),
    );
  }
}