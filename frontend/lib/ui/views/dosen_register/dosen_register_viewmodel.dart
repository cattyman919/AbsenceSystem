import 'package:flutter/material.dart';
import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/services/api_service.dart';
import 'package:iot/ui/views/dosen_register/dosen_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DosenRegisterViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  void registerDosen() async {
    setBusy(true);
    try {
      await _apiService.register(usernameValue!, passwordValue!);
      clearForm();
      setBusy(false);
      _dialogService
          .showCustomDialog(
              variant: DialogType.success,
              description: "Account has successfully been created")
          .whenComplete(goToLoginDosen);
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: '$e',
      );
    }
  }

  Future<void> goToLoginDosen() async {
    _navigationService.popUntil(ModalRoute.withName(Routes.dosenLoginView));
  }
}
