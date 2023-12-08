import 'package:bloc/bloc.dart';
import 'package:todist/Bloc/task/repo.dart';

import '../../model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskInitialState());

   Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is CreateTaskEvent) {
      yield TaskLoadingState();
      try {
        await _taskRepository.createTask(event.task);
        yield TaskSuccessState();
      } catch (e) {
        yield TaskErrorState('Failed to create task');
      }
    } else if (event is UpdateTaskEvent) {
      yield TaskLoadingState();
      try {
        await _taskRepository.updateTask(event.task);
        yield TaskSuccessState();
      } catch (e) {
        yield TaskErrorState('Failed to update task');
      }
    }
  }
}
