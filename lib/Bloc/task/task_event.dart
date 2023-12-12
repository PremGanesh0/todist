part of 'task_bloc.dart';

abstract class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final Task task;

  CreateTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;

  DeleteTaskEvent(this.taskId);
}

class CompleteTaskEvent extends TaskEvent {
  final int taskId;

  CompleteTaskEvent(this.taskId);
}

class ReadTasksEvent extends TaskEvent {}
