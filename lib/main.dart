import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_todolist/model/todo_class.dart';
import 'package:simple_todolist/pre_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

String? currentUsername;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoClassAdapter());

  await Hive.openBox<ToDoClass>('todoBox');
  var userBox = await Hive.openBox('userBox');

  currentUsername = userBox.get('currentUser');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent)); // status bar hp
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // debug wm
      home: PrePage(),
    );
  }
}
