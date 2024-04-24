import 'package:bloc_db_model/bloc/todo_bloc.dart';
import 'package:bloc_db_model/bloc/todo_event.dart';
import 'package:bloc_db_model/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  
  bool isUpdate;
  TodoModel? todoModel;
  SecondPage({super.key, this.isUpdate = false, this.todoModel});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if(isUpdate){
      titleController.text = todoModel!.title;
      descController.text = todoModel!.desc;
      
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Todos' : 'Add Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: 'Todo ', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  hintText: 'Desc ', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if(!isUpdate){
                        context.read<TodoBloc>().add(AddTodoDB(
                            todoModel: TodoModel(
                              title: titleController.text,
                              desc: descController.text,
                            )));
                      }else{
                        context.read<TodoBloc>().add(
                            UpdateTodoDB(
                                updateTodoModel: TodoModel(title: titleController.text, desc: descController.text, id:  todoModel!.id)));
                      }
                      Navigator.pop(context);
                    },
                    child: Text(isUpdate ? 'Update Todos' : 'Add Todos')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
