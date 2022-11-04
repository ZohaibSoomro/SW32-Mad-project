class Task {
  int? id;
  String title;

  Task({required this.title, this.id});

  Map<String, Object?> toJSON() => {'id': id, 'title': title};

  static Task fromJSON(Map<String, Object?> json) => Task(
        id: json['id'] as int,
        title: json['title'] as String,
      );
}
