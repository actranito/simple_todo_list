import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/presentation/controllers/todos_list_controller_state.dart';

final todosListControllerProvider =
    StateNotifierProvider.autoDispose<TodosListController, TodosListControllerState>((ref) => TodosListController());

class TodosListController extends StateNotifier<TodosListControllerState> {
  TodosListController() : super(const TodosListControllerState.loading()) {
    _intialize();
  }

  void toggleCompleted(String? todoId) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState || todoId == null) {
      // If we are not in the correct state, return.
      // TODO - add error toast
      return;
    }

    // We will create a new instance of Todo with the 'completed' field inverted and insert it
    // in the correct place on the list

    // Get the index of the Todo to toggle
    final todoIndex = currentState.todosList.indexWhere((iterableTodo) => iterableTodo.id == todoId);
    if (todoIndex == -1) {
      // If the index is '-1' no matchinf item was found, so we return without doing anything
      // TODO - add error toast
      return;
    }

    // Get current todo
    final todo = currentState.todosList[todoIndex];
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
    if (currentState is! TodosListControllerContentState) {
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

  void updateTodo(Todo updatedTodo) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState) {
      // If we are not in the correct state, return.
      // TODO - add error toast
      return;
    }

    // Locate the index on the list and replace it with the new one

    // Get the index of the Todo to update
    final todoIndex = currentState.todosList.indexWhere((iterableTodo) => iterableTodo.id == updatedTodo.id);
    if (todoIndex == -1) {
      // If the index is '-1' no matchinf item was found, so we return without doing anything
      // TODO - add error toast
      return;
    }

    // Create a copy of the todosList and replace the new item
    final newTodosList = List<Todo>.from(currentState.todosList);
    newTodosList.removeAt(todoIndex);
    newTodosList.insert(todoIndex, updatedTodo);

    // Emit the state with the new list
    state = currentState.copyWith(todosList: newTodosList);
  }

  // INTERNAL METHODS
  Future<void> _intialize() async {
    final initialTodos = [
      {
        "id": "1",
        "title": "quis ut nam facilis et officia qui",
        "completed": false,
        "description":
            "quis ut nam facilis et officia qui quis ut nam facilis et officia qui quis ut nam facilis et officia qui"
      },
      {
        "id": "2",
        "title": "laboriosam mollitia et enim quasi adipisci quia provident illum",
        "completed": false,
        "description":
            "quis ut nam facilis et officia qui quis ut nam facilis et officia qui quis ut nam facilis et officia qui" *
                3
      },
      {
        "id": "3",
        "title": "qui ullam ratione quibusdam voluptatem quia omnis",
        "completed": false,
        "description":
            "quis ut nam facilis et officia qui quis ut nam facilis et officia qui quis ut nam facilis et officia qui" *
                2
      }
    ];

    try {
      final todosList = <Todo>[];
      for (final todo in initialTodos) {
        todosList.add(Todo.fromJson(todo));
      }

      await Future.delayed(const Duration(seconds: 2));
      state = TodosListControllerState.content(todosList: todosList);
    } catch (e) {
      state = const TodosListControllerState.error();
    }
  }
}
