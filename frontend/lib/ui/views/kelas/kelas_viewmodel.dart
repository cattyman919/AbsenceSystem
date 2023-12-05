import 'package:flutter/material.dart';
import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/models/absenKelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class KelasViewModel extends ReactiveViewModel {
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  final int idKelas;

  List<int> mingguOptions = [1, 2, 3, 4, 5, 6, 7]; // Sesuaikan dengan data Anda

  final TextEditingController mingguOptionsController = TextEditingController();

  KelasViewModel(this.idKelas);

  late final AbsenKelas absenKelas = AbsenKelas(hadir: [], tidakHadir: []);

  void init() async {
    setMingguKe(1);
  }

  void setMingguKe(int? value) async {
    setBusy(true);
    absenKelas.hadir.clear();
    absenKelas.tidakHadir.clear();
    var newData = await _apiService.fetchAbsenKelas(idKelas, value!);
    absenKelas.hadir.addAll(newData.hadir);
    absenKelas.tidakHadir.addAll(newData.tidakHadir);
    notifyListeners();
    setBusy(false);
  }

  void deleteAbsensi(int id, int week) async {
    bool confirmationDeletion = (await _dialogService.showConfirmationDialog(
            description: "Are you sure you want to delete this item?",
            confirmationTitle: "Delete",
            confirmationTitleColor: Colors.red,
            cancelTitle: "Cancel",
            cancelTitleColor: Colors.black))!
        .confirmed;

    if (confirmationDeletion) {
      setBusy(true);
      try {
        await _apiService.deleteAbsensi(id);
        setBusy(false);
        _dialogService
            .showCustomDialog(
                variant: DialogType.success,
                description: "Succesfully deleted item")
            .whenComplete(() {
          setMingguKe(week);
        });
      } catch (e) {
        setBusy(false);
        _dialogService.showCustomDialog(
            variant: DialogType.error, description: "Delete item failed");
      }
    }
  }
}
