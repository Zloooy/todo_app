import 'package:flutter/material.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
import 'package:todo_app/core/presentation/navigation/routes.dart';

abstract class RouteMapper {
  static Future<dynamic> goToTaskList(BuildContext context) =>
      Navigator.of(context).pushNamed(Routes.TASK_LIST_ROUTE);

  static Future<dynamic> goToEditTask(TaskEntity? task, BuildContext context) {
    return Navigator.of(context)
        .pushNamed(Routes.TASK_EDIT_ROUTE, arguments: task?.id);
  }
}
