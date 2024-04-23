import 'package:bloc_db_model/bloc/todo_bloc.dart';
import 'package:bloc_db_model/db/db_todo_connection.dart';
import 'package:bloc_db_model/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => TodoBloc(db: DbTodoConnection.db),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bloc db Model',
      home: HomePage(),
    );
  }
}
