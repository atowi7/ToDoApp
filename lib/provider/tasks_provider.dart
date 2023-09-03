import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/datasource/sql_db.dart';
import 'package:todo_app/data/model/categorymodel.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/view/widget/icons.dart';
import 'package:todo_app/core/utils/extensions.dart';

class TasksProvider with ChangeNotifier {
  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get categoryList {
    return _categoryList;
  }

  // List<TaskModel> _taskList = [];
  // List<TaskModel> get taskList {
  //   return _taskList;
  // }

  // List<TaskModel> _doingTasks = [];
  // List<TaskModel> get doingTasks {
  //   return _doingTasks;
  // }

  // List<TaskModel> _doneTasks = [];
  // List<TaskModel> get doneTasks {
  //   return _doneTasks;
  // }

  final formKey = GlobalKey<FormState>();
  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();

  // FocusNode taskFocusNode = FocusNode();

  final icons = getIcons();

  int tabIndex = 0;

  int chipIndex = 0;

  bool categoryDeleted = false;

  int? categorySelected;

  void changeTabIndex(int i) {
    tabIndex = i;
    notifyListeners();
  }

  void changeChopIndex(int i) {
    chipIndex = i;
    notifyListeners();
  }

  void changeCategoryDeleted(bool value) {
    categoryDeleted = value;
    notifyListeners();
  }

  void changeCategoryStatus(int? index) {
    categorySelected = index;
    notifyListeners();
  }

  // bool isContainTask(List<TaskModel taskModel,String title){
  // }

  String _key = '';

  set setKey(String key) {
    _key = key;
  }

  String get getKey {
    return _key;
  }

  Future<void> getCategories() async {
    // await getTasks();
    List<Map<String, dynamic>> category =
        await SQLDB.selectData('SELECT * FROM category');
    print(category.length);
    _categoryList = category
        .map((category) => CategoryModel(
              id: category['id'],
              title: category['title'],
              icon: category['icon'],
              color: category['color'],
            ))
        .toList();

    // print(category);
    // if (getKey.isEmpty || getKey == '') {
    // } else {
    //   _taskList = tasks
    //       .map((task) => TaskModel(
    //           id: task['id'],
    //           title: task['title'],
    //           isDone: task['isdone'] == '0' ? false : true,
    //           createdAt: task['createdat']))
    //       .where(
    //           (task) => task.title.toLowerCase().contains(getKey.toLowerCase()))
    //       .toList();
    // }
  }

  Future<String> addCategory() async {
    if (formKey.currentState!.validate()) {
      String title = categoryTitleController.text;
      int icon = icons[chipIndex].icon!.codePoint;

      String color = icons[chipIndex].color!.toHex();
      final timestamp = DateTime.now().toIso8601String();

      bool isExist = categoryList.any((category) => category.title == title);
      // int? isExist = Sqflite.firstIntValue(await SQLDB
      //     .selectData('SELECT * FROM category WHERE title = "$title"'));
      // print(isExist);

      if (isExist) {
        return 'duplicated';
      }

      int res = await SQLDB.insertData(
          'INSERT INTO category (title,icon,color,createdat) VALUES ("$title",$icon,"$color","$timestamp")');
      if (res == 0) {
        return 'failure';
      }
      return 'success';
    }

    notifyListeners();
    return "Invalid Text";
  }

  Future<String> editnumOfTasks(int id, int n) async {
    // var tasks = categorySelected!.tasks ?? [];
    int res = await SQLDB
        .updateData('UPDATE category set numoftasks = $n WHERE id = $id');

    if (res == 0) {
      return 'failure';
    }
    notifyListeners();
    return "success";
  }

  Future<String> deleteCategory(int id) async {
    String response = await deleteTaskFromCategory(id);

    if (response == 'success') {
      int res = await SQLDB.deleteData('DELETE FROM category WHERE id = $id');

      if (res == 0) {
        return 'failure';
      }
    } else {
      return "failure";
    }

    notifyListeners();
    return "success";
  }

  Future<List<TaskModel>> getTasks() async {
    List<Map<String, dynamic>> tasks =
        await SQLDB.selectData('SELECT * FROM task');
    // if (getKey.isEmpty || getKey == '') {
    List<TaskModel> taskList = tasks
        .map((task) => TaskModel(
              id: task['id'],
              title: task['title'],
              isDone: task['isdone'] == 0 ? false : true,
              createdAt: task['createdat'],
              categoryId: task['categoryid'],
            ))
        .toList();
    return taskList;

    // } else {
    //   _taskList = tasks
    //       .map((task) => TaskModel(
    //           id: task['id'],
    //           title: task['title'],
    //           isDone: task['isdone'] == '0' ? false : true,
    //           createdAt: task['createdat']))
    //       .where(
    //           (task) => task.title.toLowerCase().contains(getKey.toLowerCase()))
    //       .toList();
    // }
  }

  Future<List<TaskModel>> getTaskByCategoty(int categoryId) async {
    List<Map<String, dynamic>> tasks = await SQLDB
        .selectData('SELECT * FROM task WHERE categoryid = $categoryId');
    List<TaskModel> taskList = tasks
        .map((task) => TaskModel(
            id: task['id'],
            title: task['title'],
            isDone: task['isdone'] == 0 ? false : true,
            createdAt: task['createdat'],
            categoryId: task['categoryid']))
        .toList();

    return taskList;
  }

  // Future<void> getCompletedTasks([int? categoryId]) async {
  //   List<Map<String, dynamic>> tasks = await SQLDB.selectData(
  //       'SELECT * FROM task WHERE isdone = 1 AND categoryid = $categoryId');
  //   _doneTasks = tasks
  //       .map((task) => TaskModel(
  //             id: task['id'],
  //             title: task['title'],
  //             isDone: task['isdone'] == 0 ? false : true,
  //             createdAt: task['createdat'],
  //             categoryId: task['categoryid'],
  //           ))
  //       .toList();
  // }

  // Future<void> getUnCompletedTasks([int? categoryId]) async {
  //   List<Map<String, dynamic>> tasks = await SQLDB.selectData(
  //       'SELECT * FROM task WHERE isdone = 0 AND categoryid = $categoryId');
  //   _doingTasks = tasks
  //       .map((task) => TaskModel(
  //             id: task['id'],
  //             title: task['title'],
  //             isDone: task['isdone'] == 0 ? false : true,
  //             createdAt: task['createdat'],
  //             categoryId: task['categoryid'],
  //           ))
  //       .toList();
  // }

  // Future<int> getTotalTasks(){

  // }

  Future<int> getNumOfTasks(int categoryId) async {
    List<Map<String, dynamic>> tasks = await SQLDB
        .selectData('SELECT COUNT(*) FROM task WHERE categoryid = $categoryId');
    int count = Sqflite.firstIntValue(tasks)!;

    return count;
  }

  Future<String> addTask() async {
    print(categorySelected);
    if (categorySelected == null) {
      return 'unselected';
    }

    if (formKey.currentState!.validate()) {
      final String title = taskTitleController.text;
      final timestamp = DateTime.now().toIso8601String();
      int res = await SQLDB.insertData(
          'INSERT INTO task (title,createdat,categoryid) VALUES ("$title","$timestamp",$categorySelected)');

      if (res == 0) {
        return 'failure';
      }
      notifyListeners();
      return "success";
    }

    return 'Invalid Text';
  }

  Future<String> addtaskDetails(int cid) async {
    if (formKey.currentState!.validate()) {
      final String title = taskTitleController.text;

      // var doingTasks = {'title':title,'isdone':false};

      // int? isExist = Sqflite.firstIntValue(
      //     await SQLDB.selectData('SELECT * FROM task WHERE title = "$title"'));

      // if (isExist != 0) {
      //   return 'duplicated';
      // }

      final timestamp = DateTime.now().toIso8601String();
      int res = await SQLDB.insertData(
          'INSERT INTO task (title,createdat,categoryid) VALUES ("$title","$timestamp",$cid)');

      if (res == 0) {
        return 'failure';
      }
      notifyListeners();
      return "success";
    }

    return 'Invalid Text';
  }

  Future<String> editTask(int id, String title) async {
    int res = await SQLDB
        .updateData('UPDATE task set title = "$title" WHERE id = $id');

    if (res == 0) {
      return 'failure';
    }
    notifyListeners();
    return "success";
  }

  Future<String> changeTaskStatus(int id, bool isDone) async {
    int d = isDone == false ? 1 : 0;
    int res =
        await SQLDB.updateData('UPDATE task set isdone = $d WHERE id = $id');

    if (res == 0) {
      return 'failure';
    }
    notifyListeners();
    return "success";
  }

  Future<String> deleteTaskFromCategory(int categoryId) async {
    int res = await SQLDB
        .deleteData('DELETE FROM task WHERE categoryid = $categoryId');

    if (res == 0) {
      return 'failure';
    }
    notifyListeners();
    return "success";
  }

  Future<String> deleteTask(int id) async {
    int res = await SQLDB.deleteData('DELETE FROM task WHERE id = $id');

    if (res == 0) {
      return 'failure';
    }
    notifyListeners();
    return "success";
  }

  filterTasks(String key) {
    setKey = key;
    notifyListeners();
  }
}
