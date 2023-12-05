import 'package:iot/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:iot/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:iot/ui/views/home/home_view.dart';
import 'package:iot/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:iot/ui/views/dosen/dosen_view.dart';
import 'package:iot/services/api_service.dart';
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.dart';
import 'package:iot/ui/views/mahasiswa_otp/mahasiswa_otp_view.dart';
import 'package:iot/ui/views/dosen_register/dosen_register_view.dart';
import 'package:iot/ui/views/dosen_login/dosen_login_view.dart';
import 'package:iot/ui/dialogs/error/error_dialog.dart';
import 'package:iot/ui/dialogs/success/success_dialog.dart';
import 'package:iot/ui/views/kelas/kelas_view.dart';
import 'package:iot/ui/dialogs/new_kelas/new_kelas_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: HomeView),
    CustomRoute(page: StartupView),
    CustomRoute(
        page: DosenView, transitionsBuilder: TransitionsBuilders.zoomIn),
    CustomRoute(
        page: MahasiswaRegisterView,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        page: MahasiswaOtpView,
        transitionsBuilder: TransitionsBuilders.slideTop),
    CustomRoute(
        page: DosenRegisterView,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
    CustomRoute(
        page: DosenLoginView,
        transitionsBuilder: TransitionsBuilders.slideRightWithFade),
    MaterialRoute(page: KelasView),
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
    StackedDialog(classType: ErrorDialog),
    StackedDialog(classType: SuccessDialog),
    StackedDialog(classType: NewKelasDialog),
// @stacked-dialog
  ],
)
class App {}
