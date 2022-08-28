import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_bloc.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/data/data_source/network_task_data_source.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';
import 'package:todo_app/core/dependency_injection/global_provider_dependency_container.dart';
import 'package:todo_app/core/presentation/bloc/theme_bloc.dart';
import 'package:todo_app/core/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information_parsrer.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:uni_links/uni_links.dart';

class GlobalProvider extends StatelessWidget {
  final GlobalProviderDependencyContainer dependencies;
  final Widget app;

  static const String _credentials_asset = 'credentials.env';

  const GlobalProvider({
    required this.app,
    required this.dependencies,
    super.key,
  });

  static Future<GlobalProviderDependencyContainer> initedDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait<Object?>([
      LocalTaskDataSource.init(),
      dotenv.load(fileName: _credentials_asset),
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
    ]);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print(
          '${record.loggerName}:\t${record.level.name}\t${record.time}\t${record.message}');
    });
    String? initialLink = await getInitialLink();
    final informationParser = TodoRouteInformationParser();
    final RouteInformation? toParse = RouteInformation(location: initialLink);
    final TodoRouteInformation? info = (toParse != null)
        ? await informationParser.parseRouteInformation(toParse)
        : null;
    final FirebaseAnalyticsObserver firebaseAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    return GlobalProviderDependencyContainer(
        initialRouteInformation: info,
        routeInformationParser: informationParser,
        firebaseAnalyticsObserver: firebaseAnalyticsObserver);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<TaskRepository>(
              create: (context) => TaskRepository(
                  localTaskDataSource: LocalTaskDataSource(),
                  networkTaskDataSource: NetworkTaskDataSource())),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeBloc(),
            ),
            BlocProvider(
              create: (context) => NavigationBloc(
                initialInformation: dependencies.initialRouteInformation,
                informationParser: dependencies.routeInformationParser,
              ),
            )
          ],
          child: app,
        ));
  }
}
