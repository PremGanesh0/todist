import 'package:bloc/bloc.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskInitialState()) {
    on<LoadTasksEvent>((event, emit) async {
      print("load the task event");
      emit(TaskLoadingState());
      try {
        final tasks = await _taskRepository.fetchTasks();
        emit(TaskSuccessState(tasks));
      } catch (e) {
        emit(TaskErrorState('Failed to load tasks: $e'));
      }
    });

    on<CreateTaskEvent>((event, emit) async {
      try {
        await _taskRepository.createTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTasks();
        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to create task'));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await _taskRepository.deleteTask(event.taskId);
        List<Task> listtask = await _taskRepository.fetchTasks();
        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to delete task'));
      }
    });
  }
}
