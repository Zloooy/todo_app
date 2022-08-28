import 'dart:async';
import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/presentation/navigation/bloc/navigation_state.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information_parsrer.dart';
import 'package:uni_links/uni_links.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final TodoRouteInformationParser informationParser;
  late final StreamSubscription<Uri?>? uriLinkSubscription;

  NavigationBloc(
      {TodoRouteInformation? initialInformation,
      required this.informationParser})
      : super(NavigationState(
            history: constructDeepLinkHistory(initialInformation))) {
    on<PopEvent>(onPop);
    on<OpenTaskEvent>(onOpenTask);
    on<DeepLinkEvent>(onDeepLink);
    on<NotFoundEvent>(onNotFound);
    // IOS is not supported yet
    if (Platform.isAndroid) {
      uriLinkSubscription = uriLinkStream.listen(this.handleDeepLinkUri);
    }
  }

  Future<void> onPop(PopEvent event, Emitter<NavigationState> emit) async {
    if (state.history.length != 1) {
      emit(state.copyWith(
          history: state.history.sublist(0, state.history.length - 1)));
    }
  }

  Future<void> onOpenTask(
      OpenTaskEvent event, Emitter<NavigationState> emit) async {
    final newHistory = [
      ...state.history,
      TodoRouteInformation.task(id: event.id),
    ];
    emit(state.copyWith(history: newHistory));
  }

  Future<void> onDeepLink(
      DeepLinkEvent event, Emitter<NavigationState> emit) async {
    TodoRouteInformation todoInfo =
        await informationParser.parseRouteInformation(event.information);
    emit(state.copyWith(
      history: constructDeepLinkHistory(todoInfo),
    ));
  }

  @override
  Future<void> close() async {
    uriLinkSubscription?.cancel();
    super.close();
  }

  static List<TodoRouteInformation> constructDeepLinkHistory(
      TodoRouteInformation? deepLink) {
    return [
      if (!(deepLink?.taskList ?? true)) TodoRouteInformation.list(),
      deepLink ?? TodoRouteInformation.list()
    ];
  }

  void handleDeepLinkUri(Uri? uri) {
    final RouteInformation toParse =
        RouteInformation(location: uri?.toString());
    this.add(DeepLinkEvent(
      information: toParse,
    ));
  }

  Future<void> onNotFound(
      NotFoundEvent event, Emitter<NavigationState> emit) async {
    emit(state.copyWith(
        history: constructDeepLinkHistory(TodoRouteInformation.notFound())));
  }
}
