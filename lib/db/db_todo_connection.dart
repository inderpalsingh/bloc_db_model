import 'package:bloc_db_model/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbTodoConnection {
  DbTodoConnection._();

  // 2
  static final DbTodoConnection db = DbTodoConnection._();

  // 3
  Database? myDb;

  // 4 =>  /// creating global static values
  static const String TABLE_NAME = 'todo';
  static const String TABLE_COLUMN_TITLE = 'todo_title';
  static const String TABLE_COLUMN_DESC = 'todo_desc';
  static const String TABLE_COLUMN_ID = 'id';

  // 5
  Future<Database> getDB() async {
    if (myDb != null) {
      return myDb!;
    } else {
      myDb = await initDb();
      return myDb!;
    }
  }

  // 6
  Future<Database> initDb() async {
    var rootPath = await getApplicationDocumentsDirectory();
    var setFilePath = join(rootPath.path, 'todo_db.db');
    return await openDatabase(setFilePath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $TABLE_NAME ($TABLE_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_COLUMN_TITLE TEXT, $TABLE_COLUMN_DESC TEXT )');
    });
  }

  Future<List<TodoModel>> fetchAllTodoFromDb() async {
    var db = await getDB();
    var data = await db.query(TABLE_NAME);

    List<TodoModel> getAllTodos = [];

    for (Map<String, dynamic> mapData in data) {
      var dataModel = TodoModel.fromMap(mapData);
      getAllTodos.add(dataModel);
    }
    return getAllTodos;
  }
  
  addTodo({required TodoModel todoModel})async{
    var db = await getDB();
    db.insert(TABLE_NAME, todoModel.toMap());
  }
  
  updateTodo({required TodoModel updateTodoModel})async {
    var db = await getDB();
    db.update(TABLE_NAME, updateTodoModel.toMap(), where: '$TABLE_COLUMN_ID =?', whereArgs: ['${updateTodoModel.id}']);
  }
  
  
  deleteTodo(int id)async{
    var db = await getDB();
    db.delete(TABLE_NAME, where: "$TABLE_COLUMN_ID = ?", whereArgs: ['$id']);
  }
  
}
