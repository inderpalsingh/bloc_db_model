import 'package:bloc_db_model/models/todo_model.dart';

sealed class TodoEvent {}

/// events
class InitialTodoDB extends TodoEvent{}

class AddTodoDB extends TodoEvent {
  TodoModel todoModel;

  AddTodoDB({required this.todoModel});
}

class UpdateTodoDB extends TodoEvent {
  TodoModel updateTodoModel;
  UpdateTodoDB({required this.updateTodoModel});
}

class DeleteTodoDB extends TodoEvent {
  int id;

  DeleteTodoDB({required this.id});
}
