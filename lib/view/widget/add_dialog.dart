import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: tasksProvider.formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      tasksProvider.taskTitleController.clear();
                      tasksProvider.changeCategoryStatus(null);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded,
                        color: AppColor.thirdColor),
                  ),
                  TextButton(
                      onPressed: () async {
                        var response = await tasksProvider.addTask();
                        print(response);
                        if (response == 'unselected') {
                          EasyLoading.showError('Please select category');
                        }
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
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(AppColor.primaryColor)),
                      child: Text(
                        'Done',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: AppColor.primaryColor),
                      ))
                ],
              ),
              Text(
                'New Task',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              TextFormField(
                controller: tasksProvider.taskTitleController,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor),
                    ),
                    label: Text(
                      'Title',
                      style: Theme.of(context).textTheme.displayMedium!,
                    )),
                autofocus: true,
                validator: (value) {
                  print('value :$value');
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Add to',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.grey[400]),
              ),
              ...tasksProvider.categoryList.map((category) => InkWell(
                    onTap: () =>
                        tasksProvider.changeCategoryStatus(category.id),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            IconData(category.icon,
                                fontFamily: 'MaterialIcons'),
                            color: HexColor.fromHex(category.color),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(category.title,
                              style: Theme.of(context).textTheme.displaySmall),
                          const Spacer(),
                          if (tasksProvider.categorySelected == category.id)
                            const Icon(
                              Icons.done_rounded,
                              color: AppColor.primaryColor,
                            )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
