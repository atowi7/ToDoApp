import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/widget/taskitem.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    int n = 0;
    return FutureBuilder(
        future: taskProvider.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  '${taskProvider.tasks.length} Tasks',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Consumer<TaskProvider>(
                builder: (context, taskData, _) => taskData.tasks.isEmpty
                    ? Text(
                        "no tasks",
                        style: Theme.of(context).textTheme.headline1,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskData.tasks.length,
                        itemBuilder: (ctx, i) {
                          return Column(
                            children: [
                              TaskItem(
                                ValueKey(taskData.tasks[i].id),
                                ++n,
                                taskData.tasks[i].id,
                                taskData.tasks[i].title,
                                taskData.tasks[i].description,
                                taskData.tasks[i].createdAt,
                                taskData.tasks[i].done,
                              ),
                              const Divider(
                                  color: Colors.white24, thickness: 1),
                            ],
                          );
                        }),
              ),
            ],
          );
        });
  }
}
