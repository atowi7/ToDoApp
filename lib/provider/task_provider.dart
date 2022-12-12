import 'package:flutter/cupertino.dart';
import 'package:todo_app/helper/sql_db.dart';
import 'package:todo_app/model/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks {
    return _tasks;
  }

  String _key = '';

  set setKey(String key) {
    _key = key;
  }

  String get getKey {
    return _key;
  }

  Future<String> addTasks(String title, String description) async {
    final timestamp = DateTime.now().toIso8601String();
    int response = await SqlDB.insertData(
        'INSERT INTO task (title,description,createdat) VALUES ("$title","$description","$timestamp")');

    if (response == 0) {
      return 'failure';
    }
    notifyListeners();

    return 'success';
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks =
        await SqlDB.selectData('SELECT * FROM task');

    if (getKey.isEmpty || getKey == '') {
      _tasks = tasks
          .map((t) => Task(
                id: t['id'] as int,
                title: t['title'] as String,
                description: t['description'] as String,
                createdAt: t['createdat'],
                done: t['done'] as int == 0 ? false : true,
              ))
          .toList();
    } else {
      // _tasks.clear();
      _tasks = tasks
          .map((t) => Task(
                id: t['id'] as int,
                title: t['title'] as String,
                description: t['description'] as String,
                createdAt: t['createdat'],
                done: t['done'] as int == 0 ? false : true,
              ))
          .where(
              (task) => task.title.toLowerCase().contains(getKey.toLowerCase()))
          .toList();
    }
  }

  void filterTasks(String key) {
    setKey = key;

    notifyListeners();
  }

  // Future<String> getTitle(int id) async {
  //   List<Map<String, dynamic>> tasks =
  //       await SqlDB.selectData('SELECT title FROM task where id = $id');
  //   return tasks[0]['title'];
  // }

  // Future<String> getDesc(int id) async {
  //   List<Map<String, dynamic>> tasks =
  //       await SqlDB.selectData('SELECT title FROM task where id = $id');
  //   return tasks[0]['description'];
  // }

  Future<String> updateTasks(int id, String title, String description) async {
    int response = await SqlDB.updateData(
        'UPDATE task set title="$title",description="$description" WHERE id =$id');

    if (response == 0) {
      return 'failure';
    }
    notifyListeners();

    return 'success';
  }

  Future<String> toggle(int id, bool done) async {
    int d = done == true ? 0 : 1;
    int response =
        await SqlDB.updateData('UPDATE task set done =$d WHERE id =$id');

    if (response == 0) {
      return 'failure';
    }
    notifyListeners();

    return 'success';
  }

  Future<String> deleteTasks(int id) async {
    int response = await SqlDB.deleteData('DELETE FROM task WHERE id=$id');
    if (response == 0) {
      return 'failure';
    }
    notifyListeners();

    return 'success';
  }
}
