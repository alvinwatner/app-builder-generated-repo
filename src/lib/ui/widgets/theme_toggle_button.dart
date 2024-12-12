import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dory/app/app.locator.dart';
import 'package:dory/services/theme_service.dart';
import 'package:dory/ui/common/app_colors.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeToggleViewModel>.reactive(
      viewModelBuilder: () => ThemeToggleViewModel(),
      builder: (context, model, child) => PopupMenuButton<String>(
        onSelected: model.onThemeOptionSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'light',
            child: Row(
              children: [
                Icon(
                  Icons.light_mode,
                  color: model.isDarkMode ? Colors.white : kcDarkGreyColor,
                ),
                const SizedBox(width: 8),
                const Text('Light Mode'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'dark',
            child: Row(
              children: [
                Icon(
                  Icons.dark_mode,
                  color: model.isDarkMode ? Colors.white : kcDarkGreyColor,
                ),
                const SizedBox(width: 8),
                const Text('Dark Mode'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'system',
            child: Row(
              children: [
                Icon(
                  Icons.settings_system_daydream,
                  color: model.isDarkMode ? Colors.white : kcDarkGreyColor,
                ),
                const SizedBox(width: 8),
                const Text('System Default'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'time',
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: model.isDarkMode ? Colors.white : kcDarkGreyColor,
                ),
                const SizedBox(width: 8),
                const Text('Time Based'),
              ],
            ),
          ),
        ],
        child: Icon(
          model.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: model.isDarkMode ? Colors.white : kcDarkGreyColor,
        ),
      ),
    );
  }
}

class ThemeToggleViewModel extends ReactiveViewModel {
  final _themeService = locator<ThemeService>();

  bool get isDarkMode => _themeService.isDarkMode;

  void onThemeOptionSelected(String value) {
    switch (value) {
      case 'light':
        _themeService.setDarkMode(false);
        break;
      case 'dark':
        _themeService.setDarkMode(true);
        break;
      case 'system':
        _themeService.setSystemTheme(true);
        break;
      case 'time':
        _themeService.setTimeBasedTheme(true);
        break;
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];
}
