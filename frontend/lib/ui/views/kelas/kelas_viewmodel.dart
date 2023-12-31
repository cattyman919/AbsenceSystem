import 'package:flutter/material.dart';
import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/models/absenKelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class KelasViewModel extends ReactiveViewModel {
  final int idKelas;
  KelasViewModel(this.idKelas);

  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  List<int> mingguOptions = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
  ]; // Sesuaikan dengan data Anda

  final TextEditingController mingguOptionsController = TextEditingController();

  int get minggu_ke => int.parse(mingguOptionsController.text.substring(10));

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
    setBusy(false);

    notifyListeners();
  }

  String formatJakartaTime(DateTime utcDateTime) {
    final jakartaTimeZone = tz.getLocation('Asia/Jakarta');
    final jakartaDateTime = tz.TZDateTime.from(utcDateTime, jakartaTimeZone);
    return DateFormat('HH:mm:ss').format(jakartaDateTime);
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
        setMingguKe(week);
        setBusy(false);
        await _dialogService.showCustomDialog(
            variant: DialogType.success,
            description: "Succesfully deleted item");
      } catch (e) {
        setBusy(false);
        _dialogService.showCustomDialog(
            variant: DialogType.error, description: "Delete item failed");
      }
    }
  }

  void onRefresh() async {
    setMingguKe(minggu_ke);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
