import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class AddWidget extends StatelessWidget {
  const AddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.3,
        margin: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Task Type',
                    style: Theme.of(context).textTheme.displayMedium),
                content: Form(
                    key: tasksProvider.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: tasksProvider.categoryTitleController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Title')),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                        ),
                        Wrap(
                          spacing: 2,
                          children: tasksProvider.icons.map((e) {
                            final index = tasksProvider.icons.indexOf(e);
                            return Consumer<TasksProvider>(
                              builder: (context, task, child) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ChoiceChip(
                                  selectedColor: AppColor.secondaryColor,
                                  label: e,
                                  selected: task.chipIndex == index,
                                  onSelected: (value) {
                                    tasksProvider.changeChopIndex(index);
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            String response = await tasksProvider.addCategory();

                            if (response == 'duplicated') {
                              EasyLoading.showError('Category is dupicated');
                            }
                            if (response == 'success') {
                              tasksProvider.categoryTitleController.clear();
                              tasksProvider.changeChopIndex(0);
                              EasyLoading.showSuccess(
                                  'Category is Added successfully');
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                Navigator.of(context).focusNode.unfocus();
                              }
                            }
                          },
                          minWidth: 50,
                          color: Colors.grey[400],
                          splashColor: AppColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: const Icon(
                            Icons.add_outlined,
                            color: AppColor.primaryColor,
                          ),
                        )
                      ],
                    )),
              ),
            );
          },
          child: const Card(
            child: Center(
              child: Icon(Icons.add),
            ),
          ),
        ));
  }
}
