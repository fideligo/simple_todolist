class ToDoClass {
  String id;
  String todoText;
  String todoType;
  bool isDone;

  ToDoClass({
    required this.id,
    required this.todoText,
    this.todoType = "Daily",
    this.isDone = false,
  });

  static List<ToDoClass> todoList() {
    return [
      ToDoClass(id: '01', todoText: "Ngopi", todoType: 'Daily', isDone: true),
      ToDoClass(
          id: '02',
          todoText: "Belajar kalkulus",
          todoType: 'Priority',
          isDone: true),
      ToDoClass(id: '03', todoText: "Check Email", todoType: 'Priority'),
      ToDoClass(id: '04', todoText: 'Baca "Atomic Habits"', todoType: "Daily"),
      ToDoClass(id: '1232', todoText: "Nyapu"),
      ToDoClass(id: '10', todoText: "Kasih makan kuda(nil)")
    ];
  }
}
