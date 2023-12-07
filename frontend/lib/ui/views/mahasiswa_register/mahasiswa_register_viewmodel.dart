import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/models/kelas.model.dart';
import 'package:iot/services/api_service.dart';
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt;
import 'package:stacked_services/stacked_services.dart';

class MahasiswaRegisterViewModel extends ReactiveViewModel
    with FormStateHelper {
  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  final client = mqtt.MqttServerClient('broker.hivemq.com', '');
  String rfid_tag = "";

  late final List<Kelas> listKelas;

  final List<int> selectedKelas = [];

  void init() async {
    setBusy(true);
    listKelas = await _apiService.fetchKelas();
    getRFID();
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

  Future<void> getRFID() async {
    client.setProtocolV311();
    //setBusy(true);
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
    // Subscribe to the same topic
    print("Waiting for RFID tag");
    client.subscribe('esp32/cardDetected', MqttQos.exactlyOnce);
    listenForTopic();
    //setBusy(false);
  }

  void listenForTopic() async {
    // List<MqttReceivedMessage<MqttMessage>> response =
    //     await client.updates!.listen((event) { });
    // final MqttPublishMessage recMess =
    //     response[0].payload as MqttPublishMessage;
    // final String message =
    //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    // print('Received message:$message from topic: ${response[0].topic}>');
    // rfid_tag = message;

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('Received message:$message from topic: ${c[0].topic}>');
      rfid_tag = message;
      notifyListeners();

      // Handle the message (e.g., update UI)
    });
  }

  Future<void> submitRegister() async {
    setBusy(true);
    try {
      await _apiService.registerMahasiswa(
          namaValue!, npmValue!, rfid_tag, selectedKelas);
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
