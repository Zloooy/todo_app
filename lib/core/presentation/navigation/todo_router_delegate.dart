import 'dart:async';

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:todo_app/features/not_found/presentation/not_found.dart';
import 'package:todo_app/features/task_edit/presentation/widgets/task_edit.dart';
import 'package:todo_app/features/task_list/presentation/widgets/task_list.dart';
import 'package:todo_app/core/presentation/navigation/bloc/navigation_state.dart';

final Logger _log = Logger('TodoRouterDelegate');

class TodoRouterDelegate extends RouterDelegate<TodoRouteInformation>
    with PopNavigatorRouterDelegateMixin<TodoRouteInformation>, ChangeNotifier {
  final GlobalKey<NavigatorState> _navigatorKey;
  final NavigationBloc _bloc;
  final FirebaseAnalyticsObserver _analyticsObserver;
  final StreamController<Null> _popController;

  TodoRouterDelegate({required NavigationBloc bloc, required FirebaseAnalyticsObserver analyticsObserver})
      : _bloc = bloc,
        _navigatorKey = GlobalKey(),
        _analyticsObserver = analyticsObserver,
       _popController = new StreamController<Null>.broadcast();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Navigator(
                key: _navigatorKey,
                observers: [_analyticsObserver],
                pages: state.history.map(_buildPageByRouteInformation).toList(),
                onPopPage: _onPopPage,
              );
              }
              );
    

  bool _onPopPage(Route<Object?> route, Object? result) {
    if (!route.didPop(result)) {
      return false;
    }
    _popController.add(null);
    _bloc.add(PopEvent());
    return true;
  }


  Page<Object?> _buildPageByRouteInformation(
      TodoRouteInformation information) {
    _log.info('building page by information $information');
    if (information.taskList) {
      return MaterialPage(
        name: '/tasks/',
        child: TaskList(
        openTask: (String? taskId) async {
          _bloc.add(OpenTaskEvent(taskId));
           await _popController.stream.first;
          }
      ));
    }
    if (information.notFound) {
      return MaterialPage(
        name: '/404/',
        child: NotFound()
        );
    }
    return MaterialPage(
        name: '/tasks/{id}',
        child: TaskEdit(id: information.taskId, text: information.text,
        notFound: ()=>_bloc.add(NotFoundEvent()),
        ));
  }

  @override
  TodoRouteInformation? get currentConfiguration => _bloc.state.history.last;

  @override
  Future<void> setNewRoutePath(TodoRouteInformation information) async {
  }

}
