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
      isScrollControlled: true,
      builder: (_) => const AddNewTodo(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final addNewTodoTextController = ref.watch(addNewTodoTextControllerProvider);

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
