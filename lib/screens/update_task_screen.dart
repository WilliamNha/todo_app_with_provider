import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/models/task_model.dart';
import 'package:todo_app_with_provider/provider/task_provider.dart';
import 'package:todo_app_with_provider/utils/datetime_to_string_converter.dart';
import 'package:todo_app_with_provider/widgets/custom_button.dart';
import 'package:todo_app_with_provider/widgets/custom_textfield.dart';

class UpdateTaskScreen extends StatefulWidget {
  final String taskID;
  const UpdateTaskScreen({super.key, required this.taskID});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final taskController = TextEditingController();
  String taskText = '';
  String selectedTime = "Click here to select time";
  TaskModel? taskData;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskData = await taskProvider.getTaskByID(id: widget.taskID);
      taskText = taskData!.task!;
      taskController.text = taskText;
      selectedTime = taskData!.time!;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Update Task')),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return taskProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Task",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextFormFiled(
                                    controller: taskController,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          taskText = value;
                                        });
                                      } else {
                                        setState(() {
                                          taskText = '';
                                        });
                                      }
                                    },
                                    hintText: "What do you plan to do?",
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "Select time",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      DatePicker.showTimePicker(context,
                                          showTitleActions: true,
                                          showSecondsColumn: false,
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        setState(() {
                                          selectedTime =
                                              DateTimeToStringConverter
                                                  .convertStrinToDateTime(date);
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: Text(
                                      selectedTime,
                                      style: const TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  buttonText: "Save",
                                  onPressed: taskData != null
                                      ? (taskData!.task == taskText &&
                                              taskData!.time == selectedTime)
                                          ? null
                                          : taskText == ""
                                              ? null
                                              : () async {
                                                  await taskProvider.updateTask(
                                                      id: widget.taskID,
                                                      task: taskText,
                                                      time: selectedTime);
                                                  context.pop();
                                                  await taskProvider
                                                      .getAllTask();
                                                }
                                      : null,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
