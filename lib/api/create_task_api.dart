import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todist/Bloc/repo/local_storage_shared_preferences.dart';
import 'package:todist/model/task_model.dart';
import 'package:todist/utils.dart';

class ApiResponse {
  final String message;
  final int status;
  final dynamic data;

  ApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });
}

Future<ApiResponse> createTaskApi({required Task task}) async {
  String apiUrl = '$baseUrl/task/createTask';
  var accessToken = await LocalStorage.getAccessToken();

  try {

    var headers = {
      'Authorization': accessToken['accessToken'].toString(),
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({
      "title": task.title,
      "description": task.description,
      "date": DateFormat('yyyy-MM-dd').format(task.date).toString(),
      "priority": "priority1",
      "reminders": ["2023-09-25"],
      "labels": ["Label 1", "Label 2"],
      "category": "family",
      "isFavorite": false,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // print('status code ${response.statusCode}');

    if (response.statusCode == 201) {
      var data = await response.stream.bytesToString();
      // print('-------------------create task api--------------');
      // print(data);
      var jsonData = json.decode(data);

      return ApiResponse(
        message: jsonData['message'],
        status: jsonData['status'],
        data: jsonData['data'],
      );
    } else {
      return ApiResponse(
        message: response.reasonPhrase ?? 'Failed to create task',
        status: response.statusCode,
        data: null,
      );
    }
  } catch (error) {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
    return ApiResponse(
      message: 'Failed to create task: ${error.toString()}',
      status: 500,
      data: null,
    );
  }
}
