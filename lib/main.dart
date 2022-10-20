import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'tambah_data.dart';
import 'list.dart';
import 'model/object.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
