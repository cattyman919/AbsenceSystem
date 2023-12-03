import 'package:iot/app/app.locator.dart';
import 'package:iot/models/absenKelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:stacked/stacked.dart';

class KelasViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();

  final int idKelas;
  final int mingguKe = 1;

  KelasViewModel(this.idKelas);

  late final AbsenKelas _absenKelas;
  AbsenKelas get absenKelas => _absenKelas;

  void init() async {
    setBusy(true);
    _absenKelas = await _apiService.fetchAbsenKelas(idKelas, mingguKe);
    setBusy(false);
  }
}
