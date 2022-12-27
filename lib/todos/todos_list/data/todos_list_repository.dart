import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/data/todos_list_repository_hive_impl.dart';

final todosListRepositoryProvider = Provider((ref) => TodosListRepositoryHiveImpl());

abstract class TodosListRepository {
  /// This method is used to get the List of todos for this device
  Future<List<Todo>> getTodosList();

  /// This methods adds saves a new todo to the DB
  Future<bool> addNewTodo(Todo todo);

  Future<bool> updateTodo(Todo todo);

  Future<bool> deleteTodo(String todoId);

  Future<bool> toggleTodo(Todo todo);

  // Returns a stream of BoxEvents everytime the info about a todo changes
  Future<Stream<BoxEvent>> getTodoUpdatesStream();
}
