import 'package:flutter/material.dart';
import 'package:simple_todolist/model/todo_class.dart';
import 'package:simple_todolist/widgets/todo_item.dart';

class TaskSection extends StatelessWidget {
  final ToDoClass? selectedTask;
  final String title;
  final List<ToDoClass> tasks;
  final Function(ToDoClass) onToDoChanged;
  final Function(String) onDelete;
  final Function(ToDoClass) onLongPress;

  const TaskSection({
    super.key,
    required this.selectedTask,
    required this.title,
    required this.tasks,
    required this.onToDoChanged,
    required this.onDelete,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        for (var task in tasks)
          ToDoItem(
            todoVariable: task,
            selectedTask: selectedTask,
            onToDoChanged: onToDoChanged,
            onDelete: () => onDelete(task.id),
            onLongPress: () => onLongPress(task),
          ),
        const SizedBox(height: 5),
      ],
    );
  }
}
