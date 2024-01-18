import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:todist/Bloc/task/database_provider.dart';
import 'package:todist/api/create_task_api.dart';
import 'package:todist/api/delete_task_api.dart';
import 'package:todist/api/get_all_task_for_user_api.dart';
import 'package:todist/api/update_task_api.dart';
import 'package:todist/model/task_model.dart';

class TaskRepository {
  final DatabaseProvider _databaseProvider;

  TaskRepository(this._databaseProvider);

  Future<List<Task>> fetchTasks() async {
    final db = await _databaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    List<Task> tasks = [];

    // Fetch tasks from the API
    // List<Task> apiTasks = await getalltaskapi();
    getalltaskapi();

    for (var map in maps) {
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

      // Check if the task exists in the API response
      // // Check if the task exists in the API response
      // Task matchingApiTask = apiTasks.firstWhere(
      //   (apiTask) => apiTask.serverid == task.serverid,
      // );

      // Update the local task if it exists in the API response
      // if (matchingApiTask.title.isNotEmpty) {
      //   task.title = matchingApiTask.title;
      //   task.description = matchingApiTask.description;
      //   task.date = matchingApiTask.date;
      //   task.priority = matchingApiTask.priority;
      //   task.label = matchingApiTask.label;
      //   task.remember = matchingApiTask.remember;
      //   task.completed = matchingApiTask.completed;
      // }

      tasks.add(task);
    }

    return tasks;
  }

  // Future<List<Task>> fetchTasks() async {
  //   final db = await _databaseProvider.database;
  //   final List<Map<String, dynamic>> maps = await db.query('tasks');
  //   getalltaskapi();
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
      // print('----------------create task repo------------------');
      // print("inside bloc create task");
      // print("Task created with ID: ${task.serverid}");
      // print('title :- ${task.title}');
      // print('description :- ${task.description}');
      // print('priority :- ${task.priority}');
      // print('remember :- ${task.remember}');
      // print('Date :- ${task.date}');
      // print('----------------------------------');
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
    // print('----------------create task repo- updatetask-----------------');
    // print("inside bloc update task");
    // print("Task created with server ID: ${task.serverid}");
    // print('tital :- ${task.title}');
    // print('description :- ${task.description}');
    // print('priority :- ${task.priority}');
    // print('remember :- ${task.remember}');
    // print('Date :- ${task.date}');
    // print('----------------------------------');
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

  Future<void> completeTask(int taskId) async {
    final db = await _databaseProvider.database;
    await db.update(
      'tasks',
      {'completed': 1},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
