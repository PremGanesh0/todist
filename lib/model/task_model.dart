class Task {
  final int? id; // Nullable for newly created tasks
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  final String label;
  final bool remember;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.label,
    required this.remember,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch, // Convert DateTime to milliseconds
      'priority': priority,
      'label': label,
      'remember': remember ? 1 : 0, // Convert bool to integer (1 for true, 0 for false)
    };
  }
}
