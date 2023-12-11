// task_state.dart

part of 'task_bloc.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {
  TaskInitialState();
}

class TaskLoadingState extends TaskState {}

class TaskSuccessState extends TaskState {
  final List<Task> tasks;

  TaskSuccessState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String errorMessage;

  TaskErrorState(this.errorMessage);
}


