import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';

void main() {
  group("TaskDto conversion", () {
    test('Create TaskDto from JSON and convert it back', () {
      final json = {
        "id": "d642c639-86a6-4844-9972-5ca079f50761",
        "last_updated_by": "0",
        "created_at": 1660764846317,
        "changed_at": 1660764846318,
        "deadline": 1660764846319,
        "importance": "basic",
        "done": false,
        "color": "#ffffffff",
        "text": "test text",
      };
      final task = TaskDto.fromJson(json);
      expect(task.toJson(), json);
    });
    test('Create TaskDto from TaskEntity and convert it back', () {
      final taskEntity = TaskEntity.blank();
      final createdAt = DateTime.now();
      final changedAt = DateTime.fromMillisecondsSinceEpoch(
          createdAt.millisecondsSinceEpoch + 1);
      final lastUpdatedBy = '0';
      final taskDto = TaskDto.fromEntity(
        entity: taskEntity,
        createdAt: createdAt,
        changedAt: changedAt,
        lastUpdatedBy: lastUpdatedBy,
      );
      expect(TaskEntity.fromDto(taskDto), taskEntity);
    });
  });
}
