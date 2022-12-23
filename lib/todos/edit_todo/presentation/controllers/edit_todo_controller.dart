import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/todos/domain/todo.dart';

final initialTodoProvider = StateProvider<Todo?>((_) => null);

final editTodoControllerProvider = StateNotifierProvider.autoDispose<EditTodoController, Todo>(
  (ref) {
    final initialTodo = ref.watch(initialTodoProvider);
    ref.onDispose(() => ref.invalidate(initialTodoProvider));
    return EditTodoController(
      initialTodo: initialTodo,
      // If the initial todo is null, set isNewTodo to true
      isNewTodo: initialTodo == null,
    );
  },
);

class EditTodoController extends StateNotifier<Todo> {
  final Todo? initialTodo;
  final bool isNewTodo;

  // If an initial Todo is passed as a parameter set the current state to that Todo, otherwise
  // set it to a blank todo.
  EditTodoController({
    required this.initialTodo,
    required this.isNewTodo,
  }) : super(initialTodo ?? Todo.newTodo());

  void updateCurrentTodo(Todo updatedTodo) {
    state = updatedTodo;
  }
}
