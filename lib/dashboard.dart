import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_todolist/model/todo_class.dart';
import 'package:simple_todolist/profile_page.dart';
import 'package:simple_todolist/widgets/task_section.dart';
import 'package:simple_todolist/add_task.dart';
import 'package:simple_todolist/edit_task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  List<ToDoClass> todoLists = [];
  late Box<ToDoClass> todoBox;
  late Box userBox;
  String username = 'User';
  ToDoClass? selectedTask;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('userBox');
    _loadUserData();
    _openBox().then((_) => _loadToDos());
  }

  Future<void> _openBox() async {
    Box sessionBox = Hive.box('sessionBox');
    String currentUsername =
        sessionBox.get('currentUser', defaultValue: 'User');

    if (Hive.isBoxOpen('todoBox_$username')) {
      await Hive.box<ToDoClass>('todoBox_$username').close();
    }

    if (Hive.isBoxOpen('todoBox_$currentUsername')) {
      todoBox = Hive.box<ToDoClass>('todoBox_$currentUsername');
    } else {
      todoBox = await Hive.openBox<ToDoClass>('todoBox_$currentUsername');
    }

    setState(() {
      username = currentUsername;
    });
  }

  void _loadUserData() {
    Box sessionBox = Hive.box('sessionBox');
    String currentUser =
        sessionBox.get('currentUser', defaultValue: 'User') ?? 'User';

    setState(() {
      username = currentUser;
    });

    _openBox().then((_) => _loadToDos());
  }

  void _loadToDos() {
    setState(() {
      todoLists = todoBox.values.cast<ToDoClass>().toList();
    });
  }

  void _toggleToDo(ToDoClass todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      todoBox.put(todo.id, todo);
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
      todoBox.delete(id);
      selectedTask = null;
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
        todoBox.put(newTask.id, newTask);
      });
    }
  }

  void _navigateToEditTask(ToDoClass task) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTask(task: task),
      ),
    );

    if (editedTask != null && editedTask is ToDoClass) {
      setState(() {
        int index = todoLists.indexWhere((t) => t.id == editedTask.id);
        if (index != -1) {
          todoLists[index] = editedTask;
          todoBox.put(editedTask.id, editedTask);
        }
        selectedTask = null;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: selectedTask != null
          ? AppBar(
              backgroundColor: const Color(0xFF5038BC),
              foregroundColor: Colors.white,
              title: Text(selectedTask?.todoText ?? "Task Selected",
                  style: const TextStyle(fontSize: 18, fontFamily: "Poppins")),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          GestureDetector(
            onTap: _clearSelection,
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
                          Text(
                            "Welcome $username",
                            style: const TextStyle(
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
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 0.3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color:
                        _selectedIndex == 0 ? const Color(0xFF5038BC) : null),
                onPressed: () => _onItemTapped(0),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.person,
                    color:
                        _selectedIndex == 1 ? const Color(0xFF5038BC) : null),
                onPressed: () => _onItemTapped(1),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        backgroundColor: const Color(0xFF5038BC),
        elevation: 10,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
