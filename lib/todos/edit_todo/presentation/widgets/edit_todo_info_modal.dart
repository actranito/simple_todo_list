import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/constants/app_color.dart';
import 'package:todo_list/core/constants/app_text_style.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/edit_todo/presentation/controllers/edit_todo_controller.dart';
import 'package:todo_list/todos/edit_todo/presentation/providers/edit_todo_info_modal_providers.dart';
import 'package:todo_list/todos/todos_list/presentation/controllers/todos_list_controller.dart';

class EditTodoInfoModal extends ConsumerWidget {
  const EditTodoInfoModal({super.key});

  static void show({
    required BuildContext context,
    required WidgetRef ref,
    Todo? originalTodo,
  }) {
    if (originalTodo != null) {
      ref.read(initialTodoProvider.notifier).state = originalTodo;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const EditTodoInfoModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    final currentTodo = ref.watch(editTodoControllerProvider);
    final todoTitleTextController = ref.watch(todoTitleTextControllerProvider);
    final todoDescriptionTextController = ref.watch(todoDescriptionTextControllerProvider);
    final canSaveTodo = ref.read(canSaveTodoProvider);

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            TextField(
              controller: todoTitleTextController,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              style: AppTextStyle.regularText,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: AppTextStyle.regularText.copyWith(color: AppColor.alternateText),
              ),
              minLines: 1,
              maxLines: 5,
              onChanged: (newTitle) {
                final updatedTodo = currentTodo.copyWith(title: newTitle.trim());
                ref.read(editTodoControllerProvider.notifier).updateCurrentTodo(updatedTodo);
              },
            ),
            TextField(
              controller: todoDescriptionTextController,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              style: AppTextStyle.subText.copyWith(color: AppColor.alternateText),
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: AppTextStyle.subText.copyWith(
                  color: AppColor.alternateText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              minLines: 1,
              maxLines: 5,
              onChanged: (newDescription) {
                final updatedTodo = currentTodo.copyWith(description: newDescription.trim());
                ref.read(editTodoControllerProvider.notifier).updateCurrentTodo(updatedTodo);
              },
            ),
            TextButton(
              onPressed: canSaveTodo
                  ? () {
                      final isNewTodo = ref.read(isNewTodoProvider);
                      if (isNewTodo == true) {
                        final newTodo = Todo(
                          title: todoTitleTextController.text,
                          description: todoDescriptionTextController.text,
                        );
                        ref.read(todosListControllerProvider.notifier).addNewTodo(newTodo);
                      } else {
                        final updatedTodo = ref.read(editTodoControllerProvider);
                        ref.read(todosListControllerProvider.notifier).updateTodo(updatedTodo);
                      }
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            SizedBox(height: bottomInsets),
          ],
        ),
      ),
    );
  }
}
