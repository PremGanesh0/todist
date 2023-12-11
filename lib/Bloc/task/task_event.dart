// task_event.dart

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

class FetchTasksEvent extends TaskEvent {}



class LoadTasksEvent extends TaskEvent {}
