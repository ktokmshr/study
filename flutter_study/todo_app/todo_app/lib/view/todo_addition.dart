import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_item_model.dart';
import 'package:todo_app/entity/todo_item.dart';
import 'package:provider/provider.dart';

class TodoAddition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TODO追加ページ'),
        ),
        body: Container(
                padding: EdgeInsets.all(16.0),
                child: TodoForm()));
  }
}

class TodoForm extends StatefulWidget {
  @override
  TodoFormState createState() {
    return TodoFormState();
  }
}

class _TodoData {
  String title = '';
  String body = '';
  bool isDone = false;
}

class TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  _TodoData _data = new _TodoData();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoItemModel>(builder: (context, todoItemModel, child) {
      return Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TODO名',
                hintText: '◯◯する！',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'TODO名を入力してください。';
                }
                return null;
              },
              onSaved: (value) {
                this._data.title = value;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TODOの詳細',
                hintText: '詳細内容',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
                  todoItemModel.add(TodoItem(
                      title: this._data.title,
                      body: this._data.body,
                      isDone: this._data.isDone));
                  Navigator.pop(context);
                }
              },
              child: Text('登録'),
            )
          ]));
    });
  }
}
