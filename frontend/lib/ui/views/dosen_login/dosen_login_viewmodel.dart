import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/services/api_service.dart';
import 'package:iot/ui/views/dosen_login/dosen_login_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DosenLoginViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  void init() {
    usernameValue = "admin";
    passwordValue = "admin";
  }

  void loginDosen() async {
    setBusy(true);
    try {
      await _apiService.login(usernameValue!, passwordValue!);
      //clearForm();
      setBusy(false);
      _dialogService
          .showCustomDialog(
              variant: DialogType.success, description: "Login Successful")
          .whenComplete(_navigationService.navigateToDosenView);
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: '$e',
      );
    }
  }

  Future<void> goToRegisterDosen() async {
    await _navigationService.navigateTo(Routes.dosenRegisterView);
  }

  Future<void> goToOTP() async {
    _navigationService.popUntil((route) => route.isFirst);
  }
}
