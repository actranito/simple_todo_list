import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
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
      ref.watch(selectedTodoProvider.notifier).state = originalTodo;
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
    final todoTitleTextController = ref.watch(todoTitleTextControllerProvider);
    final todoDescriptionTextController = ref.watch(todoDescriptionTextControllerProvider);

    return SizedBox(
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
            minLines: 1,
            maxLines: 5,
          ),
          TextField(
            controller: todoDescriptionTextController,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            minLines: 1,
            maxLines: 5,
          ),
          TextButton(
            onPressed: () {
              final newTodo = Todo(
                title: todoTitleTextController.text,
                description: todoDescriptionTextController.text,
              );
              ref.read(todosListControllerProvider.notifier).addNewTodo(newTodo);
              Navigator.pop(context);
            },
            child: const Text('Add todo'),
          ),
          const SizedBox(height: 30),
          SizedBox(height: bottomInsets),
        ],
      ),
    );
  }
}
