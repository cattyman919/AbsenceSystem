import 'package:iot/app/app.dialogs.dart';
import 'package:iot/app/app.locator.dart';
import 'package:iot/app/app.router.dart';
import 'package:iot/ui/views/mahasiswa_otp/mahasiswa_otp_view.form.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class MahasiswaOtpViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final String uuid = Uuid().v4();

  late final mqtt.MqttServerClient client;

  String _statusMessage = '';

  String rfid_tag = '';

  String get statusMessage => _statusMessage;

  Future<void> goToRegister() async {
    await _navigationService.navigateTo(Routes.mahasiswaRegisterView);
  }

  Future<void> goToDosenLogin() async {
    await _navigationService.navigateTo(Routes.dosenLoginView);
  }

  void updateStatusMessage(String newMessage) {
    _statusMessage = newMessage;
    notifyListeners(); // Notify the UI about the update
  }

  void init() async {
    client = mqtt.MqttServerClient('broker.hivemq.com', uuid);

    client.setProtocolV311();

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    // Subscribe to the same topic
    client.subscribe('esp32/cardDetected', MqttQos.exactlyOnce);
    client.subscribe('esp32/otpVerificationResult', MqttQos.exactlyOnce);

    listenForVerificationResult();
  }

  void verifyOTP() async {
    if (otpValue!.isEmpty) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: 'OTP Value is Empty',
      );
      return;
    }

    setBusy(true);
    //updateStatusMessage("Connecting to MQTT...");

    updateStatusMessage("Publishing Message...");

    publishMessage(otpValue!, 'esp32/otpEntered');

    updateStatusMessage("Waiting for response...");

    // Call publishMessage with the data you want to send
  }

  // Publishing to the topic
  publishMessage(String message, String topic) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!,
        retain: false);
  }

  void listenForVerificationResult() async {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('Received message:$message from topic: ${c[0].topic}>');

      if (message == "Success") {
        _dialogService.showCustomDialog(
            variant: DialogType.success,
            description: "OTP Authentication Success");
        setBusy(false);
        rfid_tag = "";
      } else if (message == "Failed") {
        _dialogService.showCustomDialog(
            variant: DialogType.error,
            description: "OTP Authentication Failed");
        setBusy(false);
        rfid_tag = "";
      } else {
        rfid_tag = message;
      }
      notifyListeners();
      // Handle the message (e.g., update UI)
    });
  }
}
