import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_color.dart';

class AppTextStyle {
  // Headlines
  static const headline1 = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    color: AppColor.baseText,
  );
  static const headline2 = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColor.baseText,
  );
  static const headline3 = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColor.baseText,
  );
  static const headline4 = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColor.baseText,
  );

  // Body
  static const semiBoldText = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColor.baseText,
  );
  static const regularText = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColor.baseText,
  );
  static const subText = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColor.baseText,
  );
  static const smallText = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColor.baseText,
  );

  // Special
  static const button = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Colors.black,
  );
  static const textButton = TextStyle(
    fontFamily: '.SF UI Text',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: Colors.black,
  );
}
