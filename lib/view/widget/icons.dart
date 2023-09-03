import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(
      IconData(AppIcons.personIcon, fontFamily: 'MaterialIcons'),
      color: AppColor.primaryColor,
    ),
    Icon(
      IconData(AppIcons.workIcon, fontFamily: 'MaterialIcons'),
      color: AppColor.primaryColor,
    ),
    Icon(
      IconData(AppIcons.sportIcon, fontFamily: 'MaterialIcons'),
      color: AppColor.primaryColor,
    ),
    Icon(
      IconData(AppIcons.travelIcon, fontFamily: 'MaterialIcons'),
      color: AppColor.primaryColor,
    ),
    Icon(
      IconData(AppIcons.shopeIcon, fontFamily: 'MaterialIcons'),
      color: AppColor.primaryColor,
    ),
  ];
}
