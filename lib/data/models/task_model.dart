import 'package:hive/hive.dart';

part 'task_model.g.dart';
@HiveType(typeId:0)
class TaskModel extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  String? notes;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  bool isDone;

  TaskModel(
      {required this.name,
      this.notes,
      required this.dateTime,
      this.isDone = false});
}
