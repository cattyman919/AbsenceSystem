import 'package:flutter/material.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/models/absenKelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:stacked/stacked.dart';

class KelasViewModel extends ReactiveViewModel {
  final _apiService = locator<ApiService>();

  final int idKelas;

  int mingguKe = 1;
  List<int> mingguOptions = [1, 2, 3, 4, 5, 6, 7]; // Sesuaikan dengan data Anda

  final TextEditingController mingguOptionsController = TextEditingController();

  KelasViewModel(this.idKelas);

  late final AbsenKelas absenKelas;

  void init() async {
    setBusy(true);
    absenKelas = await _apiService.fetchAbsenKelas(idKelas, mingguKe);
    setBusy(false);
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
}
