import 'package:flutter/material.dart';
import 'package:simple_todolist/model/todo_class.dart';

class ToDoItem extends StatelessWidget {
  final ToDoClass todoVariable;
  final Function(ToDoClass) onToDoChanged;
  final VoidCallback onDelete;

  const ToDoItem({
    super.key,
    required this.todoVariable,
    required this.onToDoChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Color(0xFF5038BC).withOpacity(0.1),
            width: 0.5), // Border ditambahkan di sini
        boxShadow: [
          BoxShadow(
              color: Color(0xFF5038BC),
              offset: Offset(0, 0),
              blurRadius: 1,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: ListTile(
        onTap: () {
          onToDoChanged(todoVariable);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        leading: Icon(
          todoVariable.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Color(0xFF5038BC),
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
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
