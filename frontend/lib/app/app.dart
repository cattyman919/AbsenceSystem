import 'package:iot/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:iot/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:iot/ui/views/home/home_view.dart';
import 'package:iot/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:iot/ui/views/mahasiswa/mahasiswa_view.dart';
import 'package:iot/ui/views/dosen/dosen_view.dart';
import 'package:iot/services/api_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: MahasiswaView),
    MaterialRoute(page: DosenView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
