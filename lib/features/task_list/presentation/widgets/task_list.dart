import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';
import 'package:todo_app/features/task_list/data/dto/short_task.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list_item.dart';

import 'task_list_header_delegate.dart';

const List<TaskStatus> statuses = TaskStatus.values;

const List<String> texts = [
  "Купить что-то",
  "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезается"
];

class TaskList extends StatelessWidget {
  TaskList({Key? key}) : super(key: key);
  final List<ShortTask> tasks = texts
      .map((text) => TaskStatus.values
          .map((status) => TaskPriority.values.map((priority) =>
              ShortTask(text: text, status: status, priority: priority)))
          .expand((i) => i))
      .expand((i) => i)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
         SliverPersistentHeader(
          pinned: true,
          delegate: TaskListHeaderDelegate()
         ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverStack(
              insetOnOverlap: false,
              children: [
                const SliverPositioned.fill(child: Card()),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => TaskListItem(task: tasks[i]),
                    childCount: tasks.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){}
      ),
    );
  }
}

