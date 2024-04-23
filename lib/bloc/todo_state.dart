import '../models/todo_model.dart';

sealed class TodoState {}


class InitialTodoState extends TodoState{}

class LoadingTodoState extends TodoState{}

class SuccessfulTodoState extends TodoState{
  List<TodoModel> allTodos ;
  SuccessfulTodoState({required this.allTodos});
}

class FailureTodoState extends TodoState{
  String errorMsg;
  FailureTodoState({required this.errorMsg});
}