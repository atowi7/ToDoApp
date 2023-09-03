import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/model/categorymodel.dart';

class CategoriesProvider with ChangeNotifier{
  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get CategoryList{
    return _categoryList;
  }
}