import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_todolist/model/todo_class.dart';
import 'package:simple_todolist/widgets/task_section.dart';
import 'package:simple_todolist/add_task.dart';
import 'package:simple_todolist/pre_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());

  final List<ToDoClass> todoLists = ToDoClass.todoList();

  void _toggleToDo(ToDoClass todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            pinned: false, // App bar disappears when scrolling
            snap: true, // Instantly appears when scrolling up
            floating: true, // Appears when user scrolls up a little
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 10),
              title: Container(
                margin: EdgeInsets.only(left: 12),
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
              delegate: SliverChildListDelegate(
                [
                  TaskSection(
                    title: 'Priority Task',
                    tasks: todoLists
                        .where((todo) => todo.todoType == 'Priority')
                        .toList(),
                    onToDoChanged: _toggleToDo,
                    onDelete: _deleteToDo,
                  ),
                  TaskSection(
                    title: 'Daily Task',
                    tasks: todoLists
                        .where((todo) => todo.todoType == 'Daily')
                        .toList(),
                    onToDoChanged: _toggleToDo,
                    onDelete: _deleteToDo,
                  ),
                  const SizedBox(height: 80), // Space for floating button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF5038BC).withOpacity(0.1), // Soft shadow color
              blurRadius: 10, // Spread effect
              spreadRadius: 2, // Makes it more visible
              offset: const Offset(0, -3), // Moves shadow upwards
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          elevation: 0, // Set to 0 because we handle shadow manually
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () => _onItemTapped(0),
              ),
              const SizedBox(width: 40), // Space for the floating button
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => _onItemTapped(1),
              ),
            ],
          ),
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
