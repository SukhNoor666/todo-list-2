//important packages
import 'package:myapp/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService taskService = TaskService();
  List<Task> tasks = []; // Creating list which stores tasks.

// Creating a function which loads tasks
  Future<void> loadTasks() async {
    tasks = await taskService.fetchTasks();
    notifyListeners();
  }
// function to add task
  Future<void> addTask(String name) async {
    if (name.isNotEmpty) {
      final id = await taskService.addTask(name.trim());
      tasks.add(Task(id: id, name: name.trim(), completed: false));
      notifyListeners();
    }
  }
// function to update task
  Future<void> updateTask(int index, bool completed) async {
    final task = tasks[index];
    await taskService.updateTask(task.id, completed);
    notifyListeners();
  }
// function to remove task
  Future<void> removeTask(int index) async {
    final task = tasks[index];
    await taskService.deleteTask(task.id);
    notifyListeners();
  }
}
