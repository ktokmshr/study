import 'package:todo_app/service/database.dart';
import 'package:todo_app/entity/todo_item.dart';

class TodoItemDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.todoItemTableName;

  Future<int> create(TodoItem todoItem) async {
    final db = await dbProvider.database;
    DateTime _date = new DateTime.now();
    todoItem.createdAt = _date;
    todoItem.updatedAt = _date;
    var result = db.insert(tableName, todoItem.toMap());
    return result;
  }

  Future<List<TodoItem>> getAll() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    List<TodoItem> todoItem = result.isNotEmpty
        ? result.map((data) => TodoItem.fromMap(data)).toList()
        : [];
    return todoItem;
  }

  Future<int> update(TodoItem todoItem) async {
    final db = await dbProvider.database;
    DateTime _date = new DateTime.now();
    todoItem.updatedAt = _date;
    var result = await db.update(tableName, todoItem.toMap(),
        where: "id = ?", whereArgs: [todoItem.id]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future deleteAll() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tableName,
    );
    return result;
  }
}
