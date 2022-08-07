import 'package:boxy/slivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';
import 'package:todo_app/core/presentation/navigation/route_mapper.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_state.dart';
import 'package:todo_app/features/task_list/presentation/widgets/new_item.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list_header_delegate.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list_item.dart';

class TaskList extends StatelessWidget {
  TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TaskListBloc(RepositoryProvider.of<TaskRepository>(context)),
        child: BlocBuilder<TaskListBloc, TaskListState>(
            builder: (context, state) => Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: TaskListHeaderDelegate(
                          doneCount: state.doneCount,
                          showDone: state.showDone,
                          onSwitchShowDone: () =>
                              BlocProvider.of<TaskListBloc>(context)
                                  .add(SwitchDoneTaskVisibilityEvent()),
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
                                                BlocProvider.of<TaskListBloc>(
                                                        context)
                                                    .add(ChangeTaskDoneEvent(
                                                        task: state.tasks[i],
                                                        done: done)),
                                            onDelete: () =>
                                                BlocProvider.of<TaskListBloc>(
                                                        context)
                                                    .add(DeleteTaskEvent(
                                                        state.tasks[i])),
                                            onInfoClick: () async {
                                              await RouteMapper.goToEditTask(
                                                  state.tasks[i], context);
                                              BlocProvider.of<TaskListBloc>(
                                                      context)
                                                  .add(ReloadTaskListEvent());
                                            },
                                            task: state.tasks[i])
                                        : AddTask(
                                            onInputEnd: (text) =>
                                                BlocProvider.of<TaskListBloc>(
                                                        context)
                                                    .add(CreateTaskEvent(text)),
                                          ),
                                    childCount: state.tasks.length + 1,
                                  ),
                                )
                              : const SliverFillRemaining(
                                  child: Center(
                                      child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator()))),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        await RouteMapper.goToEditTask(null, context);
                        BlocProvider.of<TaskListBloc>(context)
                            .add(ReloadTaskListEvent());
                      }),
                )));
  }
}