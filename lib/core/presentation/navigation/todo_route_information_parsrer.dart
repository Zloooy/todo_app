import 'package:flutter/material.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:uuid/uuid.dart';

class TodoRouteInformationParser
    extends RouteInformationParser<TodoRouteInformation> {
  static const String _tasksPath = 'tasks';
  static const String _notFoundPath = '404';
  static const String _newPathSegment = 'new';
  static const String _textQueryParam = 'text';

  @override
  Future<TodoRouteInformation> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.length < 3) {
      if (uri.pathSegments.isEmpty || uri.pathSegments[0] == _tasksPath) {
        if (uri.pathSegments.length < 2) {
          return Future.value(TodoRouteInformation.list());
        }
        if (Uuid.isValidUUID(fromString: uri.pathSegments[1])) {
          return Future.value(
              TodoRouteInformation.task(id: uri.pathSegments[1]));
        } else if (uri.pathSegments[1] == _newPathSegment) {
          return Future.value(TodoRouteInformation.task(
              id: null, text: uri.queryParameters[_textQueryParam] ?? ''));
        }
      }
    }
    return Future.value(TodoRouteInformation.notFound());
  }

  @override
  RouteInformation? restoreRouteInformation(
      TodoRouteInformation configuration) {
    RouteInformation result;
    if (configuration.taskList) {
      result = RouteInformation(location: '/$_tasksPath');
    } else {
      if (configuration.notFound) {
        result = RouteInformation(location: '/$_notFoundPath');
      } else {
        if (configuration.taskId == null) {
          result = RouteInformation(
              location:
                  '/$_tasksPath/$_newPathSegment?$_textQueryParam=${configuration.text ?? ''}');
        } else {
          result = RouteInformation(
              location: '/$_tasksPath/${configuration.taskId}');
        }
      }
    }
    return result;
  }
}
