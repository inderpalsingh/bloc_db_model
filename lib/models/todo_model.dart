import '../db/db_todo_connection.dart';

class TodoModel {
  int id;
  String title;
  String desc;

  TodoModel({this.id = 0, required this.title, required this.desc});

  /// model to map
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        id: map[DbTodoConnection.TABLE_COLUMN_ID],
        title: map[DbTodoConnection.TABLE_COLUMN_TITLE],
        desc: map[DbTodoConnection.TABLE_COLUMN_DESC]);
  }

  /// map to model
  Map<String, dynamic> toMap() {
    return {
      DbTodoConnection.TABLE_COLUMN_TITLE: title,
      DbTodoConnection.TABLE_COLUMN_DESC: desc
    };
  }
}
