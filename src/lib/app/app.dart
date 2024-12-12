import 'package:dory/services/theme_service.dart';
import 'package:dory/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:dory/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:dory/features/home/home_view.dart';
import 'package:dory/features/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ThemeService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
