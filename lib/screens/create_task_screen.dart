import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/provider/task_provider.dart';
import 'package:todo_app_with_provider/utils/datetime_to_string_converter.dart';
import 'package:todo_app_with_provider/widgets/custom_button.dart';
import 'package:todo_app_with_provider/widgets/custom_textfield.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final taskController = TextEditingController();
  String taskText = '';
  String selectedTime = "Click here to select time";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Create task')),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return GestureDetector(
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
                              Text(
                                "*",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextFormFiled(
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
                              Text(
                                "*",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    selectedTime = DateTimeToStringConverter
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
                            onPressed: taskText == "" ||
                                    selectedTime == "Click here to select time"
                                ? null
                                : () async {
                                    await taskProvider
                                        .createTask(
                                            task: taskText, time: selectedTime)
                                        .then((value) async {
                                      context.pop();
                                      await taskProvider.getAllTask();
                                    });
                                  },
                          ),
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
