import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/constants/colors.dart';
import 'package:todo_app_with_provider/provider/task_provider.dart';
import 'package:todo_app_with_provider/widgets/custom_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      await taskProvider.getAllTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              context.push('/create_task');
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Todo Tasks",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<TaskProvider>(builder: (_, taskProvider, __) {
          return taskProvider.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (taskProvider.taskList != null)
                          if (taskProvider.taskList!.isNotEmpty)
                            for (var task in taskProvider.taskList!)
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: task == taskProvider.taskList!.last
                                        ? 20
                                        : 0),
                                child: CustomTaskWidget(
                                  isTaskDone: task.isDone!,
                                  onTaskToogle: () async {
                                    taskProvider.toogleTaskDone(id: task.sId!);
                                  },
                                  onDeleteTap: (id) async {
                                    await taskProvider.deleteTask(taskID: id);
                                    await taskProvider.getAllTask();
                                  },
                                  id: task.sId!,
                                  taskNumber:
                                      "${taskProvider.taskList!.indexOf(task) + 1}",
                                  taskName: task.task!,
                                  time: task.time!,
                                  onTab: () {
                                    context.push('/update_task',
                                        extra: task.sId);
                                  },
                                ),
                              )
                          else
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(
                                child: Text(
                                  "Task is empty",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            )
                        else
                          const Center(
                            child: Text("Something went wrong"),
                          )
                      ]),
                );
        }));
  }
}
