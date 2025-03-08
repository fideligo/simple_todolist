class ToDoClass {
  String id;
  String todoText;
  bool isDone;

  ToDoClass({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDoClass> todoList() {
    return [
      ToDoClass(id: '01', todoText: "Ngopi", isDone: true),
      ToDoClass(id: '02', todoText: "Belajar kalkulus", isDone: true),
      ToDoClass(id: '03', todoText: "Check Email "),
      ToDoClass(id: '04', todoText: 'Baca "Atomic Habits"')
    ];
  }
}
