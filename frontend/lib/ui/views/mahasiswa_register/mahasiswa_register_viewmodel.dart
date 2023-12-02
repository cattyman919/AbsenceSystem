import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MahasiswaRegisterViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> goToOTP() async {
    await _navigationService.navigateTo(Routes.mahasiswaOtpView);
  }
}
