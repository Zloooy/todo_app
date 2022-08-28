import 'package:boxy/slivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/data/enum/network_state.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';
import 'package:todo_app/core/presentation/bloc/theme_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_state.dart';
import 'package:todo_app/features/task_list/presentation/widgets/add_task.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list_header_delegate.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list_item.dart';
import 'package:todo_app/core/presentation/bloc/theme_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskList extends StatelessWidget {
  final Future<void> Function(String?) openTask;

  TaskList({required this.openTask, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TaskListBloc(RepositoryProvider.of<TaskRepository>(context)),
        child: BlocConsumer<TaskListBloc, TaskListState>(
            listener: (context, state) {
              if (state.showNotification &&
                  state.operationResult != NetworkState.SUCCESS) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _networkStateMessage(context, state.operationResult),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) => Scaffold(
                  body: BlocListener<ThemeBloc, ThemeState>(
                    listener: (context, state) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _switchThemeMessage(context, state.mode),
                          ),
                        ),
                      );
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: CustomScrollView(
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: TaskListHeaderDelegate(
                              doneCount: state.doneCount,
                              showDone: state.showDone,
                              onSwitchShowDone: () =>
                                  BlocProvider.of<TaskListBloc>(context)
                                      .add(SwitchDoneTaskVisibilityEvent()),
                              onSwitchTheme: () =>
                                  BlocProvider.of<ThemeBloc>(context).add(
                                SwitchThemeEvent(),
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8),
                            sliver: SliverCard(
                              clipBehavior: Clip.antiAlias,
                              sliver: state.loaded
                                  ? SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, i) => (i < state.tasks.length)
                                            ? TaskListItem(
                                                onChangeDone: (done) =>
                                                    BlocProvider.of<
                                                        TaskListBloc>(
                                                  context,
                                                ).add(
                                                  ChangeTaskDoneEvent(
                                                    task: state.tasks[i],
                                                    done: done,
                                                  ),
                                                ),
                                                onDelete: () => BlocProvider.of<
                                                        TaskListBloc>(context)
                                                    .add(
                                                  DeleteTaskEvent(
                                                    state.tasks[i],
                                                  ),
                                                ),
                                                task: state.tasks[i],
                                                onInfoClick: () async {
                                                  await openTask(
                                                      state.tasks[i].id);
                                                  BlocProvider.of<TaskListBloc>(
                                                    context,
                                                  ).add(
                                                    ReloadTaskListEvent(),
                                                  );
                                                },
                                              )
                                            : AddTask(),
                                        childCount: state.tasks.length + 1,
                                      ),
                                    )
                                  : const SliverFillRemaining(
                                      child: Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      await openTask(null);
                      BlocProvider.of<TaskListBloc>(context)
                          .add(ReloadTaskListEvent());
                    },
                  ),
                )));
  }

  String _switchThemeMessage(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case (ThemeMode.dark):
        return AppLocalizations.of(context)!.switchedToDarkTheme;
      case (ThemeMode.light):
        return AppLocalizations.of(context)!.switchedToLightTheme;
      case (ThemeMode.system):
        return AppLocalizations.of(context)!.switchedToSystemTheme;
    }
  }

  String _networkStateMessage(BuildContext context, NetworkState networkState) {
    switch (networkState) {
      case NetworkState.NOT_FOUND:
        return AppLocalizations.of(context)!.addressNotFound;
      case NetworkState.NO_CONNECTION:
        return AppLocalizations.of(context)!.noConnection;
      case NetworkState.UNKNOWN_ERROR:
        return AppLocalizations.of(context)!.unknownError;
      case NetworkState.UNAUTHORIZED:
        return AppLocalizations.of(context)!.noAuthorization;
      case NetworkState.WRONG_REVISION:
        return AppLocalizations.of(context)!.revisionError;
      case NetworkState.SUCCESS:
        return "";
    }
  }
}
