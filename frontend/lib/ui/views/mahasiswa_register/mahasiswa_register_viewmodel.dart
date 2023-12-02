import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/models/kelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MahasiswaRegisterViewModel extends ReactiveViewModel
    with FormStateHelper {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();

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

  Future<void> goToOTP() async {
    await _navigationService.navigateTo(Routes.mahasiswaOtpView);
  }
}
