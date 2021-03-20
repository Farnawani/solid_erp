import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:solid_erp/Hint.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:solid_erp/web_viewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:solid_erp/Database.dart';

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

  // Future<List<Hint>> getHints() async {
  // // Get a reference to the database.
  // final Database db = await widget.database;
  //
  // // Query the table for all The Dogs.
  // final List<Map<String, dynamic>> maps = await db.query('hints');
  //
  // // Convert the List<Map<String, dynamic> into a List<Dog>.
  // return List.generate(maps.length, (i) {
  //   return Hint(
  //       hint: maps[i]['hint'],
  //     );
  //   });
  // }

  // _query() async {
  //
  //   // get a reference to the database
  //   final Database db = await widget.database;
  //
  //   // raw query
  //   List<Map> result = await db.rawQuery('SELECT * FROM hints');
  //
  //   // print the results
  //   result.forEach((row) => print(row));
  //   // {_id: 2, name: Mary, age: 32}
  // }

  // void insertHint(Hint hint) async {
  //   // Get a reference to the database.
  //   final Database db = await widget.database;
  //   // Insert the Dog into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   // await db.insert(
  //   //   'hints',
  //   //   hint.toMap(),
  //   //   conflictAlgorithm: ConflictAlgorithm.replace,
  //   // );
  //   await db.rawInsert('INSERT INTO hints (hint) VALUES(${hint.toMap()})');
  // }

  // void initializeList() async {
  //   List<Hint> mapsList = await getHints();
  //   for(int i = 0; i < mapsList.length; i++){
  //     // print("mapsList");
  //     print(mapsList);
  //   }
  // }

  // void initialize ()async{
  //   widget.database=openDatabase(
  //       join(await getDatabasesPath(), 'hints_database.db'),
  //   onCreate: (db, version) {
  //   return db.execute(
  //   "CREATE TABLE hints(hint TEXT)",
  //   );
  //   },
  //   version: 1,
  //   );
  // }
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
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: myController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '   Enter URL',
                      suffixIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          myController.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return availHints
                              .map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(
                                child: Text(value), value: value);
                          }).toList();
                        },
                      ),
                    ),
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
