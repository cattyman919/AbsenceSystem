import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/models/kelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MahasiswaRegisterViewModel extends ReactiveViewModel
    with FormStateHelper {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  late final List<Kelas> listKelas;

  final List<int> selectedKelas = [];

  void init() async {
    setBusy(true);
    listKelas = await _apiService.fetchKelas();
    setBusy(false);
  }

  void toggleKelasSelection(int id) {
    if (selectedKelas.contains(id)) {
      selectedKelas.remove(id);
    } else {
      selectedKelas.add(id);
    }
    notifyListeners();
  }

  Future<void> submitRegister() async {
    setBusy(true);
    try {
      await _apiService.registerMahasiswa(
          namaValue!, npmValue!, "secret123", selectedKelas);
      setBusy(false);
      clearForm();
      selectedKelas.clear();
      _dialogService
          .showCustomDialog(
              variant: DialogType.success, description: "Register Successful")
          .whenComplete(() {});
    } catch (e) {
      setBusy(false);
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: '$e',
      );
    }
  }

  Future<void> goToOTP() async {
    await _navigationService.navigateTo(Routes.mahasiswaOtpView);
  }
}
