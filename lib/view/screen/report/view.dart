import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    // List<TaskModel> completedTasks = tasksProvider.taskList
    //     .map((task) => TaskModel(
    //         id: task.id,
    //         title: task.title,
    //         isDone: task.isDone,
    //         createdAt: task.createdAt,
    //         categoryId: task.categoryId))
    //     .where((t) => t.isDone == true)
    //     .toList();

    // int unCompletedTasks =
    //     tasksProvider.taskList.length - completedTasks.length;

    // double percentage =
    //     (completedTasks.length / tasksProvider.taskList.length) * 100;
    // print(completedTasks.length);
    // print(unCompletedTasks);
    // print(percentage);

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: tasksProvider.getTasks(),
              builder: (context, AsyncSnapshot<List<TaskModel>> snapshot) {
                List<TaskModel> tasks = snapshot.data == null
                    ? []
                    : snapshot.data!
                        .map((task) => TaskModel(
                            id: task.id,
                            title: task.title,
                            isDone: task.isDone,
                            createdAt: task.createdAt,
                            categoryId: task.categoryId))
                        .toList();
                List<TaskModel> completedTasks = snapshot.data == null
                    ? []
                    : snapshot.data!
                        .map((task) => TaskModel(
                            id: task.id,
                            title: task.title,
                            isDone: task.isDone,
                            createdAt: task.createdAt,
                            categoryId: task.categoryId))
                        .where((t) => t.isDone == true)
                        .toList();

                int unCompletedTasks = tasks.length - completedTasks.length;

                double percentage =
                    (completedTasks.length / tasks.length) * 100;

                return ListView(padding: const EdgeInsets.all(8), children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.data_usage,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text('Report',
                          style: Theme.of(context).textTheme.displayLarge),
                    ],
                  ),
                  Text(DateFormat.yMMMd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.displayMedium),
                  const Divider(
                    thickness: 2,
                    color: AppColor.thirdColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatus(context, Colors.green, unCompletedTasks,
                          'Live Tasks'),
                      _buildStatus(context, Colors.orange,
                          completedTasks.length, 'Completed'),
                      _buildStatus(
                          context, Colors.blue, tasks.length, 'Created'),
                    ],
                  ),
                  const SizedBox(height: 50),
                  UnconstrainedBox(
                    child: SizedBox(
                      height: 280,
                      width: 280,
                      child: CircularStepProgressIndicator(
                        totalSteps: tasks.isEmpty ? 1 : tasks.length,
                        currentStep: completedTasks.length,
                        stepSize: 18,
                        selectedStepSize: 20,
                        selectedColor: AppColor.primaryColor,
                        unselectedColor: AppColor.thirdColor,
                        // width: 150,
                        // height: 150,
                        padding: 0,
                        roundedCap: (_, __) => true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${completedTasks.isEmpty ? 0 : percentage.toStringAsFixed(0)} %',
                                style:
                                    Theme.of(context).textTheme.displayLarge),
                            const SizedBox(height: 2),
                            Text('Efficiency',
                                style:
                                    Theme.of(context).textTheme.displayMedium)
                          ],
                        ),
                      ),
                    ),
                  )
                ]);
              })),
    );
  }

  Row _buildStatus(BuildContext context, Color color, int number, String text) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 4, color: color),
          ),
        ),
        const SizedBox(width: 2),
        Column(
          children: [
            Text(
              '$number',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 2),
            Text(text, style: Theme.of(context).textTheme.displaySmall)
          ],
        ),
      ],
    );
  }
}
