import 'package:flutter/material.dart';
import 'package:dory/app/app.router.dart';
import 'package:dory/features/app/app_viewmodel.dart';
import 'package:dory/app/app_theme.dart';
import 'package:dory/ui/animations/theme_transition.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.reactive(
      viewModelBuilder: AppViewModel.new,
      builder: (context, viewModel, _) {
        return ThemeTransition(
          isDarkMode: viewModel.isDarkMode,
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: viewModel.themeMode,
            initialRoute: Routes.startupView,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
            navigatorObservers: [
              StackedService.routeObserver,
            ],
          ),
        );
      },
    );
  }
}
