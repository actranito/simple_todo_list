import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/presentation/controllers/todos_controller.dart';
import 'package:todo_list/todos/providers/add_new_todo_text_controller_provider.dart';

class AddNewTodo extends ConsumerWidget {
  const AddNewTodo({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (_) => const AddNewTodo(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
          controller: ref.read(addNewTodoTextControllerProvider),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          minLines: 1,
          maxLines: 20,
        ),
        TextButton(
          onPressed: () {
            final newTodo = Todo(
              title: ref.read(addNewTodoTextControllerProvider).text,
            );
            final todosControllerNotifier = ref.read(todosControllerProvider.notifier);
            todosControllerNotifier.addNewTodo(newTodo);
          },
          child: const Text('Add todo'),
        ),
      ],
    );
  }
}
