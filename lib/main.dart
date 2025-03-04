import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simple_todolist/pre_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent)); //statusbar hp
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // debug wm
      home: PrePage(),
    );
  }
}
