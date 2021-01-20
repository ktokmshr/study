import 'package:todo_app/entity/todo_item.dart';
import 'package:todo_app/repository/todo_item_repository.dart';

class TodoItemModel {
  List<TodoItem> _allItemList = [];
  List<TodoItem> get allItemList => _allItemList;

  final TodoItemRepository repo = TodoItemRepository();

  TodoItemModel() {
    _fetchAll();
  }

  void _fetchAll() async {
    _allItemList = await repo.getAllItems();
  }

  void add(TodoItem todoItem) async {
    await repo.insertItem(todoItem);
  }

  void update(TodoItem todoItem) async {
    await repo.updateItem(todoItem);
  }

  void deleteById(TodoItem todoItem) async {
    await repo.deleteItemById(todoItem.id);
  }

  void deleteAll() async {
    await repo.deleteAllItems();
  }
}
