import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';

class TaskActions extends StatefulWidget {
  final int? id;
  final bool editting;

  const TaskActions({this.id, this.editting = false});

  @override
  State<TaskActions> createState() => _TaskActionsState();
}

class _TaskActionsState extends State<TaskActions> {
  final taskTitleController = TextEditingController();

  final taskdescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? title;

  String? description;

  // void openDialog(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    // if (widget.editting) {
    //   title = taskProvider.tasks.firstWhere((t) => t.id == widget.id).title;
    //   description =
    //       taskProvider.tasks.firstWhere((t) => t.id == widget.id).description;
    // }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              widget.editting ? 'Edit Task' : 'Add Task',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: taskTitleController,
              decoration: InputDecoration(
                label: Text(
                  widget.editting
                      ? taskProvider.tasks
                          .firstWhere((t) => t.id == widget.id)
                          .title
                      : 'title',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'please enter a valid title for task';
                }
                return null;
              },
            ),
            TextFormField(
              controller: taskdescriptionController,
              decoration: InputDecoration(
                label: Text(
                  widget.editting
                      ? taskProvider.tasks
                          .firstWhere((t) => t.id == widget.id)
                          .description
                      : 'description',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'please enter a valid description for task';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: ((ctx) => AlertDialog(
                                title: const Text('warning'),
                                content: const Text('Are you sure?'),
                                backgroundColor: Colors.white70,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();

                                        Navigator.of(context).pop();

                                        String title = taskTitleController.text;
                                        String description =
                                            taskdescriptionController.text;

                                        String response = '';
                                        if (widget.editting) {
                                          response =
                                              await taskProvider.updateTasks(
                                                  widget.id!,
                                                  taskTitleController.text,
                                                  taskdescriptionController
                                                      .text);
                                        } else {
                                          response = await taskProvider
                                              .addTasks(title, description);
                                        }

                                        if (mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            widget.editting
                                                ? (response == 'success'
                                                    ? 'Tasks is updated successfully'
                                                    : 'ERROR : Tasks is not updated')
                                                : (response == 'success'
                                                    ? 'New Task is add successfully'
                                                    : 'New Task is not add'),
                                          )));

                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('No')),
                                ],
                              )),
                        );
                      }
                    },
                    icon: Icon(
                      widget.editting ? Icons.edit : Icons.add,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (widget.editting)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: ((ctx) => AlertDialog(
                                title: const Text('warning'),
                                content: const Text('Are you sure?'),
                                backgroundColor: Colors.white70,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                actions: [
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      Navigator.of(context).pop();

                                      String response = '';
                                      response = await taskProvider
                                          .deleteTasks(widget.id!);
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(response ==
                                                        'success'
                                                    ? 'Tasks is deleted successfully'
                                                    : 'ERROR : Tasks is not deleted')));
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  TextButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ],
                              )),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
