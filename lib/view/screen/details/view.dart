import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/icons.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/data/model/categorymodel.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/view/widget/completedtasks_list.dart';
import 'package:todo_app/view/widget/uncompletedtasks_list.dart';

class ViewDetails extends StatelessWidget {
  final CategoryModel categoryModel;
  const ViewDetails({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    // List<TaskModel?> completedTasks = [];
    // List<TaskModel?> unCompletedTasks = [];

    // print('icon :${categoryModel.icon}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            tasksProvider.changeCategoryStatus(0);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: tasksProvider.formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Row(
              children: [
                Icon(
                  IconData(categoryModel.icon, fontFamily: 'MaterialIcons'),
                  color: HexColor.fromHex(categoryModel.color),
                ),
                const SizedBox(width: 2),
                Text(
                  categoryModel.title,
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
            FutureBuilder(
                future: tasksProvider.getTaskByCategoty(categoryModel.id),
                builder: (context, AsyncSnapshot<List<TaskModel>> snapshot) {
                  List<TaskModel?> tasks = snapshot.data == null
                      ? []
                      : snapshot.data!.map(
                          (task) {
                            return TaskModel(
                                id: task.id,
                                title: task.title,
                                isDone: task.isDone,
                                createdAt: task.createdAt,
                                categoryId: task.categoryId);
                          },
                        ).toList();
                  List<TaskModel?> completedTasks = snapshot.data == null
                      ? []
                      : snapshot.data!
                          .map(
                            (task) {
                              return TaskModel(
                                  id: task.id,
                                  title: task.title,
                                  isDone: task.isDone,
                                  createdAt: task.createdAt,
                                  categoryId: task.categoryId);
                            },
                          )
                          .where((task) => task.isDone == true)
                          .toList();
                  List<TaskModel?> unCompletedTasks = snapshot.data == null
                      ? []
                      : snapshot.data!
                          .map(
                            (task) {
                              return TaskModel(
                                  id: task.id,
                                  title: task.title,
                                  isDone: task.isDone,
                                  createdAt: task.createdAt,
                                  categoryId: task.categoryId);
                            },
                          )
                          .where((task) => task.isDone == false)
                          .toList();
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text('${tasks.length} Tasks',style: Theme.of(context).textTheme.displaySmall),
                          const SizedBox(width: 2),
                          StepProgressIndicator(
                            totalSteps: tasks.isEmpty ? 1 : tasks.length,
                            currentStep: completedTasks.length,
                            padding: 0,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: tasksProvider.taskTitleController,
                        autofocus: true,
                        // focusNode: tasksProvider.taskFocusNode,
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.check_box_outline_blank,
                              color: AppColor.primaryColor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  var response = await tasksProvider
                                      .addtaskDetails(categoryModel.id);
                                  print(response);
                                  if (response == 'dublicated') {
                                    EasyLoading.showError('Task is dupicated');
                                  }
                                  if (response == 'success') {
                                    EasyLoading.showSuccess('Added success');
                                    tasksProvider.changeCategoryStatus(0);
                                    // if (context.mounted) Navigator.of(context).pop();
                                  }
                                  tasksProvider.taskTitleController.clear();
                                },
                                icon: const Icon(Icons.done))),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Plase enter your task';
                          }
                          return null;
                        },
                      ),
                      UnCompletedTasksList(
                          tasks: unCompletedTasks, provider: tasksProvider),
                      CompletedTasksList(tasks: completedTasks),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
