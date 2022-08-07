import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';

part 'single_task_network_response_dto.freezed.dart';
part 'single_task_network_response_dto.g.dart';

@freezed
class SingleTaskNetworkResponseDto with _$SingleTaskNetworkResponseDto {
  factory SingleTaskNetworkResponseDto({
    required TaskDto element,
    @Default('ok') String status,
    int? revision,
  }) = _SingleTaskNetworkResponseDto;

  factory SingleTaskNetworkResponseDto.fromJson(Map<String, Object?> json) =>
      _$SingleTaskNetworkResponseDtoFromJson(json);
}
