import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewer extends StatefulWidget {
  static const String id = "web_viewer";
  final String companyCode;
  final String user;
  final String pass;

  WebViewer({this.companyCode, this.user, this.pass});

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewer> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  @override
  void initState() {
    print('Token : hello iamaqarshare0104 trying to enter');
    var _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
      print('Token : hello iam trying to enter3');
      final tokenStr = token.toString();
      // do whatever you want with the token here

      print('Token : hello iam trying to enter4');
      print('Token : $tokenStr');
    });
    // String token = await WebViewer().getToken();
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final WebViewer args = ModalRoute.of(context).settings.arguments;
    String url = 'https://${args.companyCode}.soliderp.site/';

    return SafeArea(
      child: WebviewScaffold(
        url: url,
        withJavascript: true,
        supportMultipleWindows: true,
        withZoom: true,
        // bottomNavigationBar: BottomAppBar(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       IconButton(
        //         icon: Icon(Icons.arrow_back_ios),
        //         onPressed: () {
        //           flutterWebViewPlugin.goBack();
        //         },
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.arrow_forward_ios),
        //         onPressed: () {
        //           flutterWebViewPlugin.goForward();
        //         },
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.autorenew),
        //         onPressed: () {
        //           flutterWebViewPlugin.reload();
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
