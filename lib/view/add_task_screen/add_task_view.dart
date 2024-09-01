import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_storage/core/shared_widget/task_form_field.dart';
import 'package:flutter_local_storage/core/shared_widget/task_date_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/task_model.dart';
import '../../view_model/cubit/task_cubit.dart';
import '../../view_model/cubit/task_states.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
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
                          'Add Task',
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
                            fieldName: 'What you would like to do?',
                            controller: taskNameController,
                            icon: Icons.drive_file_rename_outline,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TaskFormField(
                            fieldName: 'Add notes',
                            controller: taskNotesController,
                            icon: Icons.bookmark_rounded,
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
                                TaskViewModel.get(context).addTask(TaskModel(
                                    name: taskNameController.text,
                                    notes: taskNotesController.text,
                                    dateTime: selectedDate ?? DateTime.now()));
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
                                'Add Task!',
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
