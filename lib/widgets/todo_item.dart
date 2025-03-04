import 'package:flutter/material.dart';
import 'package:simple_todolist/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;

  const ToDoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          print("Clicked");
        },
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        leading: Icon(Icons.check_box, color: Colors.cyan),
        title: Text(todo.todoText,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                decoration: TextDecoration.lineThrough)),
        trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: const Icon(Icons.delete),
              onPressed: () {
                print("Clicked delete");
              },
            )),
      ),
    );
  }
}
