import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';
import 'package:todist/utils.dart';

Future<void> createTaskApi({required Task task}) async {
  String apiUrl = '$baseUrl/task/createTask';
  var accessToken = await LocalStorage.getAccessToken();
  try {
    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({
      "title": task.title,
      "description": task.description,
      "date": task.date,
      "priority": "priority1",
      "reminders": ["2023-09-25"],
      "labels": ["Label 1", "Label 2"],
      "category": "family",
      "isFavorite": false
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('status code ${response.statusCode}');
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }
}
