import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_storage/core/shared_widget/task_item_widget.dart';
import 'package:flutter_local_storage/ui/cubit/task_cubit.dart';
import 'package:flutter_local_storage/ui/cubit/task_states.dart';
import 'package:flutter_local_storage/ui/edit_task_screen/edit_task_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../add_task_screen/add_task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<TaskViewModel, TaskStates>(
      bloc: TaskViewModel.get(context),
      builder: (BuildContext context, TaskStates state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddTaskView(),
                    ));
              },
              backgroundColor: Colors.deepPurple,
              elevation: 20,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.r,
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.task_outlined,
                        size: 45.r,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'To Do List',
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
                Expanded(
                    child: TaskViewModel.get(context).tasks?.length != 0 &&
                            TaskViewModel.get(context).tasks != null
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Dismissible(
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) {
                                setState(() {
                                  TaskViewModel.get(context).deleteTask(
                                      TaskViewModel.get(context).tasks![index]);
                                });
                              },
                              key: Key(TaskViewModel.get(context)
                                  .tasks![index]
                                  .dateTime
                                  .toString()),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => EditTaskView(TaskViewModel.get(context).tasks![index]),
                                      ));                                },
                                child: TaskItemWidget(
                                    TaskViewModel.get(context).tasks![index]),
                              ),
                            ),
                            itemCount: TaskViewModel.get(context).tasks?.length,
                          )
                        : Lottie.asset(
                            'assets/lottie/Animation - 1724890476478.json',
                            repeat: false,
                          ))
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, TaskStates state) {},
    );
  }
}
