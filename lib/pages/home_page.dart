import 'package:bloc_db_model/bloc/todo_bloc.dart';
import 'package:bloc_db_model/bloc/todo_event.dart';
import 'package:bloc_db_model/bloc/todo_state.dart';
import 'package:bloc_db_model/pages/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoBloc>().add(InitialTodoDB());
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc db model'),),
      body: BlocBuilder<TodoBloc,TodoState>(
          builder: (_, state) {
        if(state is LoadingTodoState){
          return const Center(child: CircularProgressIndicator());
        }
        if(state is FailureTodoState){
          return Center(child: Text(state.errorMsg));
        }
        
        if(state is SuccessfulTodoState ){
          return ListView.builder(
            itemCount: state.allTodos.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(isUpdate: true, todoModel: state.allTodos[index])));
                  },
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(state.allTodos[index].title),
                  subtitle: Text(state.allTodos[index].desc),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TodoBloc>().add(DeleteTodoDB(id: state.allTodos[index].id));
                    },
                    
                  ),
                );
              },
          );
        }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
