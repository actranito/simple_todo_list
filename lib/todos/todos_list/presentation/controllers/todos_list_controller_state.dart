import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/todos/domain/todo.dart';

part 'todos_list_controller_state.freezed.dart';

@freezed
class TodosListControllerState with _$TodosListControllerState {
  const factory TodosListControllerState.loading() = _TodosListControllerLoadingState;
  const factory TodosListControllerState.error() = _TodosListControllerErrorState;
  const factory TodosListControllerState.content({
    required List<Todo> todosList,
  }) = TodosListControllerContentState;
}
