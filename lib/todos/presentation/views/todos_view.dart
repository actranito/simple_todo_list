import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/presentation/controllers/todos_controller.dart';
import 'package:todo_list/todos/presentation/widgets/todo_full_info_modal.dart';
import 'package:todo_list/todos/presentation/widgets/todo_item.dart';

class TodosView extends ConsumerWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosController = ref.watch(todosControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TodoFullInfoModal.show(context: context, ref: ref),
        child: const Icon(Icons.add),
      ),
      body: todosController.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (_) => const Center(child: Text('Sorry something went wrong')),
        content: (contentState) {
          final todos = contentState.todosList;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: todos.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) => TodoItem(todo: todos[i]),
          );
        },
      ),
    );
  }
}
