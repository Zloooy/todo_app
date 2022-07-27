import 'package:flutter/material.dart';

import 'colors/light_color_set.dart';
import 'extensions/additional_colors.dart';
import 'extensions/blue_icon_theme.dart';
import 'extensions/red_checkbox_theme.dart';

MaterialPropertyResolver<Color> colorSelectedEnabledDisabled(
        Color onSelected, Color onEnabled, Color onDisabled) =>
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return onSelected;
      }
      if (!states.contains(MaterialState.disabled)) {
        return onEnabled;
      } else {
        return onDisabled;
      }
    };

const LightColorSet _light = LightColorSet();
final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    extensions: [
      AdditionalColors(red: _light.colorRed, blue: _light.colorBlue, green: _light.colorGreen),
      RedCheckboxTheme(
          theme: ThemeData(
              unselectedWidgetColor: _light.colorBlue,
              toggleableActiveColor: _light.colorBlue,
              disabledColor: _light.colorBlue,
              checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.resolveWith(
                      (_) => _light.colorRed)))),
      BlueIconTheme(theme: IconThemeData(color: _light.colorBlue))
    ],
    scaffoldBackgroundColor: _light.backPrimary,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: _light.backPrimary,
      onPrimary: Colors.black,
      secondary: _light.colorBlue,
      onSecondary: Colors.white,
      error: _light.colorRed,
      onError: Colors.white,
      background: _light.backSecondary,
      onBackground: _light.labelPrimary,
      surface: _light.backSecondary,
      onSurface: _light.backPrimary,
    ),
    fontFamily: 'Roboto',
    // TODO add button text theme
    textTheme: TextTheme(
      displayLarge: TextStyle(color: _light.labelPrimary),
      displayMedium: TextStyle(color: _light.labelPrimary),
      displaySmall: TextStyle(color: _light.labelPrimary),
      headlineLarge: TextStyle(
        color: _light.labelPrimary,
        ),
      headlineMedium: TextStyle(color: _light.labelPrimary),
      headlineSmall: TextStyle(color: _light.labelPrimary),
      titleLarge: TextStyle(
        color: _light.labelPrimary,
        fontSize: 32,
        height: 1.2,
        fontWeight: FontWeight.w500
        ),
      titleMedium: TextStyle(
        color: _light.labelPrimary,
        fontSize: 16,
        height: 1.25,
        fontWeight: FontWeight.w400
        ),
      titleSmall: TextStyle(
        color: _light.labelTertiary,
        fontSize: 20,
        height: 1.6
        ),
      labelLarge: TextStyle(
        color: _light.labelPrimary,
        fontSize: 20,
        height: 1.6
        ),
      labelMedium: TextStyle(color: _light.labelPrimary),
      labelSmall: TextStyle(color: _light.labelPrimary),
      bodyLarge: TextStyle(
        color: _light.labelPrimary,
        fontSize: 16,
        height: 1.25,
        fontWeight: FontWeight.w400
        ),
      bodyMedium: TextStyle(
        color: _light.labelPrimary,
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w400
        ),
      bodySmall: TextStyle(color: _light.labelTertiary),
    ),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    iconTheme: IconThemeData(color: _light.labelTertiary),
    checkboxTheme: CheckboxThemeData(
        checkColor:
            MaterialStateProperty.resolveWith((_) => _light.backSecondary),
        fillColor: MaterialStateProperty.resolveWith(
            colorSelectedEnabledDisabled(
                _light.colorGreen, _light.supportSeparator, _light.colorRed))));
