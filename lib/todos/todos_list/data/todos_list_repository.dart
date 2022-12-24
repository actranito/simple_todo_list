import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/data/todos_list_repository_hive_impl.dart';

final todosListRepositoryProvider = Provider((ref) => TodosListRepositoryHiveImpl());

abstract class TodosListRepository {
  /// This method is used to get the List of todos for this device
  Future<List<Todo>> getTodosList();

  /// This methods adds saves a new todo to the DB
  Future<bool> addNewTodo(Todo todo);
}
