import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dory/app/app.bottomsheets.dart';
import 'package:dory/app/app.dialogs.dart';
import 'package:dory/app/app.locator.dart';
import 'package:dory/services/theme_service.dart';
import 'package:dory/features/app/app_view.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await setupLocator();
    setupDialogUi();
    setupBottomSheetUi();

    final themeService = locator<ThemeService>();
    await Future.delayed(const Duration(milliseconds: 100));
    themeService.checkAndUpdateTimeBasedTheme();

    runApp(const AppView());
  }, (exception, stackTrace) async {
    print('Caught error: $exception');
    print('Stack trace: $stackTrace');
  });
}
