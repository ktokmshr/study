class TodoItem {
  int id;
  String title;
  String body;
  DateTime createdAt;
  DateTime updatedAt;

  TodoItem({this.id, this.title, this.body, this.createdAt, this.updatedAt});
  
  factory TodoItem.fromMap(Map<String, dynamic> data) => TodoItem(
        id: data['id'],
        title: data['title'],
        body: data['body'],
        createdAt: DateTime.parse(data['createdAt']).toLocal(),
        updatedAt: DateTime.parse(data['updatedAt']).toLocal(),
      );

  Map<String, dynamic> toMap() {
    return {
        'id': this.id,
        'title': this.title,
        'body': this.body,
        'createdAt': this.createdAt.toUtc().toIso8601String(),
        'updatedAt': this.updatedAt.toUtc().toIso8601String(),
    };
  }
}
