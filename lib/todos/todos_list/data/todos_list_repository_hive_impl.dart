import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/todos/domain/todo.dart';
import 'package:todo_list/todos/todos_list/data/todos_list_repository.dart';

class TodosListRepositoryHiveImpl extends TodosListRepository {
  @override
  Future<List<Todo>> getTodosList() async {
    final todosBox = await Hive.openBox<Map<dynamic, dynamic>>('todos');

    final storedTodosList = todosBox.values;

    final todosList = <Todo>[];
    for (final storedTodo in storedTodosList) {
      final todo = storedTodo.map((key, value) => MapEntry(key.toString(), value));
      todosList.add(Todo.fromJson(todo));
    }

    return todosList;
  }

  @override
  Future<bool> addNewTodo(Todo todo) async {
    try {
      final todosBox = await Hive.openBox<Map<dynamic, dynamic>>('todos');
      todosBox.add(todo.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
