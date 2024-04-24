import 'package:bloc_db_model/bloc/todo_event.dart';
import 'package:bloc_db_model/bloc/todo_state.dart';
import 'package:bloc_db_model/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../db/db_todo_connection.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  DbTodoConnection db;
  
  TodoBloc({required this.db}) : super(InitialTodoState()) {
    
    
    on<InitialTodoDB>((event, emit)async {
      emit(LoadingTodoState());
      List<TodoModel> mData = await db.fetchAllTodoFromDb();
      emit(SuccessfulTodoState(allTodos: mData));
      
    });
    
    
    
    on<AddTodoDB>((event, emit)async {
      emit(LoadingTodoState());
      bool check = await db.addTodo(todoModel: event.todoModel);
      if(check){
        List<TodoModel> mData = await db.fetchAllTodoFromDb();
        emit(SuccessfulTodoState(allTodos: mData));
      }else{
        emit(FailureTodoState(errorMsg: 'Not added'));
      }
    });

    on<UpdateTodoDB>((event, emit) async {
      emit(LoadingTodoState());
      bool check = await db.updateTodo(updateTodoModel: event.updateTodoModel);
      if(check){
        List<TodoModel> mData = await db.fetchAllTodoFromDb();
        emit(SuccessfulTodoState(allTodos: mData));
      } else{
        emit(FailureTodoState(errorMsg: 'Not Updated'));
      }
    });

    on<DeleteTodoDB>((event, emit) async {
      emit(LoadingTodoState());
      await db.deleteTodo(event.id);
      List<TodoModel> mData = await db.fetchAllTodoFromDb();
      emit(SuccessfulTodoState(allTodos: mData));
      
    });

    
  }
}
