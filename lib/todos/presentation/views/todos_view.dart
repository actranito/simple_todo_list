import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/presentation/controllers/todos_controller.dart';
import 'package:todo_list/todos/presentation/widgets/add_new_todo.dart';
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
        onPressed: () => AddNewTodo.show(context),
        child: const Icon(Icons.add),
      ),
      body: todosController.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (_) => const Center(child: Text('Sorry something went wrong')),
        content: (contentState) {
          final todos = contentState.todosList;
          return ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) => TodoItem(todo: todos[i]),
          );
        },
      ),
    );
  }
}
