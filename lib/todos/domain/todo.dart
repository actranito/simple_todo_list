import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    String? id,
    required String title,
    String? description,
    @Default(false) bool completed,
  }) = _TODO;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.newTodo() => const Todo(title: '');
}
