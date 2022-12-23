import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';

final selectedTodoProvider = StateProvider.autoDispose<Todo>((ref) => Todo.newTodo());

final todoTitleTextController = Provider.autoDispose<TextEditingController>(
  (ref) {
    final currentTodo = ref.read(selectedTodoProvider);
    return TextEditingController(text: currentTodo.title);
  },
);

final todoDescriptionTextController = Provider.autoDispose<TextEditingController>(
  (ref) {
    final currentTodo = ref.read(selectedTodoProvider);
    return TextEditingController(text: currentTodo.description);
  },
);
