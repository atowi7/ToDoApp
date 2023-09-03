import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class CompletedTasksList extends StatelessWidget {
  final List<TaskModel?> tasks;
  const CompletedTasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    // TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    // List<TaskModel> completedTasks = tasks
    //     .map((task) => TaskModel(
    //         id: task.id,
    //         title: task.title,
    //         isDone: task.isDone,
    //         createdAt: task.createdAt,
    //         categoryId: task.categoryId))
    //     .where((t) => t.isDone == true)
    //     .toList();
    // print('completedTasks');
    // print(completedTasks);
    return tasks.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: [
              Text('Completed [${tasks.length}]',
                  style: Theme.of(context).textTheme.displayMedium),
              ...tasks.map((task) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.done,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        task!.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  )),
            ],
          )
        : Container();
  }
}
