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
  final Task task;

  DeleteTaskEvent(this.task);
}

class UndoTaskEvent extends TaskEvent {
  final Task task;
  
  UndoTaskEvent(this.task);
}

class CompleteTaskEvent extends TaskEvent {
  final Task task;

  CompleteTaskEvent(this.task);
}

class ReadTasksEvent extends TaskEvent {
  ReadTasksEvent();
}
