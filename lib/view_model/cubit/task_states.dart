abstract class TaskStates {}

class TaskInitialState extends TaskStates {}


///Add task states
class AddTaskErrorState extends TaskStates {
  final String errMessage;

  AddTaskErrorState(this.errMessage);
}

class AddTaskSuccessState extends TaskStates {}


///Update task states
class UpdateTaskErrorState extends TaskStates {
  final String errMessage;

  UpdateTaskErrorState(this.errMessage);
}

class UpdateTaskSuccessState extends TaskStates {}


///Delete task state
class DeleteTaskErrorState extends TaskStates {
  final String errMessage;

  DeleteTaskErrorState(this.errMessage);
}

class DeleteTaskSuccessState extends TaskStates {}



///Get task states
class GetTasksErrorState extends TaskStates {
  final String errMessage;

  GetTasksErrorState(this.errMessage);
}

class GetTasksSuccessState extends TaskStates {}
