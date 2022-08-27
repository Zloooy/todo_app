import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/dependency_injection/global_provider.dart';
import 'package:todo_app/core/presentation/bloc/theme_bloc.dart';
import 'package:todo_app/core/presentation/bloc/theme_state.dart';
import 'package:todo_app/core/presentation/navigation/navigator_service.dart';
import 'package:todo_app/core/presentation/navigation/routes.dart';
import 'package:todo_app/core/presentation/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.loggerName}:\t${record.level.name}\t${record.time}\t${record.message}');
  });
  await LocalTaskDataSource.init();
  await dotenv.load(fileName: 'credentials.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      app: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: NavigatorService.navigatorKey,
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
              routes: Routes.routes,
              initialRoute: Routes.TASK_LIST_ROUTE,
            );
          },
        ),
      ),
    );
  }
}
