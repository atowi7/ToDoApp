import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: AppColor.forthColor, borderRadius: BorderRadius.circular(25)),
      child: TextField(
        onChanged: (keyword) {
          Provider.of<TasksProvider>(context, listen: false)
              .filterTasks(keyword);
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_rounded,color: AppColor.primaryColor,),
            hintText: S.of(context).searchHint,
            hintStyle: Theme.of(context).textTheme.displayMedium,
            border: InputBorder.none),
      ),
    );
  }
}
