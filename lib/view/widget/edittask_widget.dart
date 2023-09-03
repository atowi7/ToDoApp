import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
// import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class EditTaskWidget extends StatelessWidget {
  final int id;
  const EditTaskWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final taskProvider = Provider.of<TasksProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColor.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.only(left: 20),
            //margin: ,
            decoration: BoxDecoration(
                color: AppColor.forthColor,
                borderRadius: BorderRadius.circular(25)),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                // hintText: taskProvider.taskList
                //     .firstWhere((task) => task.id == id)
                //     .title,
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Please enter a valid title';
                }
                return null;
              },
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Warrning',
                      style: Theme.of(context).textTheme.displayLarge),
                  content: Text('Are you sure?',
                      style: Theme.of(context).textTheme.displayLarge),
                  backgroundColor: AppColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          String res = await taskProvider.editTask(
                              id, textController.text);

                          if (context.mounted) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   backgroundColor: AppColor.primaryColor,
                            //   //margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.2),
                            //   content:  Text(
                            //         res == 'success'
                            //             ? S.of(context).editSuccess
                            //             : S.of(context).editFail,
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .displayLarge)));
                          
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.done,
                            color: AppColor.primaryColor)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close,
                            color: AppColor.primaryColor)),
                  ],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(25)),
              child: const Icon(
                Icons.edit,
                color: AppColor.forthColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
