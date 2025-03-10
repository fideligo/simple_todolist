import 'package:hive/hive.dart';

part 'todo_class.g.dart';

@HiveType(typeId: 0)
class ToDoClass {
  @HiveField(0)
  String id;

  @HiveField(1)
  String todoText;

  @HiveField(2)
  String todoType;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  String? startDate;

  @HiveField(5)
  String? endDate;

  @HiveField(6)
  String? description;

  ToDoClass({
    required this.id,
    required this.todoText,
    required this.todoType,
    this.isDone = false,
    this.startDate,
    this.endDate,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoText': todoText,
      'todoType': todoType,
      'isDone': isDone,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
    };
  }

  // Convert from Map
  factory ToDoClass.fromMap(Map<String, dynamic> map) {
    return ToDoClass(
      id: map['id'],
      todoText: map['todoText'],
      todoType: map['todoType'],
      isDone: map['isDone'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      description: map['description'],
    );
  }
}
