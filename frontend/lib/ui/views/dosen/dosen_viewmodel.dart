import 'package:flutter/material.dart';
import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/models/kelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DosenViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  late final List<Kelas> _kelas;
  List<Kelas> get kelas => _kelas;

  void init() async {
    setBusy(true);
    _kelas = await _apiService.fetchKelas();
    setBusy(false);
  }

  void updateData() async {
    _kelas.clear();
    var updatedKelas = await _apiService.fetchKelas();
    _kelas.addAll(updatedKelas);
    notifyListeners();

  }

  void showDialogKelasBaru() async {
    await _dialogService
        .showCustomDialog(
          variant: DialogType.newKelas,
        )
        .whenComplete(updateData);
  }

  void goToKelas(int id, String nama) {
    _navigationService.navigateToKelasView(idKelas: id, namaKelas: nama);
  }

  void deleteKelas(int id) async {
    bool confirmationDeletion = (await _dialogService.showConfirmationDialog(
            description: "Are you sure you want to delete this item?",
            confirmationTitle: "Delete",
            confirmationTitleColor: Colors.red,
            cancelTitle: "Cancel",
            cancelTitleColor: Colors.black))!
        .confirmed;
    if (confirmationDeletion) {
      try {
        setBusy(true);
        await _apiService.deleteKelas(id);
        _dialogService
            .showCustomDialog(
                variant: DialogType.success,
                description: "Succesfully deleted item")
            .whenComplete(updateData);

      } catch (e) {
        setBusy(false);
        _dialogService.showCustomDialog(
            variant: DialogType.error, description: "Delete item failed");
      }
      setBusy(false);
    }
  }
}
