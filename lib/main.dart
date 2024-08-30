import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_storage/core/blocObserver/myBlocObserver.dart';
import 'package:flutter_local_storage/core/constants/constants.dart';
import 'package:flutter_local_storage/core/theme/theme.dart';
import 'package:flutter_local_storage/data/models/task_model.dart';
import 'package:flutter_local_storage/ui/cubit/task_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'ui/home_screen/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(tasksBoxName);
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430,932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(context,child)=> BlocProvider(
        create: (context) => TaskViewModel()..getAllTasks(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.mainTheme,
          home: const HomeView(),
        ),
      ),
    );
  }
}
