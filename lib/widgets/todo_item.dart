import 'package:flutter/material.dart';
import 'package:simple_todolist/model/todo_class.dart';

class ToDoItem extends StatelessWidget {
  final ToDoClass todoVariable;
  final Function(ToDoClass) onToDoChanged; // Define function type
  final VoidCallback onDelete; // Define as VoidCallback

  const ToDoItem({
    super.key,
    required this.todoVariable,
    required this.onToDoChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          onToDoChanged(todoVariable); // Call function with todo object
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        leading: Icon(
          todoVariable.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.cyan,
        ),
        title: Text(
          todoVariable.todoText,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            decoration: todoVariable.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: onDelete, // Call delete function
          ),
        ),
      ),
    );
  }
}
