import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information_parsrer.dart';

part 'global_provider_dependency_container.freezed.dart';

@freezed
class GlobalProviderDependencyContainer
    with _$GlobalProviderDependencyContainer {
  factory GlobalProviderDependencyContainer({
    required TodoRouteInformation? initialRouteInformation,
    required TodoRouteInformationParser routeInformationParser,
    required FirebaseAnalyticsObserver firebaseAnalyticsObserver,
  }) = _GlobalProviderDependencyContainer;
}
