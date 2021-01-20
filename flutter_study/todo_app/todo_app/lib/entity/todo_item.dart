class TodoItem {
  int id;
  String title;
  String body;
  DateTime createdAt;
  DateTime updatedAt;
  bool isDone;

  TodoItem({this.id, this.title, this.body, this.createdAt, this.updatedAt, this.isDone});
  
  factory TodoItem.fromMap(Map<String, dynamic> data) => TodoItem(
        id: data['id'],
        title: data['title'],
        body: data['body'],
        createdAt: DateTime.parse(data['createdAt']).toLocal(),
        updatedAt: DateTime.parse(data['updatedAt']).toLocal(),
        isDone: (data['isDone'] == '1') ? true : false,
      );

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'title': this.title,
        'body': this.body,
        'createdAt': this.createdAt.toUtc().toIso8601String(),
        'updatedAt': this.updatedAt.toUtc().toIso8601String(),
        'isDone': (this.isDone) ? 1 : 0,
      };
}
