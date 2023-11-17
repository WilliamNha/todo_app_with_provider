import 'package:go_router/go_router.dart';
import 'package:todo_app_with_provider/screens/create_task_screen.dart';
import 'package:todo_app_with_provider/screens/home_screen.dart';
import 'package:todo_app_with_provider/screens/update_task_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/create_task',
      builder: (context, state) => const CreateTaskScreen(),
    ),
    GoRoute(
        path: '/update_task',
        builder: (context, state) {
          final extra = state.extra as String;
          return UpdateTaskScreen(
            taskID: extra,
          );
        }),
  ],
);
