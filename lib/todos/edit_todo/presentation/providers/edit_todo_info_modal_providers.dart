import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/edit_todo/presentation/controllers/edit_todo_controller.dart';

final todoTitleTextControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) {
    final currentTodo = ref.read(editTodoControllerProvider);
    return TextEditingController(text: currentTodo.title);
  },
);

final todoDescriptionTextControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) {
    final currentTodo = ref.read(editTodoControllerProvider);
    return TextEditingController(text: currentTodo.description);
  },
);

final isNewTodoProvider = Provider.autoDispose<bool>(
  (ref) => ref.watch(editTodoControllerProvider.notifier).isNewTodo,
);

final canSaveTodoProvider = Provider.autoDispose<bool>(
  (ref) {
    final currentTodo = ref.watch(editTodoControllerProvider);
    final initialTodo = ref.watch(editTodoControllerProvider.notifier).initialTodo;

    if (initialTodo == null) {
      return true;
    }

    return currentTodo != initialTodo && currentTodo.title.isNotEmpty;
  },
);
