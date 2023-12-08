import 'package:todist/Bloc/task/database_provider.dart';

import '../../model/task_model.dart';

class TaskRepository {
  final DatabaseProvider _databaseProvider;

  TaskRepository(this._databaseProvider);

  Future<void> createTask(Task task) async {
    final db = await _databaseProvider.database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final db = await _databaseProvider.database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}
