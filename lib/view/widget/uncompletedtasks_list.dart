import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/data/model/taskmodel.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class UnCompletedTasksList extends StatelessWidget {
  final List<TaskModel?> tasks;
  final TasksProvider provider;
  const UnCompletedTasksList(
      {super.key, required this.tasks, required this.provider});

  @override
  Widget build(BuildContext context) {
    // TasksProvider tasksProvider =
    //     Provider.of<TasksProvider>(context);
    final size = MediaQuery.of(context).size;

    return tasks.isEmpty
        ? Row(
            children: [
              Lottie.asset(
                'assets/lottie/todo.json',
                height: size.height / 2,
                width: size.width / 2,
              ),
              Text('No tasks',
                  style: Theme.of(context).textTheme.displayLarge),
            ],
          )
        : ListView(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              ...tasks.map((task) => Dismissible(
                    key: ObjectKey(task),
                    onDismissed: (_) async {
                      String response = await provider.deleteTask(task.id);

                      if (response == 'success') {
                        EasyLoading.showSuccess('Task is deleted successfully');
                      }
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: AppColor.fifthColor,
                      child: const Icon(
                        Icons.delete_forever_rounded,
                        color: AppColor.primaryColor,
                        size: 30,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.changeTaskStatus(task!.id, task.isDone);
                            // provider.taskFocusNode.unfocus();
                          },
                          icon: const Icon(
                            Icons.check_box_outline_blank_outlined,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          task!.title,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  )),
              if (tasks.isNotEmpty)
                const Divider(
                  thickness: 2,
                  color: AppColor.primaryColor,
                )
            ],
          );
  }
}
