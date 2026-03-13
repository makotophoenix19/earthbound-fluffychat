import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluffychat/utils/color_value.dart';

/// Extended theme mode including Earthbound options
enum AppThemeMode {
  light,
  dark,
  system,
  earthboundLight,
  earthboundDark,
}

extension AppThemeModeExtension on AppThemeMode {
  ThemeMode get toThemeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.earthboundLight:
        return ThemeMode.light;
      case AppThemeMode.earthboundDark:
        return ThemeMode.dark;
    }
  }

  bool get isEarthbound {
    return this == AppThemeMode.earthboundLight || 
           this == AppThemeMode.earthboundDark;
  }

  String get displayName {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.earthboundLight:
        return 'Earthbound';
      case AppThemeMode.earthboundDark:
        return 'Earthbound Dark';
    }
  }
}

class ThemeBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    ThemeMode themeMode,
    Color? primaryColor,
  )
  builder;

  final String themeModeSettingsKey;
  final String primaryColorSettingsKey;

  const ThemeBuilder({
    required this.builder,
    this.themeModeSettingsKey = 'theme_mode',
    this.primaryColorSettingsKey = 'primary_color',
    super.key,
  });

  @override
  State<ThemeBuilder> createState() => ThemeController();
}

class ThemeController extends State<ThemeBuilder> {
  SharedPreferences? _sharedPreferences;
  AppThemeMode _themeMode = AppThemeMode.system;
  Color? _primaryColor;

  /// Current theme mode including Earthbound options
  AppThemeMode get themeMode => _themeMode;

  /// Standard Flutter ThemeMode (for compatibility)
  ThemeMode get flutterThemeMode => _themeMode.toThemeMode;

  /// Whether Earthbound theme is active
  bool get isEarthbound => _themeMode.isEarthbound;

  /// Whether to use dark mode (handles earthbound dark)
  bool get isDark {
    if (_themeMode == AppThemeMode.earthboundDark) return true;
    if (_themeMode == AppThemeMode.earthboundLight) return false;
    return _themeMode.toThemeMode == ThemeMode.dark;
  }

  Color? get primaryColor => _primaryColor;

  static ThemeController of(BuildContext context) =>
      Provider.of<ThemeController>(context, listen: false);

  Future<void> _loadData(_) async {
    final preferences = _sharedPreferences ?=
        await SharedPreferences.getInstance();

    final rawThemeMode = preferences.getString(widget.themeModeSettingsKey);
    final rawColor = preferences.getInt(widget.primaryColorSettingsKey);

    setState(() {
      // Try to parse as AppThemeMode first
      _themeMode = AppThemeMode.values.singleWhereOrNull(
        (value) => value.name == rawThemeMode,
      ) ?? AppThemeMode.system;
      
      _primaryColor = rawColor == null ? null : Color(rawColor);
    });
  }

  /// Set theme using AppThemeMode (includes Earthbound)
  Future<void> setThemeMode(AppThemeMode newThemeMode) async {
    final preferences = _sharedPreferences ?=
        await SharedPreferences.getInstance();
    await preferences.setString(widget.themeModeSettingsKey, newThemeMode.name);
    setState(() {
      _themeMode = newThemeMode;
    });
  }

  /// Set theme using standard Flutter ThemeMode
  Future<void> setFlutterThemeMode(ThemeMode mode) async {
    AppThemeMode appMode;
    switch (mode) {
      case ThemeMode.light:
        appMode = AppThemeMode.light;
        break;
      case ThemeMode.dark:
        appMode = AppThemeMode.dark;
        break;
      case ThemeMode.system:
        appMode = AppThemeMode.system;
        break;
    }
    await setThemeMode(appMode);
  }

  Future<void> setPrimaryColor(Color? newPrimaryColor) async {
    final preferences = _sharedPreferences ?=
        await SharedPreferences.getInstance();
    if (newPrimaryColor == null) {
      await preferences.remove(widget.primaryColorSettingsKey);
    } else {
      await preferences.setInt(
        widget.primaryColorSettingsKey,
        newPrimaryColor.hexValue,
      );
    }
    setState(() {
      _primaryColor = newPrimaryColor;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_loadData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => this,
      child: DynamicColorBuilder(
        builder: (light, _) =>
            widget.builder(context, flutterThemeMode, primaryColor ?? light?.primary),
      ),
    );
  }
}
