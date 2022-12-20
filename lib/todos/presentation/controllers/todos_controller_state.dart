import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/todos/domain/todo.dart';

part 'todos_controller_state.freezed.dart';

@freezed
class TodosControllerState with _$TodosControllerState {
  const factory TodosControllerState.loading() = _TodosControllerLoadingState;
  const factory TodosControllerState.error() = _TodosControllerErrorState;
  const factory TodosControllerState.content({
    required List<Todo> todosList,
  }) = TodosControllerContentState;
}
