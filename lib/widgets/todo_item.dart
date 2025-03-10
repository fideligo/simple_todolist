import 'package:flutter/material.dart';
import 'package:simple_todolist/model/todo_class.dart';

class ToDoItem extends StatelessWidget {
  final ToDoClass todoVariable;
  final Function(ToDoClass) onToDoChanged;
  final VoidCallback onDelete;
  final VoidCallback onLongPress;
  final ToDoClass? selectedTask;

  const ToDoItem({
    super.key,
    required this.todoVariable,
    required this.selectedTask,
    required this.onToDoChanged,
    required this.onDelete,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedTask == todoVariable;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEDE7F6) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFF5038BC).withOpacity(0.3),
              width: isSelected ? 2 : 0.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF5038BC).withOpacity(0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ]
                : [],
          ),
          child: ListTile(
            onTap: () {
              onToDoChanged(todoVariable);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            tileColor: Colors.transparent,
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: todoVariable.isDone
                      ? Colors.grey
                      : const Color(0xFF5038BC),
                  width: 2,
                ),
              ),
              child: !todoVariable.isDone
                  ? const Icon(Icons.circle, size: 20, color: Color(0xFF5038BC))
                  : null,
            ),
            title: Text(
              todoVariable.todoText,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
                fontFamily: 'Poppins',
                color:
                    todoVariable.isDone ? Colors.grey : const Color(0xFF5038BC),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
