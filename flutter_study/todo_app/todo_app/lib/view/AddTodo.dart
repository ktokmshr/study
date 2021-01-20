import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AddTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TODO追加ページ'),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(child: Text(''))));
  }
}
