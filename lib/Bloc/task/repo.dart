import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/model/task_model.dart';

class TaskRepository {
  final DatabaseProvider _databaseProvider;

  TaskRepository(this._databaseProvider);
  Future<List<Task>> fetchTasks() async {
    final db = await _databaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    List<Task> tasks = [];

    for (var map in maps) {
      Task task = Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        priority: map['priority'],
        label: map['label'],
        remember: map['remember'] == 1,
      );
      tasks.add(task);
    }

    return tasks;
  }

  Future<void> createTask(Task task) async {
    final db = await _databaseProvider.database;
    await db.insert('tasks', task.toMap());
    // final db = await _databaseProvider.database;
    // await db.insert(
    //   'tasks',
    //   task.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  Future<void> updateTask(Task task) async {
    final db = await _databaseProvider.database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int taskId) async {
    final db = await _databaseProvider.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }
}
