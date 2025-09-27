import 'package:flutter/material.dart';

import '../../utils/config/styles/colors.dart';

class AppTheme {
  static final ThemeData calendarDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF000000), // Pure black background
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0A84FF), // A brighter blue for dark mode contrast
      secondary: Color(0xFF64D2FF), // Lighter blue for ranges
      onPrimary: Colors.white, // Text color on primary color
      surface: Color(0xFF1C1C1E), // Dark grey for calendar background
      onSurface: Color(0xFFF2F2F7), // Default text color (off-white)
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF8E8E93)), // Weekday text (grey)
      bodyMedium: TextStyle(color: Color(0xFFE5E5EA)), // Date text
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white, // Month/Year title
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF0A84FF), // Chevron icons for changing months
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF38383A), // Separator line color
      thickness: 1,
    ),
  );

  static final ThemeData calendarDarkThemeDark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF000000), // Pure black background
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0A84FF), // A brighter blue for dark mode contrast
      secondary: Color(0xFF64D2FF), // Lighter blue for ranges
      onPrimary: Colors.white, // Text color on primary color
      surface: Color(0xFF1C1C1E), // Dark grey for calendar background
      onSurface: Color(0xFFF2F2F7), // Default text color (off-white)
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF8E8E93)), // Weekday text (grey)
      bodyMedium: TextStyle(color: Color(0xFFE5E5EA)), // Date text
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white, // Month/Year title
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF0A84FF), // Chevron icons for changing months
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF38383A), // Separator line color
      thickness: 1,
    ),
  );
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(true),
      thickness: WidgetStateProperty.all(8.0),
      thumbColor: WidgetStateProperty.all(Colors.black.withOpacity(0.2)),
    ),
    useMaterial3: false,
    dataTableTheme: DataTableThemeData(
      headingTextStyle: _headTxtStyle,
      dataRowColor: WidgetStateProperty.all(Colors.white),
      dataTextStyle: _tableRowTxtStyle,
      dividerThickness: 0,
      headingRowColor:
          const MaterialStatePropertyAll(AppColor.drawerImgTileColor),
      headingRowHeight: 30,
      dataRowHeight: 30,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(true),
      thickness: WidgetStateProperty.all(8.0),
      thumbColor: WidgetStateProperty.all(Colors.red),
    ),
    useMaterial3: false,
    dataTableTheme: DataTableThemeData(
      headingTextStyle: _headTxtStyle,
      dataRowColor: WidgetStateProperty.all(Colors.black87),
      dataTextStyle: _tableRowTxtStyle.copyWith(color: Colors.white),
      dividerThickness: 0,
      headingRowColor:
          const WidgetStatePropertyAll(AppColor.drawerImgTileColor),
      headingRowHeight: 30,
      dataRowHeight: 30,
    ),
  );
}

const _headTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.primaryColor,
);

const _tableRowTxtStyle = TextStyle(
  fontFamily: 'poppinsRegular',
  fontSize: 10,
  color: AppColor.cardTitleSubColor,
);
