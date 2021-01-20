import 'package:todo_app/entity/todo_item.dart';
import 'package:todo_app/dao/todo_item_dao.dart';

class TodoItemRepository {
  final todoItemDao = TodoItemDao();

  Future getAllItems() => todoItemDao.getAll();
  Future insertItem(TodoItem todoItem) => todoItemDao.create(todoItem);
  Future updateItem(TodoItem todoItem) => todoItemDao.update(todoItem);
  Future deleteItemById(int id) => todoItemDao.delete(id);
  Future deleteAllItems() => todoItemDao.deleteAll();
}
