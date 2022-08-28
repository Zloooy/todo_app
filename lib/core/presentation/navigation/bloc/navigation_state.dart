import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.freezed.dart';

@freezed
class NavigationState with _$NavigationState {
  factory NavigationState({required List<TodoRouteInformation> history}) =
      _NavigationState;
}
