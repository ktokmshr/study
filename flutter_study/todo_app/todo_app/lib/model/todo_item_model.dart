import 'package:flutter/material.dart';
import 'package:todo_app/entity/todo_item.dart';
import 'package:todo_app/repository/todo_item_repository.dart';

class TodoItemModel extends ChangeNotifier {
  List<TodoItem> _allItemList = [];
  List<TodoItem> get allItemList => _allItemList;

  final TodoItemRepository repo = TodoItemRepository();

  TodoItemModel() {
    fetchAll();
  }

  void fetchAll() async {
    this._allItemList = await repo.getAllItems();
    notifyListeners();
  }

  TodoItem getTodoById(String id) {
    return this._allItemList.firstWhere((todo) => todo.id.toString() == id);
  }

  void add(TodoItem todoItem) async {
    await repo.insertItem(todoItem);
    this.fetchAll();
  }

  void update(TodoItem todoItem) async {
    await repo.updateItem(todoItem);
    this.fetchAll();
  }

  void deleteById(TodoItem todoItem) async {
    await repo.deleteItemById(todoItem.id);
    this.fetchAll();
  }

  void deleteAll() async {
    await repo.deleteAllItems();
    this.fetchAll();
  }
}
