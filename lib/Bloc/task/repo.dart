import 'dart:async';
import 'dart:math';

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

  Future<List<Task>> fetchTasks() async {
    final db = await _databaseProvider.database;
    final List<Map<String, dynamic>> localTasks = await db.query('tasks');
    final List<Task> serverTasks = await getalltaskapi();
    print('localtask length ${localTasks.length}');
    print('server tasks length ${serverTasks.length}');
    for (var serverTask in serverTasks) {
      final existingLocalTask = localTasks.firstWhere(
        (localTask) => localTask['serverid'] == serverTask.serverid,
      );
      if (existingLocalTask != null && existingLocalTask.isNotEmpty) {
        print('updating the task $existingLocalTask');
        print('local task Date :- ${existingLocalTask['date']}');
        print('local task serverid :-${existingLocalTask['serverid']}');
        print('local task title:- ${existingLocalTask['title']}');
        print('local task description:- ${existingLocalTask['description']}');
        print('locak task date :-${existingLocalTask['date']}');
        print('local task priority :- ${existingLocalTask['priority']}');
        print('local task lable:-${existingLocalTask['label']}');
        print('local task remember:-${existingLocalTask['remember']}');
        print('local task complete:-${existingLocalTask['completed']}');
        print('----------------------------- sever id------------');
        print('server task sever id:-${serverTask.serverid}');
        print(' server task title :- ${serverTask.title}');
        print(' server task description :- ${serverTask.description}');
        print(' server task date :- ${serverTask.date}');
        print(' server task priority :- ${serverTask.priority}');
        print(' server task lable :- ${serverTask.label}');
        print(' server task remember :- ${serverTask.remember}');
        print(' server task complete :- ${serverTask.completed}');

        await _databaseProvider.updateTask(serverTask);
      } else {
        print("inserting the task $serverTask");
        await _databaseProvider.insertTask(serverTask);
      }
    }
    final List<Map<String, dynamic>> updatedLocalTasks =
        await db.query('tasks');

    List<Task> tasks = [];
    for (var map in updatedLocalTasks) {
      print('-------localdb--------');
      print(map);
      Task task = Task(
        id: map['id'],
        serverid: map['serverid'],
        title: map['title'],
        description: map['description'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        priority: map['priority'],
        label: map['label'],
        remember: map['remember'] == 1,
        completed: map['completed'] == 0,
      );
      tasks.add(task);
    }
    return tasks;
  }

  // Future<List<Task>> fetchTasks() async {
  //   final db = await _databaseProvider.database;
  //   final List<Map<String, dynamic>> maps = await db.query('tasks');
  //   final localTasks = maps;
  //   final serverTasks = await getalltaskapi();
  //   print('localtask lenght ${localTasks.length}');
  //   print(("server tasks lenght ${serverTasks.length}"));

  //   // Find new tasks from the server and add them to the local database
  //   for (var serverTask in serverTasks) {
  //     // print('-------server db--------');
  //     // print('Task Id :-${serverTask.serverid}');
  //     // print('Title :- ${serverTask.title}');
  //     // print('Description :- ${serverTask.description}');
  //     // print('Priority :- ${serverTask.priority}');
  //     // print('Task Complete :- ${serverTask.completed}');
  //     // print('Reminder :- ${serverTask.remember}');
  //     // print('date ${serverTask.date}');
  //     // if (!localTasks.any((task) => task.serverid == serverTask.serverid)) {
  //     //   // Task is new, add it to local database
  //     //   await _databaseProvider.insertTask(serverTask);
  //     // }
  //   }

  //   // Update local tasks with server data
  //   for (var localTask in localTasks) {
  //     // print('-------localdb--------');
  //     // print(localTask);
  //     // print('Task Id :-${localTask['id']}');
  //     // print('Title :- ${localTask['ti']}');
  //     // print('Description :- ${localTask.description}');
  //     // print('Priority :- ${localTask.priority}');
  //     // print('Task Complete :- ${localTask.completed}');
  //     // print('Reminder :- ${localTask.remember}');
  //     // print('date ${localTask.date}');
  //     // final serverTask = serverTasks
  //     //     .firstWhereOrNull((task) => task.serverid == localTask.serverid);
  //     // if (serverTask != null) {
  //     //   // Update local task with server data
  //     //   await _databaseProvider.updateTask(serverTask);
  //     // }
  //   }

  //   List<Task> tasks = [];
  //   for (var map in maps) {
  //     Task task = Task(
  //       id: map['id'],
  //       serverid: map['serverid'],
  //       title: map['title'],
  //       description: map['description'],
  //       date: DateTime.fromMillisecondsSinceEpoch(map['date']),
  //       priority: map['priority'],
  //       label: map['label'],
  //       remember: map['remember'] == 1,
  //       completed: map['completed'] == 0,
  //     );
  //     tasks.add(task);
  //   }
  //   return tasks;
  // }

  Future<void> createTask(Task task) async {
    final db = await _databaseProvider.database;

    final ApiResponse apiResponse = await createTaskApi(task: task);
    String id = apiResponse.data['id'];

    if (apiResponse.status == 1) {
      task = Task(
        id: task.id,
        serverid: id,
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
      print("API error: ${apiResponse.message}");
    }
  }

  Future<void> updateTask(Task task) async {
    final db = await _databaseProvider.database;
    await updateTaskApi(task: task);
    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
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
