import 'dart:io';
import 'package:solid_erp/Hint.dart';
import 'package:flutter/material.dart';
import 'package:solid_erp/web_viewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:solid_erp/Database.dart';
import 'package:dropdownfield/dropdownfield.dart';

import 'Database.dart';

class StartPage extends StatefulWidget {
  static const String id = "start_page";

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final myController = TextEditingController();

  Map<String, String> newHintMap = {};
  List<String> availHints = [];

  getHint() async {
    final _hintData = await DBProvider.db.getHint();
    for (var i in _hintData) {
      availHints.add(i['hint']);
    }
    print(availHints);
  }

  @override
  void initState() {
    super.initState();

    print('after');
    getHint();
    print('before');

    // Enable hybrid composition
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF921111),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 370.0,
                  child: Column(
                    children: [
                      DropDownField(
                        strict: false,
                        controller: myController,
                        hintText: "Enter URL",
                        enabled: true,
                        items: availHints,
                        onValueChanged: (value){
                          setState(() {
                            myController.text = value;
                          });
                        },

                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              elevation: 5.0,
              color: Color(0xFF333333),
              borderRadius: BorderRadius.circular(10.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    var newDBHint = Hint(
                      hint: myController.text,
                    );
                    DBProvider.db.newHint(newDBHint);
                  });
                  Navigator.pushNamed(
                    context,
                    WebViewer.id,
                    arguments: WebViewer(companyCode: myController.text),
                  );
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'GO',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
