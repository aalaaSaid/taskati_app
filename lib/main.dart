import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_storge.dart';
import 'package:taskati/features/splash_screen.dart';

import 'core/utils/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox('userBox');
  await Hive.openBox<TaskModel>('tasksBox');
  AppLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: AppLocalStorage.userBox.listenable(),
      builder: (context, value, child) {
        bool isDark= AppLocalStorage.getCachedDataOfUser('isDark')??false;
        return MaterialApp(
          //themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: isDark?ThemeMode.dark:ThemeMode.light,

        );
      },
    );
  }
}
