import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/edit_todo/presentation/providers/selected_todo_provider.dart';

class EditTodoView2 extends ConsumerWidget {
  const EditTodoView2({super.key});

  static String routeName = '/edit_todo_view_2';
  static route(BuildContext context) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) {
        final providerContainer = ProviderScope.containerOf(context);
        return ProviderScope(
          parent: providerContainer,
          child: const EditTodoView2(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTodo = ref.watch(selectedTodoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit todo view 2')),
      body: Center(child: Text(selectedTodo.title)),
    );
  }
}
