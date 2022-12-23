import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/constants/app_color.dart';
import 'package:todo_list/core/constants/app_text_style.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/presentation/controllers/todos_controller.dart';
import 'package:todo_list/todos/presentation/widgets/completed_indicator.dart';
import 'package:todo_list/todos/presentation/widgets/todo_full_info_modal.dart';

class TodoItem extends ConsumerWidget {
  final Todo todo;
  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => TodoFullInfoModal.show(context: context, ref: ref),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          CompletedIndicator(
            completed: todo.completed,
            onTap: () => ref.read(todosControllerProvider.notifier).toggleCompleted(todo.id),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.regularText.copyWith(
                    decoration: todo.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                if (todo.description != null)
                  Text(
                    todo.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.subText.copyWith(
                      color: AppColor.alternateText,
                      decoration: todo.completed ? TextDecoration.lineThrough : null,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
