import 'package:flutter/material.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_text_styles.dart';

import 'colors/light_color_set.dart';
import 'extensions/additional_colors.dart';

MaterialPropertyResolver<Color> colorSelectedEnabledDisabled(
  Color onSelected,
  Color onEnabled,
  Color onDisabled,
) =>
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
    AdditionalColors(
        red: _light.colorRed,
        blue: _light.colorBlue,
        green: _light.colorGreen,
        transparentRed: _light.colorRed.withOpacity(0.16)),
    AdditionalTextStyles(
        scratchStyle: TextStyle(
            fontFamily: 'Roboto',
            color: _light.labelTertiary,
            fontSize: 16,
            height: 1.25,
            decoration: TextDecoration.lineThrough))
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
    onSurface: _light.labelPrimary, //_light.backPrimary,
  ),
  fontFamily: 'Roboto',
  // TODO add button text theme
  textTheme: TextTheme(
    displayLarge: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    displayMedium: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    displaySmall: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    headlineLarge: TextStyle(
      fontFamily: 'Roboto',
      color: _light.labelPrimary,
    ),
    headlineMedium: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    headlineSmall: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      color: _light.labelPrimary,
      fontSize: 32,
      height: 1.2,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      color: _light.labelPrimary,
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
        fontFamily: 'Roboto',
        color: _light.labelTertiary,
        fontSize: 20,
        height: 1.6),
    labelLarge: TextStyle(
        fontFamily: 'Roboto',
        color: _light.labelPrimary,
        fontSize: 20,
        height: 1.6),
    labelMedium: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    labelSmall: TextStyle(fontFamily: 'Roboto', color: _light.labelPrimary),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      color: _light.labelPrimary,
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      color: _light.labelPrimary,
      fontSize: 14,
      height: 1.4,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(fontFamily: 'Roboto', color: _light.labelTertiary),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  iconTheme: IconThemeData(color: _light.labelTertiary),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: _light.colorBlue,
      textStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        height: 1.7,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.resolveWith((_) => _light.backSecondary),
    fillColor: MaterialStateProperty.resolveWith(
      colorSelectedEnabledDisabled(
        _light.colorGreen,
        _light.supportSeparator,
        _light.colorRed,
      ),
    ),
  ),
);
