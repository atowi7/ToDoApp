import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';

class SearchTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => taskProvider.filterTasks(value),
        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          label: const Text('Search'),
          hintStyle: Theme.of(context).textTheme.headline2,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
