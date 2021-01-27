import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/todo_detail.dart';
import 'model/todo_item_model.dart';
import 'view/todo_addition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TodoItemModel>(
            create: (context) => TodoItemModel(),
          ),
        ],
        child: MaterialApp(
          title: 'TODOアプリ',
          home: MainPage(),
        ));
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('TODO一覧')),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Consumer<TodoItemModel>(builder: (context, model, child) {
              return _todoCardList(context, model);
            })),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TodoAddition()));
          },
        ));
  }

  Widget _todoCardList(context, TodoItemModel model) {
    return ListView(
        children: model.allItemList
            .map((todo) => Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.report),
                        title: Text(todo.title),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('詳細'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TodoDetail(id: todo.id)));
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('削除'),
                            onPressed: () {
                              model.deleteById(todo.id);
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ))
            .toList());
  }
}
