import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/constants/colors.dart';
import 'package:todo_app_with_provider/constants/routers.dart';
import 'package:todo_app_with_provider/provider/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: AppColor.primaryColor),
              appBarTheme: const AppBarTheme(color: AppColor.primaryColor),
              primaryColor: AppColor.primaryColor),
          routerConfig: router,
        ));
  }
}
