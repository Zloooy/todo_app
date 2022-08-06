import 'package:flutter/material.dart';
import 'package:todo_app/features/task_edit/presentation/widgets/task_edit.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list.dart';

abstract class Routes {
  static const String TASK_LIST_ROUTE = '/tasks';
  static const String TASK_EDIT_ROUTE = '/tasks/edit';
  static final Map<String, WidgetBuilder> routes = {
    TASK_LIST_ROUTE: (_) => TaskList(),
    TASK_EDIT_ROUTE: (_) => TaskEdit()
  };
}
