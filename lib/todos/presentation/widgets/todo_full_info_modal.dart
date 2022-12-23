import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/presentation/controllers/todos_controller.dart';
import 'package:todo_list/todos/providers/todo_full_info_modal_providers.dart';

class TodoFullInfoModal extends ConsumerWidget {
  const TodoFullInfoModal({super.key});

  static void show({
    required BuildContext context,
    required WidgetRef ref,
    Todo? originalTodo,
  }) {
    if (originalTodo != null) {
      ref.read(selectedTodoProvider.notifier).state = originalTodo;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const TodoFullInfoModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final addNewTodoTextController = ref.watch(todoTitleTextController);

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
            controller: addNewTodoTextController,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            minLines: 1,
            maxLines: 5,
          ),
          TextButton(
            onPressed: () {
              final newTodo = Todo(
                title: addNewTodoTextController.text,
                description: '',
              );
              ref.read(todosControllerProvider.notifier).addNewTodo(newTodo);
              addNewTodoTextController.clear();
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
