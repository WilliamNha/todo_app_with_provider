import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app_with_provider/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_with_provider/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel>? taskList = [];
  String? responseMessage = "";
  String? errorMessage = '';
  bool isLoading = false;
  final String baseUrl = AppUrl.baseUrl;

  Future getAllTask() async {
    isLoading = true;
    notifyListeners();
    final url = "$baseUrl/task";

    taskList!.clear();
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        for (var task in decodedBody) {
          taskList!.add(TaskModel.fromJson(task));
        }
      } else {
        debugPrint(response.body);
        taskList = null;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<TaskModel?> getTaskByID({required String id}) async {
    isLoading = true;
    notifyListeners();
    final url = "$baseUrl/task/$id";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final task = TaskModel.fromJson(decodedBody);
        return task;
      } else {
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<String?> createTask(
      {required String task, required String time}) async {
    isLoading = true;
    notifyListeners();
    final url = "$baseUrl/task";

    try {
      final body = {
        "task": task,
        "time": time,
      };
      final headers = {"Content-Type": "application/json"};
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Task created successfully";
      } else {
        debugPrint(response.body);
        return "Somthing went wrong";
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<String?> updateTask(
      {required String id, required String task, required String time}) async {
    isLoading = true;
    notifyListeners();
    final url = "$baseUrl/task/$id";

    try {
      final body = {
        "task": task,
        "time": time,
      };
      final headers = {"Content-Type": "application/json"};
      final response = await http.patch(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Task updated successfully";
      } else {
        debugPrint(response.body);
        return "Somthing went wrong";
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future toogleTaskDone({
    required String id,
  }) async {
    final url = "$baseUrl/task/$id/toggleTask";

    try {
      final response = await http.put(
        Uri.parse(url),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("response: ${response.body}");
      } else {
        debugPrint(response.body);
        return "Somthing went wrong";
      }
    } catch (e) {
      log(e.toString());
    } finally {}
  }

  Future<String?> deleteTask({required String taskID}) async {
    isLoading = true;
    notifyListeners();
    final url = "$baseUrl/task/$taskID";

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        return "Task deleted successfully";
      } else {
        debugPrint(response.body);
        return "Something went wrong.";
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
