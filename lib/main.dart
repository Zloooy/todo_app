import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/dependency_injection/global_provider.dart';
import 'package:todo_app/core/presentation/bloc/theme_bloc.dart';
import 'package:todo_app/core/presentation/bloc/theme_state.dart';
import 'package:todo_app/core/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information.dart';
import 'package:todo_app/core/presentation/navigation/todo_route_information_parsrer.dart';
import 'package:todo_app/core/presentation/navigation/todo_router_delegate.dart';
import 'package:todo_app/core/presentation/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.loggerName}:\t${record.level.name}\t${record.time}\t${record.message}');
  });
  await LocalTaskDataSource.init();
  await dotenv.load(fileName: 'credentials.env');
  String? initialLink = await getInitialLink();
  final informationParser = TodoRouteInformationParser();
  final RouteInformation? toParse = RouteInformation(location: initialLink);
  final TodoRouteInformation? info = (toParse != null) ? await informationParser.parseRouteInformation(toParse) : null;
  runApp(TodoApp(initialInformation: info, informationParser: informationParser));
}

class TodoApp extends StatelessWidget {
  final TodoRouteInformation? initialInformation;
  final TodoRouteInformationParser informationParser;

  TodoApp({required this.initialInformation, required this.informationParser, super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      app: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(initialInformation: initialInformation, informationParser: informationParser),
          )
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              supportedLocales: const [Locale('ru', '')],
              title: 'Done',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: state.mode,
                routerDelegate: TodoRouterDelegate(
                  bloc: BlocProvider.of<NavigationBloc>(context),
                  ),
              routeInformationParser: informationParser,
            );
          },
        ),
      ),
    );
  }
}
