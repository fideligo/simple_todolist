import 'package:flutter/material.dart';
import 'package:simple_todolist/widgets/todo_item.dart';
import 'package:simple_todolist/model/todo_class.dart';

class Todolistpage extends StatefulWidget {
  Todolistpage({super.key});

  @override
  State<Todolistpage> createState() => _TodolistpageState();
}

class _TodolistpageState extends State<Todolistpage> {
  final todoLists = ToDoClass.todoList();
  List<ToDoClass> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoLists;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 222, 242, 255),
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(children: [
                  SearchBox(onSearch: _runFilter), // Pass _runFilter here
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 15),
                            child: const Text("To Do's",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22))),
                        for (ToDoClass TodosInsideList in _foundToDo.reversed)
                          ToDoItem(
                            todoVariable: TodosInsideList,
                            onToDoChanged:
                                _ToDoChangeListener, // Pass function correctly
                            onDelete: () => _ToDoDelete(TodosInsideList
                                .id), // Implement delete logic later
                          )
                      ],
                    ),
                  )
                ])),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: 20, right: 20, left: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    offset: Offset(0.0, 0.0),
                                    spreadRadius: 0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: _todoController,
                              decoration: InputDecoration(
                                  hintText: "Add a new task",
                                  border: InputBorder.none),
                            ))),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        child: Text("+", style: TextStyle(fontSize: 40)),
                        onPressed: () {
                          if (_todoController.text.isEmpty) {
                            _TodoAdd("New Task");
                          } else {
                            _TodoAdd(_todoController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: Size(60, 60),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  void _ToDoChangeListener(ToDoClass todoParameter) {
    setState(() {
      todoParameter.isDone = !todoParameter.isDone;
    });
  }

  void _ToDoDelete(String id) {
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
    });
  }

  void _TodoAdd(String TodoTaskName) {
    setState(() {
      todoLists.add(ToDoClass(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: TodoTaskName));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDoClass> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoLists;
    } else {
      results = todoLists
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 222, 242, 255),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu, color: Colors.black, size: 30),
            Container(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/img/tudulis.png',
                  ),
                ))
          ],
        ));
  }
}

class SearchBox extends StatefulWidget {
  final Function(String) onSearch;
  const SearchBox({super.key, required this.onSearch});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) =>
            widget.onSearch(value), // Call the search function
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: Colors.black),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
