class Task {
  late final int? id;
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  final String label;
  final bool remember;
  final bool completed;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.priority,
      required this.label,
      required this.remember,
      required this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch, 
      'priority': priority,
      'label': label,
      'remember': remember ? 1 : 0,
       'completed': completed ? 1 : 0,
    };
  }
}
