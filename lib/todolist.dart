import 'package:flutter/material.dart';
import 'package:simple_todolist/widgets/todo_item.dart';
import 'package:simple_todolist/model/todo.dart';

class Todolistpage extends StatelessWidget {
  Todolistpage({super.key});

  final todoLists = ToDo.todoList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 222, 242, 255),
        appBar: _buildAppBar(),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(children: [
              _searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, bottom: 15),
                        child: Text("To Do's",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 22))),
                    for (ToDo todoo in todoLists)
                      ToDoItem(todo: todoo)
                  ],
                ),
              )
            ])));
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 222, 242, 255),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, color: Colors.black, size: 30),
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

class _searchBox extends StatelessWidget {
  const _searchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: Colors.black),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, maxWidth: 25),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ));
  }
}
