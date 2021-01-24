import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/todo_item_model.dart';
import 'entity/todo_item.dart';
import 'view/AddTodo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ（Provider+sqflite学習用）',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/addTodo': (context) => AddTodo(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  final data = TodoItemModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoItemModel>.value(
        value: data,
        child: Scaffold(
            appBar: AppBar(title: Text('TODOアプリ（Provider+sqflite学習用）')),
            body: Container(
                padding: EdgeInsets.all(16.0),
                child:
                    Consumer<TodoItemModel>(builder: (context, value, child) {
                  final TodoItemModel todoItemModel = Provider.of<TodoItemModel>(context);
                  return ListView(
                    children: todoItemModel.allItemList.map((todo) => _todoCard(todo)).toList(),
                  );
                })),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/addTodo',
                );
              },
            )));
  }

  Widget _todoCard(TodoItem todo) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(todo.title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('詳細'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('削除'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
