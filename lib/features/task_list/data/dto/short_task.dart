enum TaskStatus { created, overdue, done }

enum TaskPriority {
  low(
    true,
  ),
  high(
    true,
  ),
  undefined(
    false,
  );

  const TaskPriority(
    this.show,
  );
  final bool show;
}

class ShortTask {
  final TaskStatus status;
  final TaskPriority priority;
  final String text;
  const ShortTask({
    required this.status,
    required this.priority,
    required this.text,
  });
}
