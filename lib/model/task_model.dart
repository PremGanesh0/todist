class Task {
  int? id;
  String? serverid;
  late String title;
  late String description;
  late DateTime date;
  late String priority;
  late String label;
  late bool remember;
  late bool completed;

  Task({
    this.id,
    this.serverid,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.label,
    required this.remember,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serverid': serverid,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'priority': priority,
      'label': label,
      'remember': remember ? 1 : 0,
      'completed': completed ? 1 : 0,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    print("---------------from json---------------");
    String dateString = json['date'];
    DateTime dateTime = DateTime.parse(dateString);
    print(dateTime);
    print(dateTime.runtimeType);
    print('date ${dateTime} runtime typw ${dateTime.runtimeType}');
    return Task(
      id: json['id'],
      serverid: json['serverid'],
      title: json['title'],
      description: json['description'],
      date: dateTime,
      priority: json['priority'],
      label: json['labels'][0],
      remember: json['remember'] == 1,
      completed: json['completed'] == 1,
    );
  }
}
