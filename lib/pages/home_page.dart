import 'package:bloc_db_model/bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc db model'),),
      body: BlocBuilder(
          builder: (_, state) {
        if(state is LoadingTodoState){
          return const Center(child: CircularProgressIndicator());
        }
        if(state is FailureTodoState){
          return const Center(child: Text('No Todos'));
        }
        
        if(state is SuccessfulTodoState ){
          return ListView.builder(
            itemCount: state.allTodos.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(state.allTodos[index].title),
                  subtitle: Text(state.allTodos[index].desc),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      
                    },
                  ),
                );
              },
          );
        }
        return Container();
      }),
    );
  }
}
