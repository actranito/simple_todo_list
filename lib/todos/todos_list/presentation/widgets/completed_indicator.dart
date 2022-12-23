import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_color.dart';

class CompletedIndicator extends StatelessWidget {
  final bool completed;
  final void Function()? onTap;

  const CompletedIndicator({
    super.key,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.grey, width: 1.5),
            ),
          ),
          if (completed)
            const SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.check,
                size: 30,
                color: AppColor.darkGrey,
              ),
            ),
        ],
      ),
    );
  }
}
