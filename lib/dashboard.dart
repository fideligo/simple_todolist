import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_todolist/model/todo_class.dart';
import 'package:simple_todolist/widgets/task_section.dart';
import 'package:simple_todolist/add_task.dart';
import 'package:simple_todolist/pre_page.dart';
import 'package:simple_todolist/edit_task.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  final List<ToDoClass> todoLists = ToDoClass.todoList();
  ToDoClass? selectedTask; // Fix: Added missing variable

  void _toggleToDo(ToDoClass todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
      selectedTask = null; // Clear selection after deletion
    });
  }

  void _navigateToAddTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTask()),
    );

    if (newTask != null && newTask is ToDoClass) {
      setState(() {
        todoLists.add(newTask);
      });
    }
  }

  void _navigateToEditTask(ToDoClass task) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTask(task: task), // Pass selected task
      ),
    );

    if (editedTask != null && editedTask is ToDoClass) {
      setState(() {
        // Find the original task and update it
        int index = todoLists.indexWhere((t) => t.id == editedTask.id);
        if (index != -1) {
          todoLists[index] = editedTask;
        }
        selectedTask = null; // Clear selection after editing
      });
    }
  }

  void _handleLongPress(ToDoClass task) {
    setState(() {
      selectedTask = task;
    });
  }

  void _clearSelection() {
    setState(() {
      selectedTask = null;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PrePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: selectedTask != null
          ? AppBar(
              backgroundColor: Color(0xFF5038BC),
              foregroundColor: Colors.white,
              title: Text(selectedTask?.todoText ?? "Task Selected",
                  style: TextStyle(fontSize: 18, fontFamily: "Poppins")),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    if (selectedTask != null) {
                      _navigateToEditTask(selectedTask!);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (selectedTask != null) {
                      _deleteToDo(selectedTask!.id);
                    }
                  },
                ),
              ],
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _clearSelection,
              ),
            )
          : null,
      body: GestureDetector(
        onTap: _clearSelection, // Tap anywhere to clear selection
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: false,
              snap: true,
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 10),
                title: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Welcome Fideligo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 18,
                        ),
                        maxLines: 1,
                      ),
                      const Text(
                        "Have a nice day !",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  TaskSection(
                    title: 'Priority Task',
                    selectedTask: selectedTask,
                    tasks: todoLists
                        .where((todo) => todo.todoType == 'Priority')
                        .toList()
                      ..sort((a, b) => a.isDone == b.isDone
                          ? 0
                          : a.isDone
                              ? 1
                              : -1),
                    onToDoChanged: _toggleToDo,
                    onDelete: _deleteToDo,
                    onLongPress: _handleLongPress,
                  ),
                  TaskSection(
                    title: 'Daily Task',
                    selectedTask: selectedTask,
                    tasks: todoLists
                        .where((todo) => todo.todoType == 'Daily')
                        .toList()
                      ..sort((a, b) => a.isDone == b.isDone
                          ? 0
                          : a.isDone
                              ? 1
                              : -1),
                    onToDoChanged: _toggleToDo,
                    onDelete: _deleteToDo,
                    onLongPress: _handleLongPress,
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => _onItemTapped(0),
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        backgroundColor: const Color(0xFF5038BC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
