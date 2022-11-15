
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'database/helper.dart';

class SqliteHomePage extends StatefulWidget {
  const SqliteHomePage({Key? key}) : super(key: key);

  @override
  State<SqliteHomePage> createState() => _SqliteHomePageState();
}

class _SqliteHomePageState extends State<SqliteHomePage> {

  String path = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localPath();

  }

  localPath() async {
    var db = Favourite_Helper();
    await db.initDb().then((value) async{
         print("=--value-->${value}");
          db.getAllData();
          // db.insertQuery();
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
