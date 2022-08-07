import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/data/data_source/network_task_data_source.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    required this.app,
    super.key,
  });

  final Widget app;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TaskRepository>(
            create: (context) => TaskRepository(
                localTaskDataSource: LocalTaskDataSource(),
                networkTaskDataSource: NetworkTaskDataSource())),
      ],
      child: app,
    );
  }
}
