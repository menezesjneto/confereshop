import 'package:flutter/material.dart';

class CustomsColors {

  static final MaterialColor customBlueI = const MaterialColor(
    0xFF04c3bc,
    const <int, Color>{
      50: const Color(0xFF04c3bc),
      100: const Color(0xFF04c3bc),
      200: const Color(0xFF04c3bc),
      300: const Color(0xFF04c3bc),
      400: const Color(0xFF04c3bc),
      500: const Color(0xFF04c3bc),
      600: const Color(0xFF04c3bc),
      700: const Color(0xFF04c3bc),
      800: const Color(0xFF04c3bc),
      900: const Color(0xFF04c3bc),
    },
  );

  static final MaterialColor customBlueII = const MaterialColor(
    0xFF04eebc,
    const <int, Color>{
      50: const Color(0xFF04eebc),
      100: const Color(0xFF04eebc),
      200: const Color(0xFF04eebc),
      300: const Color(0xFF04eebc),
      400: const Color(0xFF04eebc),
      500: const Color(0xFF04eebc),
      600: const Color(0xFF04eebc),
      700: const Color(0xFF04eebc),
      800: const Color(0xFF04eebc),
      900: const Color(0xFF04eebc),
    },
  );

  static final MaterialColor customBlueIII = const MaterialColor(
    0xFF049be1,
    const <int, Color>{
      50: const Color(0xFF049be1),
      100: const Color(0xFF049be1),
      200: const Color(0xFF049be1),
      300: const Color(0xFF049be1),
      400: const Color(0xFF049be1),
      500: const Color(0xFF049be1),
      600: const Color(0xFF049be1),
      700: const Color(0xFF049be1),
      800: const Color(0xFF049be1),
      900: const Color(0xFF049be1),
    },
  );

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    return ('#'+
  //    '${color.alpha.toRadixString(16).padLeft(2, '0')}'+
      '${color.red.toRadixString(16).padLeft(2, '0')}'+
      '${color.green.toRadixString(16).padLeft(2, '0')}'+
      '${color.blue.toRadixString(16).padLeft(2, '0')}').toUpperCase();
  }
}
