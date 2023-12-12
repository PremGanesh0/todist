import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskInitialState()) {
    on<LoadTasksEvent>((event, emit) async {
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
        Fluttertoast.showToast(
            msg: "This is Top Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1);

        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to create task'));
      }
    });

    on<UpdateTaskEvent>(((event, emit) async {
      try {
        await _taskRepository.updateTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTasks();
        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState("Failed to update the task"));
      }
    }));

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await _taskRepository.deleteTask(event.taskId);
        List<Task> listtask = await _taskRepository.fetchTasks();
        Fluttertoast.showToast(
          msg: "Task deleted ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
        );

        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to delete task'));
      }
    });
  }
}
