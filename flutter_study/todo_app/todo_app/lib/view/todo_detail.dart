import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_item_model.dart';
import 'package:todo_app/entity/todo_item.dart';
import 'package:provider/provider.dart';

class TodoDetail extends StatelessWidget {
  final int id;
  TodoDetail({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TODO詳細ページ'),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Container(
                padding: EdgeInsets.all(16.0), child: TodoForm(id: this.id))));
  }
}

class TodoForm extends StatefulWidget {
  final int id;
  TodoForm({this.id});

  @override
  TodoFormState createState() {
    return TodoFormState(id: this.id);
  }
}

class _TodoData {
  int id;
  String title = '';
  String body = '';
  DateTime createdAt;
  bool isDone = false;
}

class TodoFormState extends State<TodoForm> {
  final int id;
  TodoFormState({this.id});
  final _formKey = GlobalKey<FormState>();
  final todoItemModel = TodoItemModel();
  _TodoData _data = new _TodoData();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoItemModel>(builder: (context, todoItemModel, child) {
      final todo = todoItemModel.getTodoById(this.id);
      return Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            Text(
              todoItemModel.getTodoById(this.id).title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              '作成日： ' + todo.createdAt.toString(),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '更新日： ' + todo.updatedAt.toString(),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              initialValue: todo.body,
              validator: (value) {
                if (value.isEmpty) {
                  return '詳細内容を入力してください。';
                }
                return null;
              },
              onSaved: (value) {
                this._data.body = value;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  this._formKey.currentState.save();
                  todoItemModel.update(TodoItem(
                      id: todo.id,
                      title: todo.title,
                      body: this._data.body,
                      createdAt: todo.createdAt,
                      isDone: todo.isDone));
                  Navigator.pop(context);
                }
              },
              child: Text('更新'),
            )
          ]));
    });
  }
}
