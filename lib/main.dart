import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/core/dependency_injection/global_provider.dart';
import 'package:todo_app/core/dependency_injection/global_provider_dependency_container.dart';
import 'package:todo_app/core/presentation/bloc/theme_bloc.dart';
import 'package:todo_app/core/presentation/bloc/theme_state.dart';
import 'package:todo_app/core/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:todo_app/core/presentation/navigation/todo_router_delegate.dart';
import 'package:todo_app/core/presentation/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: unused_element
const _kShouldTestAsyncErrorOnInit = false;
// ignore: unused_element
const _kTestingCrashlytics = true;
void main() {
  runZonedGuarded(() async {
    GlobalProviderDependencyContainer dependencies =
        await GlobalProvider.initedDependencies();
    runApp(TodoApp(
      dependencies: dependencies,
    ));
  }, ((error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  }));
}

class TodoApp extends StatelessWidget {
  final GlobalProviderDependencyContainer dependencies;

  TodoApp({required this.dependencies, super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      dependencies: dependencies,
      app: BlocBuilder<ThemeBloc, ThemeState>(
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
              analyticsObserver: dependencies.firebaseAnalyticsObserver,
            ),
            routeInformationParser: dependencies.routeInformationParser,
          );
        },
      ),
    );
  }
}
