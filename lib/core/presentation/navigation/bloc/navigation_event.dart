part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {
  const NavigationEvent();
}

class PopEvent extends NavigationEvent {
  const PopEvent();
}

class OpenTaskEvent extends NavigationEvent {
  final String? id;
  const OpenTaskEvent(this.id);
}

class DeepLinkEvent extends NavigationEvent {
  final RouteInformation information;
  DeepLinkEvent({required this.information});
}

class NotFoundEvent extends NavigationEvent {
  const NotFoundEvent();
}
