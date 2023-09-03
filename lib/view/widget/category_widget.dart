import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/utils/extensions.dart';

import 'package:todo_app/data/model/categorymodel.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  final TasksProvider provider;
  const CategoryWidget({
    super.key,
    required this.categoryModel,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final color = HexColor.fromHex(categoryModel.color);
    // List<TaskModel?> completedTasks = [];

    return FutureBuilder(
        future: provider.getTaskByCategoty(categoryModel.id),
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
          return Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: AppColor.forthColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 7, offset: Offset(0, 5))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepProgressIndicator(
                    totalSteps: tasks.isEmpty ? 1 : tasks.length,
                    currentStep: completedTasks.length,
                    size: 4,
                    padding: 0,
                    selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.7), color]),
                    unselectedGradientColor: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.white]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          IconData(
                            categoryModel.icon,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: color,
                          size: 30,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categoryModel.title,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${tasks.length} Tasks',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
