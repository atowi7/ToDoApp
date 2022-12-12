import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/widget/task_actions.dart';

class TaskItem extends StatelessWidget {
  final int n;
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final bool done;
  //final Function editTask;
  // final Function deleteTask;

  const TaskItem(
    Key key,
    this.n,
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.done,
  ) : super(key: key);

  //int time = 24;

  editTaskDailog(BuildContext context, int id) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskActions(id: id, editting: true),
    );
  }

  // Color _getProgressColor(double progress) {
  //   if (progress == 0.9) {
  //     return Colors.green;
  //   } else if (progress >= 0.8 && progress < 0.9) {
  //     return Colors.blue;
  //   } else if (progress >= 0.7 && progress < 0.8) {
  //     return Colors.orange;
  //   } else if (progress > 0 && progress < 0.7) {
  //     return Colors.red;
  //   } else {
  //     return Colors.grey;
  //   }
  // }

  /*TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 120),
              tween: Tween<double>(begin: 0, end: 24),
              onEnd: () => taskProvider.toggle(widget.id, widget.done),
              builder: (BuildContext ctx, double value, Widget? child) =>
                  CircularProgressIndicator(
                value: value,
                color: _getProgressColor(value),
                backgroundColor: Colors.grey,
              ),
            ),*/

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    initializeDateFormatting();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
            onTap: () => editTaskDailog(context, id),
            leading: Text('$n. '),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration:
                    done ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            subtitle: Text(
              DateFormat.MEd(Localizations.localeOf(context).languageCode)
                  .format(DateTime.parse(createdAt)),
              style: const TextStyle(
                color: Colors.white38,
              ),
            ),
            trailing: Checkbox(
              value: done,
              activeColor: Theme.of(context).primaryColor,
              side: const BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              onChanged: (value) {
                taskProvider.toggle(id, done);
              },
            )),
      ),
    );
  }
}
