import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/core/constants/app_string.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/data/todos_list_repository.dart';
import 'package:todo_list/todos/todos_list/presentation/controllers/todos_list_controller_state.dart';
import 'package:uuid/uuid.dart';

final todosListControllerProvider = StateNotifierProvider.autoDispose<TodosListController, TodosListControllerState>(
  (ref) => TodosListController(todosListRepository: ref.watch(todosListRepositoryProvider)),
);

class TodosListController extends StateNotifier<TodosListControllerState> {
  final TodosListRepository todosListRepository;

  late final StreamSubscription todoUpdatesSubscription;

  TodosListController({
    required this.todosListRepository,
  }) : super(const TodosListControllerState.loading()) {
    _intialize();
  }

  @override
  dispose() {
    todoUpdatesSubscription.cancel();
    super.dispose();
  }

  void toggleCompleted(Todo todo) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState || todo.id == null) {
      // If we are not in the correct state, return.
      _showErrorToast();
      return;
    }

    todosListRepository.toggleTodo(todo);
  }

  void addNewTodo(Todo todo) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState) {
      // If we are not in the correct state, return.
      _showErrorToast();
      return;
    }

    // Generate and add an id to the new todo
    final id = const Uuid().v4();
    final newTodo = todo.copyWith(id: id);

    todosListRepository.addNewTodo(newTodo);
  }

  void updateTodo(Todo updatedTodo) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState) {
      // If we are not in the correct state, return.
      _showErrorToast();
      return;
    }

    todosListRepository.updateTodo(updatedTodo);
  }

  void deleteTodo(String? todoId) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState || todoId == null) {
      // If we are not in the correct state, return.
      _showErrorToast();
      return;
    }

    todosListRepository.deleteTodo(todoId);
  }

  // INTERNAL METHODS
  Future<void> _intialize() async {
    try {
      // add a listener to all the todo update events
      final todoUpdatesStream = await todosListRepository.getTodoUpdatesStream();
      todoUpdatesSubscription = todoUpdatesStream.listen(_todoUpdatesListener);

      // Fetch the current version of the todos list and emit a state with it
      final todosList = await todosListRepository.getTodosList();
      state = TodosListControllerState.content(todosList: todosList);
    } catch (e) {
      state = const TodosListControllerState.error();
    }
  }

  void _todoUpdatesListener(BoxEvent event) {
    final currentState = state;
    if (currentState is! TodosListControllerContentState) {
      // If we are not in the correct state, return.
      return;
    }

    final newTodosList = List<Todo>.from(currentState.todosList);

    if (event.deleted == true) {
      newTodosList.removeWhere((element) => element.id == event.key);
      state = currentState.copyWith(todosList: newTodosList);
      return;
    }

    final eventIndex = newTodosList.indexWhere((element) => element.id == event.key);
    if (eventIndex == -1) {
      // If eventIndex is '-1' it means there is no corresponding key in the DB, so it must
      // be a new entry. So we'll add the value to the end of the list
      newTodosList.add(Todo.fromJson(event.value));
    } else {
      // Otherwise just replace the entry with the new value
      newTodosList[eventIndex] = Todo.fromJson(event.value);
    }

    state = currentState.copyWith(todosList: newTodosList);
    return;
  }

  void _showErrorToast() {
    Fluttertoast.showToast(msg: AppString.somethingWentWrong);
  }
}
