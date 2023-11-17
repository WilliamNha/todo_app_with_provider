import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_with_provider/constants/colors.dart';

class CustomTaskWidget extends StatefulWidget {
  final Function? onTaskToogle;
  final bool isTaskDone;
  final Function(String)? onDeleteTap;
  final String id;
  final String taskName;
  final String time;
  final String taskNumber;

  final GestureTapCallback? onTab;

  const CustomTaskWidget({
    this.onTaskToogle,
    this.isTaskDone = false,
    this.onDeleteTap,
    required this.taskNumber,
    required this.id,
    required this.taskName,
    required this.time,
    this.onTab,
    super.key,
  });

  @override
  State<CustomTaskWidget> createState() => _CustomTaskWidgetState();
}

class _CustomTaskWidgetState extends State<CustomTaskWidget> {
  bool isCompleted = false;
  @override
  void initState() {
    isCompleted = widget.isTaskDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTab,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                widget.onDeleteTap!(widget.id);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 1)
          ], color: Colors.white, borderRadius: BorderRadius.circular(14)),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor, width: 2)),
                child: Center(
                  child: Text(
                    widget.taskNumber,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.red),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.time,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.red),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      isCompleted = value!;
                    });
                    widget.onTaskToogle!();
                  },
                  value: isCompleted,
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return isCompleted == true
                          ? AppColor.green
                          : AppColor.green.withOpacity(0.40);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
