import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/presentation/controllers/todos_controller_state.dart';

final todosControllerProvider =
    StateNotifierProvider.autoDispose<TodosController, TodosControllerState>((ref) => TodosController());

class TodosController extends StateNotifier<TodosControllerState> {
  TodosController() : super(const TodosControllerState.loading()) {
    _intialize();
  }

  void toggleCompleted(Todo todo) {
    final currentState = state;
    if (currentState is! TodosControllerContentState) {
      // If we are not in the correct state, return.
      // TODO - add error toast
      return;
    }

    // We will create a new instance of Todo with the 'completed' field inverted and insert it
    // in the correct place on the list

    // Get the index of the Todo to toggle
    final todoIndex = currentState.todosList.indexWhere((iterableTodo) => iterableTodo.id == todo.id);
    if (todoIndex == -1) {
      // If the index is '-1' no matchinf item was found, so we return without doing anything
      // TODO - add error toast
      return;
    }

    // Create a new Todo Item with the 'completed' field inverted
    final newTodoState = todo.copyWith(completed: !todo.completed);

    // Create a copy of the todosList and replace the new item
    final newTodosList = List<Todo>.from(currentState.todosList);
    newTodosList.removeAt(todoIndex);
    newTodosList.insert(todoIndex, newTodoState);

    // Emit the state with the new list
    state = currentState.copyWith(todosList: newTodosList);
  }

  void addNewTodo(Todo todo) {
    final currentState = state;
    if (currentState is! TodosControllerContentState) {
      // If we are not in the correct state, return.
      // TODO - add error toast
      return;
    }

    // Generate and add an id to the new todo
    // TODO - replace with uuid library
    final id = Random().nextInt(10000).toString();
    final newTodo = todo.copyWith(id: id);

    // Make a copy of the current todos list
    final newTodosList = List<Todo>.from(currentState.todosList);
    // Add the new todo item to the list
    newTodosList.add(newTodo);

    // Emit the state with the new todo item
    state = currentState.copyWith(todosList: newTodosList);
  }

  // INTERNAL METHODS
  Future<void> _intialize() async {
    final initialTodos = [
      {
        "id": "1",
        "title": "quis ut nam facilis et officia qui",
        "completed": false,
      },
      {
        "id": "2",
        "title": "laboriosam mollitia et enim quasi adipisci quia provident illum",
        "completed": false,
      },
      {
        "id": "3",
        "title": "qui ullam ratione quibusdam voluptatem quia omnis",
        "completed": false,
      }
    ];

    try {
      final todosList = <Todo>[];
      for (final todo in initialTodos) {
        todosList.add(Todo.fromJson(todo));
      }

      await Future.delayed(const Duration(seconds: 2));
      state = TodosControllerState.content(todosList: todosList);
    } catch (e) {
      state = const TodosControllerState.error();
    }
  }
}
