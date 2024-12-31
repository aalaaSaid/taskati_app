import 'package:hive/hive.dart';
part 'task_model.g.dart';
@HiveType(typeId: 1)
class TaskModel{
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? desc;
  @HiveField(3)
  String? date;
  @HiveField(4)
  String? startTime;
  @HiveField(5)
  String? endTime;
  @HiveField(6)
  int? selectedColor;
  @HiveField(7)
  bool? isCompleted;
  TaskModel({this.id,this.title,this.desc,
    this.date,this.startTime,this.endTime,this.selectedColor,
  this.isCompleted
  });
}