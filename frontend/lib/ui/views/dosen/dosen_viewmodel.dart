import 'package:iot/app/app.locator.dart';
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
    print(_kelas);
    setBusy(false);
  }
}
