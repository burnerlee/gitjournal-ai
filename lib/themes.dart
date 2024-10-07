/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'package:flutter/material.dart';

import 'settings/settings.dart';

class Themes {
  static final _light = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ).copyWith(
      primary: const Color(0xFFFFFF00), // Changed to Yellow
      secondary: const Color(0xff000000), // Changed to Black
      onPrimary: Colors.black,
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFF00), // Changed to Yellow
    primaryColorLight: const Color(0xFFFFFFE0), // Light Yellow
    primaryColorDark: const Color(0xFFCCCC00), // Darker Yellow
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xFFCCCC00), // Darker Yellow
      selectionHandleColor: const Color(0xFFFFFF00), // Yellow
      selectionColor: Colors.grey[400],
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
    }),
    useMaterial3: false,
  );

  static final _dark = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xff212121),
      secondary: const Color(0xff689f38),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xff212121),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFF66bb6a),
      selectionHandleColor: Color(0xFF66bb6a),
      selectionColor: Color(0xff689f38),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
    }),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF66bb6a);
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF66bb6a);
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF66bb6a);
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF66bb6a);
        }
        return null;
      }),
    ),
    useMaterial3: false,
  );

  static ThemeData fromName(String name) {
    switch (name) {
      case DEFAULT_LIGHT_THEME_NAME:
        return _light;
      case DEFAULT_DARK_THEME_NAME:
        return _dark;
      default:
        throw Exception("Theme not found - $name");
    }
  }
}
