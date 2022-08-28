import 'package:flutter/widgets.dart';

class TodoRouteInformation extends RouteInformation {
  final bool notFound;
  final bool taskList;
  final String? taskId;
  final String? text;

  TodoRouteInformation.list()
      : notFound = false,
        taskList = true,
        taskId = null,
        text = null;

  TodoRouteInformation.task({required String? id, String? this.text})
      : taskList = false,
        notFound = false,
        taskId = id;

  TodoRouteInformation.notFound()
      : notFound = true,
        taskList = false,
        taskId = null,
        text = null;
}
