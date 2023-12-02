import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MahasiswaOtpViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();

  String _otp = '';

  String get otp => _otp;

  void setOtp(String newValue) {
    _otp = newValue;
    notifyListeners();
  }

  Future<void> goToRegister() async {
    await _navigationService.navigateTo(Routes.mahasiswaRegisterView);
  }

  Future<void> goToDosenLogin() async {
    await _navigationService.navigateTo(Routes.dosenLoginView);
  }

  Future<void> verifyOtp() async {
    // Logika untuk verifikasi OTP (misalnya, kirim ke API)
    // Contoh:
    // await apiService.verifyOtp(otp);
  }
}
