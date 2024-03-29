import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todist/Bloc/task/repo.dart';
import 'package:todist/model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskInitialState()) {
    on<ReadTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        final tasks = await _taskRepository.fetchTasksfromserver();
        emit(TaskSuccessState(tasks));
      } catch (e) {
        emit(TaskErrorState('Failed to load tasks: $e'));
      }
    });

    on<CreateTaskEvent>((event, emit) async {
      try {
        await _taskRepository.createTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTaskslocal();

        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to create task'));
      }
    });

    on<UpdateTaskEvent>(((event, emit) async {
      try {
        await _taskRepository.updateTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTaskslocal();
        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState("Failed to update the task"));
      }
    }));

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await _taskRepository.deleteTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTaskslocal();
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
    on<UndoTaskEvent>((event, emit) async {
      try {
        await _taskRepository.undoTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTaskslocal();
        Fluttertoast.showToast(
          msg: "Task Undo ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
        );
        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to Undo task'));
      }
    });

    on<SearchTasksEvent>((event, emit) async {
      try {
        final tasks = await _taskRepository.searchTasks(event.query);
        emit(TaskSuccessState(tasks));
      } catch (e) {
        emit(TaskErrorState('Failed to load tasks: $e'));
      }
    });

    on<CompleteTaskEvent>((event, emit) async {
      try {
        await _taskRepository.completeTask(event.task);
        List<Task> listtask = await _taskRepository.fetchTaskslocal();
        emit(TaskSuccessState(listtask));
      } catch (e) {
        emit(TaskErrorState('Failed to delete task'));
      }
    });
  }
}
