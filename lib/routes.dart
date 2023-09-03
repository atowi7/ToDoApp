import 'package:flutter/material.dart';
import 'package:todo_app/view/screen/details/view.dart';
import 'package:todo_app/view/screen/home_screen.dart';
import 'package:todo_app/view/widget/add_dialog.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/home': (p0) => const HomeScreen(),
  '/adddialog': (p1) => const AddDialog(),
};
