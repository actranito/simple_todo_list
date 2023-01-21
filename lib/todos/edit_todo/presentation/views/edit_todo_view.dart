import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/edit_todo/presentation/providers/selected_todo_provider.dart';
import 'package:todo_list/todos/edit_todo/presentation/views/edit_todo_view_2.dart';

class EditTodoView extends ConsumerWidget {
  const EditTodoView({super.key});

  static String routeName = '/edit_todo_view';
  static route(BuildContext context) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) {
        final providerContainer = ProviderScope.containerOf(context);
        return ProviderScope(
          parent: providerContainer,
          child: const EditTodoView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTodo = ref.watch(selectedTodoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit todo view')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selectedTodo.title),
            TextButton(
              onPressed: () => Navigator.push(context, EditTodoView2.route(context)),
              child: const Text('Go to next page'),
            ),
          ],
        ),
      ),
    );
  }
}
