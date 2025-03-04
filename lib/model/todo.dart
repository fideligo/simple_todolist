class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: "Ngopi", isDone: true),
      ToDo(id: '02', todoText: "Belajar kalkulus", isDone: true),
      ToDo(id: '03', todoText: "Check Email "),
      ToDo(id: '04', todoText: 'Baca "Atomic Habits"')
    ];
  }
}
