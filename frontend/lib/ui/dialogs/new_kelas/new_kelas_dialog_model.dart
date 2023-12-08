import 'package:flutter/material.dart';
import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewKelasDialogModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  final TextEditingController namaKelasController = TextEditingController();

  void createNewKelas(Function(DialogResponse) completer) async {
    if (namaKelasController.text.isEmpty) {
      throw _dialogService.showCustomDialog(
          variant: DialogType.error, description: "Input is empty");
    }
    try {
      setBusy(true);
      await _apiService.createKelas(namaKelasController.text);
      await _dialogService.showCustomDialog(
          variant: DialogType.success,
          description: "Successfully created kelas");
      setBusy(false);
      completer(DialogResponse(confirmed: true));
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
          variant: DialogType.error, description: "Failed to create Kelas");
    }
  }
}
