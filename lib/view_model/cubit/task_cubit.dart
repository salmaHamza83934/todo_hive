import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_storage/core/constants/constants.dart';
import 'package:flutter_local_storage/view_model/cubit/task_states.dart';
import 'package:hive/hive.dart';

import '../../models/task_model.dart';

class TaskViewModel extends Cubit<TaskStates>{
  TaskViewModel():super(TaskInitialState());

  List<TaskModel>? tasks;

  static TaskViewModel get(context)=>BlocProvider.of<TaskViewModel>(context);

  addTask(TaskModel task) async{
    {
      try {
        var taskBox = Hive.box<TaskModel>(tasksBoxName);
        await taskBox.add(task);
        emit(AddTaskSuccessState());
      } catch (e) {
        emit(AddTaskErrorState(e.toString()));
      }
      getAllTasks();
    }
  }


  updateTaskStatus(TaskModel task, bool isDone) async {
    try {
      task.isDone = isDone;
      await task.save();
      emit(UpdateTaskSuccessState());
    } catch (e) {
      emit(UpdateTaskErrorState(e.toString()));
    }
    getAllTasks();
  }

  updateTask(TaskModel task, TaskModel updatedTask) async {
    try {
      task.name = updatedTask.name;
      task.notes = updatedTask.notes;
      task.dateTime = updatedTask.dateTime;
      task.isDone = updatedTask.isDone;

      await task.save();
      emit(UpdateTaskSuccessState());
    } catch (e) {
      emit(UpdateTaskErrorState(e.toString()));
    }}


  deleteTask(TaskModel task){
    task.delete();
    emit(DeleteTaskSuccessState());
    getAllTasks();
  }


  getAllTasks() {
    tasks = Hive.box<TaskModel>(tasksBoxName).values.toList();
    emit(GetTasksSuccessState());
  }

}