import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/core/presentation/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/task_list/presentation/widgets/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('ru', '')
        ],
        title: 'Flutter Demo',
        theme: lightTheme,
        home: TaskList()
        //const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
