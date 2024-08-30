import 'package:flutter/material.dart';
import 'package:flutter_local_storage/ui/cubit/task_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../data/models/task_model.dart';

class TaskItemWidget extends StatefulWidget {
  TaskModel taskModel;

  TaskItemWidget(this.taskModel);

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                widget.taskModel.isDone = !widget.taskModel.isDone;
                TaskViewModel.get(context).updateTaskStatus(widget.taskModel, widget.taskModel.isDone);
                setState(() {});
              },
              icon: widget.taskModel.isDone
                  ? Icon(Icons.check_circle_rounded,
                      color: Colors.deepPurple, size: 35.r)
                  : Icon(
                      Icons.circle_outlined,
                      size: 35.r,
                      color: Colors.deepPurple,
                    )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.taskModel.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 10.h,),
              Text(
                widget.taskModel.notes??'',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black45),
              ),
            ],
          ),
          const Spacer(),
          Text(DateFormat('dd-MM-yyyy').format(widget.taskModel.dateTime),style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
