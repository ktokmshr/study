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
    _allItemList = await repo.getAllItems();
    notifyListeners();
  }

  void add(TodoItem todoItem) async {
    await repo.insertItem(todoItem);
    notifyListeners();
  }

  void update(TodoItem todoItem) async {
    await repo.updateItem(todoItem);
    notifyListeners();
  }

  void deleteById(TodoItem todoItem) async {
    await repo.deleteItemById(todoItem.id);
    notifyListeners();
  }

  void deleteAll() async {
    await repo.deleteAllItems();
    notifyListeners();
  }
}
