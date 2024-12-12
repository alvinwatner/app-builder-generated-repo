import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences.dart';

class ThemeService with ListenableServiceMixin {
  ThemeService() {
    _loadThemePreference();
    listenToReactiveValues([_isDarkMode, _isSystemTheme, _isTimeBasedTheme]);
  }

  static const String _themePreferenceKey = 'theme_preference';
  static const String _themeTypeKey = 'theme_type';

  final ReactiveValue<bool> _isDarkMode = ReactiveValue<bool>(false);
  final ReactiveValue<bool> _isSystemTheme = ReactiveValue<bool>(true);
  final ReactiveValue<bool> _isTimeBasedTheme = ReactiveValue<bool>(false);

  bool get isDarkMode => _isDarkMode.value;
  bool get isSystemTheme => _isSystemTheme.value;
  bool get isTimeBasedTheme => _isTimeBasedTheme.value;

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final themeType = prefs.getString(_themeTypeKey) ?? 'system';

    switch (themeType) {
      case 'system':
        _isSystemTheme.value = true;
        _isTimeBasedTheme.value = false;
        break;
      case 'time':
        _isSystemTheme.value = false;
        _isTimeBasedTheme.value = true;
        _updateTimeBasedTheme();
        break;
      default:
        _isSystemTheme.value = false;
        _isTimeBasedTheme.value = false;
        _isDarkMode.value = prefs.getBool(_themePreferenceKey) ?? false;
    }
  }

  Future<void> setDarkMode(bool isDark) async {
    _isDarkMode.value = isDark;
    _isSystemTheme.value = false;
    _isTimeBasedTheme.value = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, isDark);
    await prefs.setString(_themeTypeKey, 'manual');
  }

  Future<void> setSystemTheme(bool useSystem) async {
    _isSystemTheme.value = useSystem;
    _isTimeBasedTheme.value = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeTypeKey, 'system');
  }

  Future<void> setTimeBasedTheme(bool useTimeBased) async {
    _isTimeBasedTheme.value = useTimeBased;
    _isSystemTheme.value = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeTypeKey, 'time');

    if (useTimeBased) {
      _updateTimeBasedTheme();
    }
  }

  void _updateTimeBasedTheme() {
    final hour = DateTime.now().hour;
    _isDarkMode.value =
        hour < 6 || hour > 18; // Dark mode between 6 PM and 6 AM
  }

  void updateThemeBasedOnSystem(Brightness brightness) {
    if (_isSystemTheme.value) {
      _isDarkMode.value = brightness == Brightness.dark;
    }
  }

  void checkAndUpdateTimeBasedTheme() {
    if (_isTimeBasedTheme.value) {
      _updateTimeBasedTheme();
    }
  }
}
