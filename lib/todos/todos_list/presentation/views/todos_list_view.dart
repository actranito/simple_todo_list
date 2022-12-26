import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/constants/app_string.dart';
import 'package:todo_list/todos/edit_todo/presentation/widgets/edit_todo_info_modal.dart';
import 'package:todo_list/todos/todos_list/presentation/widgets/todo_list_item.dart';
import 'package:todo_list/todos/todos_list/presentation/controllers/todos_list_controller.dart';

class TodosListView extends ConsumerWidget {
  const TodosListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosController = ref.watch(todosListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.todos),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditTodoInfoModal.show(context: context, ref: ref),
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
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (_, i) => TodoListItem(todo: todos[i]),
          );
        },
      ),
    );
  }
}
