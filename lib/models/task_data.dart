import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

import 'package:todo_things/models/task.dart';

class TaskData extends ChangeNotifier {
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection("tasks");

  final List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  Future<void> fetchTasks() async {
    final QuerySnapshot snapshot = await taskCollection.get();
    List<Task> updatedTasks = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Task(id: doc.id, name: data["name"], isDone: data["isDone"]);
    }).toList();

    _tasks.clear(); // Clear the existing tasks
    _tasks.addAll(updatedTasks); // Add the updated tasks
    notifyListeners();
  }

  void addTask(String newTaskTitle) async {
    final task = Task(name: newTaskTitle, id: '');
    await taskCollection.add({
      "name": task.name,
      "isDone": task.isDone,
    });
    await fetchTasks();
    // _tasks.add(task);
    notifyListeners();
  }

  // void updateTask(Task task) async {
  //   await taskCollection.doc(task.id).update({"isDone": task.isDone});
  //   await fetchTasks();
  //   task.toggleDone();
  //   notifyListeners();
  // }

  void updateTaskToggleDone(String taskTitle) async {
    // await taskCollection.doc(task.id).update({"isDone": task.isDone});
    // await fetchTasks();
    Task task = _tasks.firstWhere((task) => task.name == taskTitle);
    task.toggleDone();
    await taskCollection.doc(task.id).update({"isDone": task.isDone});

    notifyListeners();
  }

  void deleteTask(Task task) async {
    await taskCollection.doc(task.id).delete();
    await fetchTasks(); // Refresh the local task list

    // _tasks.remove(task);
    notifyListeners();
  }
}
