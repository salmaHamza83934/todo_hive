import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_storage/core/shared_widget/task_form_field.dart';
import 'package:flutter_local_storage/core/shared_widget/task_date_widget.dart';
import 'package:flutter_local_storage/data/models/task_model.dart';
import 'package:flutter_local_storage/ui/cubit/task_cubit.dart';
import 'package:flutter_local_storage/ui/cubit/task_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTaskView extends StatefulWidget {
  TaskModel task;

  EditTaskView(this.task);

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskNotesController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<TaskViewModel, TaskStates>(
      bloc: TaskViewModel.get(context),
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add_task_rounded,
                          size: 45.r,
                          color: Colors.deepPurple,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          'Edit Task',
                          style: theme.textTheme.titleLarge!
                              .copyWith(fontSize: 35.sp),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Divider(
                      thickness: 1.r,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TaskFormField(
                            fieldName: 'Edit task name',
                            controller: taskNameController,
                            icon: Icons.drive_file_rename_outline,
                            hintTxt: widget.task.name,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TaskFormField(
                            fieldName: 'Edit notes',
                            controller: taskNotesController,
                            icon: Icons.bookmark_rounded,
                            hintTxt: widget.task.notes ?? '',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Select Date',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TaskDateWidget(
                            initialDate: widget.task.dateTime,
                            onDateSelected: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                TaskViewModel.get(context).updateTask(
                                    widget.task,
                                    TaskModel(
                                        name: taskNameController.text,
                                        notes: taskNotesController.text,
                                        dateTime: selectedDate ??
                                            widget.task.dateTime));
                                Future.delayed(
                                    const Duration(milliseconds: 800), () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Container(
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Center(
                                  child: Text(
                                'Edit Task!',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
