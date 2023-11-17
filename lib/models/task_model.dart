class TaskModel {
  String? sId;
  String? task;
  String? time;
  bool? isDone;

  TaskModel({this.sId, this.task, this.time, this.isDone});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    task = json['task'];
    time = json['time'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['task'] = task;
    data['time'] = time;
    data['isDone'] = isDone;
    return data;
  }
}
