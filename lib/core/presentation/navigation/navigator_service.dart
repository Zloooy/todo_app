import 'package:flutter/material.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
import 'package:todo_app/core/presentation/navigation/routes.dart';

abstract class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static Future<void> gotToTaskList() =>
      navigatorKey.currentState!.pushNamed<void>(Routes.TASK_LIST_ROUTE);

  static Future<void> goToEditTask(TaskEntity? task) =>
      navigatorKey.currentState!.pushNamed<void>(Routes.TASK_EDIT_ROUTE);
}
