import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/data/model/categorymodel.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/provider/localization_provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/view/screen/details/view.dart';
import 'package:todo_app/view/screen/report/view.dart';
import 'package:todo_app/view/widget/add_widget.dart';
import 'package:todo_app/view/widget/search_widget.dart';
import 'package:todo_app/view/widget/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var localizationProvider =
    //     Provider.of<LocalizationProvider>(context, listen: false);
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      body: IndexedStack(
        index: tasksProvider.tabIndex,
        children: [
          SafeArea(
              child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Text('My List', style: Theme.of(context).textTheme.displayLarge),
              FutureBuilder(
                  future: tasksProvider.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      );
                    }
                    return GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...tasksProvider.categoryList.map((category) {
                          return LongPressDraggable<CategoryModel>(
                              data: category,
                              onDragStarted: () =>
                                  tasksProvider.changeCategoryDeleted(true),
                              onDragEnd: (_) =>
                                  tasksProvider.changeCategoryDeleted(false),
                              onDraggableCanceled: (_, __) =>
                                  tasksProvider.changeCategoryDeleted(false),
                              feedback: Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: AppColor.thirdColor,
                                    child: Icon(
                                      IconData(
                                        category.icon,
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      color: HexColor.fromHex(category.color),
                                      size: 30,
                                    ),
                                  )),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ViewDetails(
                                          categoryModel: category,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CategoryWidget(
                                    categoryModel: category,
                                    provider: tasksProvider,
                                  )));
                        }),
                        const AddWidget(),
                      ],
                    );
                  })
            ],
          )),
          const ViewReport(),
        ],
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) => FloatingActionButton(
          onPressed: () {
            if (tasksProvider.categoryList.isEmpty) {
              EasyLoading.showInfo('Please create your task category');
            } else {
              Navigator.of(context).pushNamed('/adddialog');
            }
          },
          child: Icon(
            tasksProvider.categoryDeleted
                ? Icons.delete_forever_rounded
                : Icons.add_rounded,
            color: tasksProvider.categoryDeleted
                ? AppColor.fifthColor
                : AppColor.primaryColor,
          ),
        ),
        onAccept: (CategoryModel categoryModel) async {
          if (tasksProvider.categoryDeleted) {
            String response =
                await tasksProvider.deleteCategory(categoryModel.id);
            if (response == 'success') {
              return EasyLoading.showSuccess('Deleted success');
            }
            return EasyLoading.showSuccess('Deleted Failure');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => tasksProvider.changeTabIndex(index),
          currentIndex: tasksProvider.tabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.apps,
                    color: AppColor.primaryColor,
                  ),
                )),
            BottomNavigationBarItem(
                label: 'Rebort',
                icon: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.data_usage,
                    color: AppColor.primaryColor,
                  ),
                ))
          ]),
    );
  }
}
