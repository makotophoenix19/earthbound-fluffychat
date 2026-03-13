import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/config/app_config.dart';

/// Earthbound-inspired color palette (Memphis Design)
class EarthboundColors {
  // Core palette
  static const Color background = Color(0xFFFCEEB4);      // Warm cream
  static const Color backgroundDark = Color(0xFF2D2A1F);  // Dark cream
  static const Color primary = Color(0xFFFF6B35);          // Orange (CTB text boxes)
  static const Color primaryDark = Color(0xFFE55A2B);      // Darker orange
  static const Color secondary = Color(0xFFFF9EAA);        // Bubblegum pink
  static const Color tertiary = Color(0xFF64B5F6);         // Sky blue (sent messages)
  static const Color accent = Color(0xFF7CB342);           // Kelly green
  static const Color star = Color(0xFFFFD93D);             // Golden yellow
  static const Color textPrimary = Color(0xFF4A3728);      // Dark brown
  static const Color textSecondary = Color(0xFF6B5344);    // Lighter brown
  static const Color purple = Color(0xFFBA68C8);           // Purple accent
  
  // Dark mode variants
  static const Color darkSurface = Color(0xFF3D362A);
  static const Color darkSurfaceContainer = Color(0xFF4A4235);
}

abstract class FluffyThemes {
  static const double columnWidth = 380.0;
  static const double maxTimelineWidth = columnWidth * 2;
  static const double navRailWidth = 80.0;

  static bool isColumnModeByWidth(double width) =>
      width > columnWidth * 2 + navRailWidth;

  static bool isColumnMode(BuildContext context) =>
      isColumnModeByWidth(MediaQuery.sizeOf(context).width);

  static bool isThreeColumnMode(BuildContext context) =>
      MediaQuery.sizeOf(context).width > FluffyThemes.columnWidth * 3.5;

  static LinearGradient backgroundGradient(BuildContext context, int alpha) {
    final colorScheme = Theme.of(context).colorScheme;
    return LinearGradient(
      begin: Alignment.topCenter,
      colors: [
        colorScheme.primaryContainer.withAlpha(alpha),
        colorScheme.secondaryContainer.withAlpha(alpha),
        colorScheme.tertiaryContainer.withAlpha(alpha),
        colorScheme.primaryContainer.withAlpha(alpha),
      ],
    );
  }

  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Curve animationCurve = Curves.easeInOut;

  /// Earthbound-themed color scheme (light)
  static ColorScheme _earthboundLight() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: EarthboundColors.primary,
      onPrimary: Colors.white,
      primaryContainer: EarthboundColors.background,
      onPrimaryContainer: EarthboundColors.textPrimary,
      secondary: EarthboundColors.secondary,
      onSecondary: EarthboundColors.textPrimary,
      secondaryContainer: Color(0xFFFFE4E9),
      onSecondaryContainer: EarthboundColors.textPrimary,
      tertiary: EarthboundColors.tertiary,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFE3F2FD),
      onTertiaryContainer: EarthboundColors.textPrimary,
      error: Color(0xFFE53935),
      onError: Colors.white,
      errorContainer: Color(0xFFFFEBEE),
      onErrorContainer: Color(0xFFB71C1C),
      surface: EarthboundColors.background,
      onSurface: EarthboundColors.textPrimary,
      surfaceContainerHighest: Color(0xFFF5E6C8),
      onSurfaceVariant: EarthboundColors.textSecondary,
      outline: Color(0xFFD4C4A8),
      outlineVariant: Color(0xFFE8D9BE),
      shadow: Color(0x33000000),
      scrim: Color(0x52000000),
      inverseSurface: EarthboundColors.textPrimary,
      onInverseSurface: EarthboundColors.background,
      inversePrimary: Color(0xFFFFAB91),
    );
  }

  /// Earthbound-themed color scheme (dark)
  static ColorScheme _earthboundDark() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: EarthboundColors.primary,
      onPrimary: Colors.white,
      primaryContainer: EarthboundColors.backgroundDark,
      onPrimaryContainer: EarthboundColors.background,
      secondary: EarthboundColors.secondary,
      onSecondary: EarthboundColors.textPrimary,
      secondaryContainer: Color(0xFF4A3A3F),
      onSecondaryContainer: EarthboundColors.background,
      tertiary: EarthboundColors.tertiary,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFF1A3A4A),
      onTertiaryContainer: EarthboundColors.background,
      error: Color(0xFFEF9A9A),
      onError: Color(0xFFB71C1C),
      errorContainer: Color(0xFF4A2020),
      onErrorContainer: Color(0xFFFFCDD2),
      surface: EarthboundColors.backgroundDark,
      onSurface: EarthboundColors.background,
      surfaceContainerHighest: Color(0xFF4A4235),
      onSurfaceVariant: Color(0xFFD4C4A8),
      outline: Color(0xFF6B5D4D),
      outlineVariant: Color(0xFF4A4235),
      shadow: Color(0x52000000),
      scrim: Color(0x52000000),
      inverseSurface: EarthboundColors.background,
      onInverseSurface: EarthboundColors.textPrimary,
      inversePrimary: EarthboundColors.primary,
    );
  }

  static ThemeData buildTheme(
    BuildContext context,
    Brightness brightness, [
    Color? seed,
  ]) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: seed ?? Color(AppSettings.colorSchemeSeedInt.value),
    );
    final isColumnMode = FluffyThemes.isColumnMode(context);
    return ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      dividerColor: brightness == Brightness.dark
          ? colorScheme.surfaceContainerHighest
          : colorScheme.surfaceContainer,
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerLow,
        iconColor: colorScheme.onSurface,
        textStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          iconColor: colorScheme.onSurface,
          disabledIconColor: colorScheme.onSurface,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorScheme.onSurface.withAlpha(128),
        selectionHandleColor: colorScheme.secondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      chipTheme: ChipThemeData(
        showCheckmark: false,
        backgroundColor: colorScheme.surfaceContainer,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius),
        ),
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: isColumnMode ? 72 : 56,
        shadowColor: isColumnMode
            ? colorScheme.surfaceContainer.withAlpha(128)
            : null,
        surfaceTintColor: isColumnMode ? colorScheme.surface : null,
        backgroundColor: isColumnMode ? colorScheme.surface : null,
        actionsPadding: isColumnMode
            ? const EdgeInsets.symmetric(horizontal: 16.0)
            : null,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness.reversed,
          statusBarBrightness: brightness,
          systemNavigationBarIconBrightness: brightness.reversed,
          systemNavigationBarColor: colorScheme.surface,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.primary),
            borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        strokeCap: StrokeCap.round,
        color: colorScheme.primary,
        refreshBackgroundColor: colorScheme.primaryContainer,
      ),
      snackBarTheme: isColumnMode
          ? const SnackBarThemeData(
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              width: FluffyThemes.columnWidth * 1.5,
            )
          : const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  /// Build Earthbound-themed theme
  static ThemeData buildEarthboundTheme(
    BuildContext context,
    Brightness brightness,
  ) {
    final colorScheme = brightness == Brightness.light 
        ? _earthboundLight() 
        : _earthboundDark();
    
    final isColumnMode = FluffyThemes.isColumnMode(context);
    
    return ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      
      // Typography - could add pixel font here
      fontFamily: 'Nunito', // Default, can be changed to VT323 for pixel
      
      // Custom colors
      scaffoldBackgroundColor: colorScheme.surface,
      dividerColor: brightness == Brightness.dark
          ? colorScheme.surfaceContainerHighest
          : colorScheme.surfaceContainer,
          
      // AppBar
      appBarTheme: AppBarTheme(
        toolbarHeight: isColumnMode ? 72 : 56,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness.reversed,
          statusBarBrightness: brightness,
          systemNavigationBarIconBrightness: brightness.reversed,
          systemNavigationBarColor: colorScheme.surface,
        ),
      ),
      
      // Cards
      cardTheme: CardTheme(
        color: colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outline.withAlpha(50),
            width: 1,
          ),
        ),
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: EarthboundColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: EarthboundColors.primary,
          side: const BorderSide(color: EarthboundColors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withAlpha(50),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: EarthboundColors.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: EarthboundColors.accent,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: EarthboundColors.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Navigation Bar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: EarthboundColors.primary.withAlpha(30),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: EarthboundColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          );
        }),
      ),
      
      // List Tiles
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      
      // Dialogs
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: EarthboundColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      
      // Popup Menu
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: EarthboundColors.textPrimary,
        contentTextStyle: const TextStyle(color: EarthboundColors.background),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EarthboundColors.accent;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EarthboundColors.accent.withAlpha(100);
          }
          return colorScheme.surfaceContainerHighest;
        }),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EarthboundColors.accent;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return EarthboundColors.primary;
          }
          return colorScheme.onSurfaceVariant;
        }),
      ),
      
      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: EarthboundColors.primary,
        linearTrackColor: Color(0xFFE8D9BE),
        circularTrackColor: Color(0xFFE8D9BE),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: EarthboundColors.primary,
        inactiveTrackColor: colorScheme.surfaceContainerHighest,
        thumbColor: EarthboundColors.primary,
        overlayColor: EarthboundColors.primary.withAlpha(30),
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      
      // Text Selection
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: EarthboundColors.primary.withAlpha(100),
        selectionHandleColor: EarthboundColors.primary,
        cursorColor: EarthboundColors.primary,
      ),
    );
  }
}

extension on Brightness {
  Brightness get reversed =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;
}

extension BubbleColorTheme on ThemeData {
  /// Earthbound-style bubble colors for chat messages
  Color get bubbleColor => brightness == Brightness.light
      ? EarthboundColors.tertiary  // Sky blue for sent messages
      : const Color(0xFF2D4A5A);

  Color get onBubbleColor => brightness == Brightness.light
      ? Colors.white
      : EarthboundColors.background;

  Color get secondaryBubbleColor => brightness == Brightness.light
      ? EarthboundColors.secondary  // Bubblegum pink for received
      : const Color(0xFF4A3A3F);
}
