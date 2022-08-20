import 'package:flutter/material.dart';
import 'package:todo_app/core/presentation/themes/colors/color_set.dart';
import 'package:todo_app/core/presentation/themes/colors/dark_color_set.dart';
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

ThemeData generateThemeFromColorSet(ColorSet colorSet, Brightness brightness) =>
    ThemeData(
      //useMaterial3: true,
      brightness: brightness,
      extensions: [
        AdditionalColors(
            red: colorSet.colorRed,
            blue: colorSet.colorBlue,
            green: colorSet.colorGreen,
            transparentRed: colorSet.colorRed.withOpacity(0.16)),
        AdditionalTextStyles(
            scratchStyle: TextStyle(
                fontFamily: 'Roboto',
                color: colorSet.labelTertiary,
                fontSize: 16,
                height: 1.25,
                decoration: TextDecoration.lineThrough))
      ],
      scaffoldBackgroundColor: colorSet.backPrimary,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colorSet.backPrimary,
        onPrimary: Colors.black,
        secondary: colorSet.colorBlue,
        onSecondary: Colors.white,
        error: colorSet.colorRed,
        onError: Colors.white,
        background: colorSet.backSecondary,
        onBackground: colorSet.labelPrimary,
        surface: colorSet.backSecondary,
        onSurface: colorSet.labelPrimary, //colorSet.backPrimary,
      ),
      shadowColor: Colors.black,
      fontFamily: 'Roboto',
      // TODO add button text theme
      textTheme: TextTheme(
        displayLarge:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        displayMedium:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        displaySmall:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        headlineLarge: TextStyle(
          fontFamily: 'Roboto',
          color: colorSet.labelPrimary,
        ),
        headlineMedium:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        headlineSmall:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        titleLarge: TextStyle(
          fontFamily: 'Roboto',
          color: colorSet.labelPrimary,
          fontSize: 32,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Roboto',
          color: colorSet.labelPrimary,
          fontSize: 16,
          height: 1.25,
          fontWeight: FontWeight.w400,
        ),
        titleSmall: TextStyle(
            fontFamily: 'Roboto',
            color: colorSet.labelTertiary,
            fontSize: 20,
            height: 1.6),
        labelLarge: TextStyle(
            fontFamily: 'Roboto',
            color: colorSet.labelPrimary,
            fontSize: 20,
            height: 1.6),
        labelMedium:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        labelSmall:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelPrimary),
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          color: colorSet.labelPrimary,
          fontSize: 16,
          height: 1.25,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Roboto',
          color: colorSet.labelPrimary,
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        bodySmall:
            TextStyle(fontFamily: 'Roboto', color: colorSet.labelTertiary),
      ),
      cardTheme: CardTheme(
        color: colorSet.backSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      iconTheme: IconThemeData(color: colorSet.labelTertiary),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: colorSet.colorBlue,
          textStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            height: 1.7,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: colorSet.labelPrimary),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: colorSet.colorBlue,
          foregroundColor: colorSet.colorWhite),
      checkboxTheme: CheckboxThemeData(
        checkColor:
            MaterialStateProperty.resolveWith((_) => colorSet.backSecondary),
        fillColor: MaterialStateProperty.resolveWith(
          colorSelectedEnabledDisabled(
            colorSet.colorGreen,
            colorSet.supportSeparator,
            colorSet.colorRed,
          ),
        ),
      ),
    );
const LightColorSet _light = LightColorSet();
const DarkColorSet _dark = DarkColorSet();
final ThemeData lightTheme =
    generateThemeFromColorSet(_light, Brightness.light);
final ThemeData darkTheme = generateThemeFromColorSet(_dark, Brightness.dark);
