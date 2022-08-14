import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/dependency_injection/global_provider.dart';
import 'package:todo_app/core/presentation/navigation/navigator_service.dart';
import 'package:todo_app/core/presentation/navigation/routes.dart';
import 'package:todo_app/core/presentation/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      app: MaterialApp(
        navigatorKey: NavigatorService.navigatorKey,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('ru', '')],
        title: 'Flutter Demo',
        theme: lightTheme,
        routes: Routes.routes,
        initialRoute: Routes.TASK_LIST_ROUTE,
      ),
    );
  }
}
