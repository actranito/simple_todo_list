import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/data/todos_list_repository.dart';
import 'package:todo_list/todos/todos_list/presentation/controllers/todos_list_controller_state.dart';
import 'package:uuid/uuid.dart';

final todosListControllerProvider = StateNotifierProvider.autoDispose<TodosListController, TodosListControllerState>(
  (ref) => TodosListController(todosListRepository: ref.watch(todosListRepositoryProvider)),
);

class TodosListController extends StateNotifier<TodosListControllerState> {
  final TodosListRepository todosListRepository;
  TodosListController({
    required this.todosListRepository,
  }) : super(const TodosListControllerState.loading()) {
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
    final id = const Uuid().v4();
    final newTodo = todo.copyWith(id: id);

    todosListRepository.addNewTodo(newTodo);

    // Emit the state with the new todo item
    // state = currentState.copyWith(todosList: newTodosList);
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
    try {
      final todosList = await todosListRepository.getTodosList();
      state = TodosListControllerState.content(todosList: todosList);
    } catch (e) {
      state = const TodosListControllerState.error();
    }
  }
}
