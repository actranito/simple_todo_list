import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/constants/app_color.dart';
import 'package:todo_list/core/constants/app_text_style.dart';
import 'package:todo_list/todos/edit_todo/presentation/providers/selected_todo_provider.dart';
import 'package:todo_list/todos/edit_todo/presentation/views/edit_todo_view.dart';
import 'package:todo_list/todos/todos_list/presentation/widgets/completed_indicator.dart';
import 'package:todo_list/todos/todos_list/presentation/controllers/todos_list_controller.dart';

class TodoListItem extends ConsumerWidget {
  const TodoListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(selectedTodoProvider);

    return Dismissible(
      key: ValueKey(todo.id),
      background: Container(
        alignment: Alignment.centerRight,
        color: AppColor.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: AppColor.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => ref.read(todosListControllerProvider.notifier).deleteTodo(todo.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            CompletedIndicator(
              completed: todo.completed,
              onTap: () => ref.read(todosListControllerProvider.notifier).toggleCompleted(todo),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                // onTap: () => EditTodoInfoModal.show(
                //   context: context,
                //   ref: ref,
                //   originalTodo: todo,
                // ),
                onTap: () => Navigator.push(
                  context,
                  EditTodoView.route(context),
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
