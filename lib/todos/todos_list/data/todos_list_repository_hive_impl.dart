import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/data/todos_list_repository.dart';

class TodosListRepositoryHiveImpl extends TodosListRepository {
  static const String _todosBox = 'todos';

  @override
  Future<List<Todo>> getTodosList() async {
    final todosBox = await Hive.openBox<Map<dynamic, dynamic>>(_todosBox);

    final storedTodosList = todosBox.values;

    final todosList = <Todo>[];
    for (final storedTodo in storedTodosList) {
      final todo = storedTodo.map((key, value) => MapEntry(key.toString(), value));
      todosList.add(Todo.fromJson(todo));
    }

    todosList.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    return todosList;
  }

  @override
  Future<bool> addNewTodo(Todo todo) async {
    try {
      final todosBox = await Hive.openBox<Map<dynamic, dynamic>>(_todosBox);
      todosBox.put(todo.id, todo.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
    try {
      final todosBox = await Hive.openBox<Map<dynamic, dynamic>>(_todosBox);
      todosBox.put(todo.id, todo.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTodo(String todoId) async {
    try {
      final todosBox = await Hive.openBox<Map<dynamic, dynamic>>(_todosBox);
      todosBox.delete(todoId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> toggleTodo(Todo todo) async {
    try {
      // Create a new copy of the todo with the completed field toggled
      final newTodo = todo.copyWith(completed: !todo.completed);
      return updateTodo(newTodo);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Stream<BoxEvent>> getTodoUpdatesStream() async {
    final todosBox = await Hive.openBox<Map<dynamic, dynamic>>(_todosBox);
    return todosBox.watch();
  }
}
