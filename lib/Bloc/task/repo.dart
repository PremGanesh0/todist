import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/api/complete_task_api.dart';
import 'package:todist/api/create_task_api.dart';
import 'package:todist/api/delete_task_api.dart';
import 'package:todist/api/get_all_task_for_user_api.dart';
import 'package:todist/api/undo_complete_task_api.dart';
import 'package:todist/api/update_task_api.dart';
import 'package:todist/model/task_model.dart';

class TaskRepository {
  final DatabaseProvider _databaseProvider;

  TaskRepository(this._databaseProvider);

  Future<List<Task>> fetchTasksfromserver() async {
    final db = await _databaseProvider.database;
    final List<Map<String, dynamic>> localTasks = await db.query('tasks');
    final List<Task> serverTasks = await getalltaskapi();

    for (var serverTask in serverTasks) {
      Map<String, dynamic> existingLocalTask = localTasks.firstWhere(
        (element) => element['serverid'] == serverTask.serverid,
        orElse: () => {
          'id': null,
        },
      );
      if (existingLocalTask['id'] != null) {
        final Task update = Task(
          id: existingLocalTask['id'],
          serverid: serverTask.serverid,
          title: serverTask.title,
          description: serverTask.description,
          date: serverTask.date,
          priority: serverTask.priority,
          label: serverTask.label,
          remember: serverTask.remember,
          completed: serverTask.completed,
        );
        await _databaseProvider.updateTask(update);
      } else {
        final Task insert = Task(
          id: null,
          serverid: serverTask.serverid,
          title: serverTask.title,
          description: serverTask.description,
          date: serverTask.date,
          priority: serverTask.priority,
          label: serverTask.label,
          remember: serverTask.remember,
          completed: serverTask.completed,
        );
        await _databaseProvider.insertTask(insert);
      }
    }

    final List<Map<String, dynamic>> updatedLocalTasks = await db.query('tasks');

    List<Task> tasks = [];
    for (var map in updatedLocalTasks) {
      print('map: $map');
      Task task = Task(
        id: map['id'],
        serverid: map['serverid'],
        title: map['title'],
        description: map['description'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        priority: map['priority'],
        label: map['label'],
        remember: map['remember'] == 1,
        completed: map['completed'] == 1,
      );
      tasks.add(task);
    }
    return tasks;
  }

  Future<List<Task>> fetchTaskslocal() async {
    final db = await _databaseProvider.database;

    final List<Map<String, dynamic>> localTasks = await db.query('tasks');

    List<Task> tasks = [];
    for (var map in localTasks) {
      Task task = Task(
        id: map['id'],
        serverid: map['serverid'],
        title: map['title'],
        description: map['description'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        priority: map['priority'],
        label: map['label'],
        remember: map['remember'] == 1,
        completed: map['completed'] == 1,
      );
      tasks.add(task);
    }
    return tasks;
  }

  Future<void> createTask(Task task) async {
    final db = await _databaseProvider.database;

    final ApiResponse apiResponse = await createTaskApi(task: task);
    String serverid = apiResponse.data['id'];
    if (apiResponse.status == 1) {
      task = Task(
        id: task.id,
        serverid: serverid,
        title: task.title,
        description: task.description,
        date: task.date,
        priority: task.priority,
        label: task.label,
        remember: task.remember,
        completed: task.completed,
      );

      await db.insert('tasks', task.toMap());
      Fluttertoast.showToast(
        msg: apiResponse.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
      );
    } else {
      Fluttertoast.showToast(
        msg: apiResponse.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future<void> updateTask(Task task) async {
    final db = await _databaseProvider.database;
    await updateTaskApi(task: task);
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(Task task) async {
    final db = await _databaseProvider.database;
    deleteTaskApi(task: task);
    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> completeTask(Task task) async {
    final db = await _databaseProvider.database;
    await db.update(
      'tasks',
      {'completed': 1},
      where: 'id = ?',
      whereArgs: [task.id],
    );
    completeTaskApi(task: task);
  }

  Future<void> undoTask(Task task) async {
    final db = await _databaseProvider.database;

    await db.update(
      'tasks',
      {'completed': 0},
      where: 'id = ?',
      whereArgs: [task.id],
    );

    await undoCompleteTaskApi(task: task);

    Fluttertoast.showToast(
      msg: "Task undone successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
    );
  }
}
