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
  final String clientID = const Uuid().v1();

  late final mqtt.MqttServerClient client;

  String _statusMessage = '';

  String rfid_tag = '';

  String get statusMessage => _statusMessage;

  void updateStatusMessage(String newMessage) {
    _statusMessage = newMessage;
    notifyListeners(); // Notify the UI about the update
  }

  void init() async {
    client = mqtt.MqttServerClient('broker.hivemq.com', clientID);

    client.setProtocolV311();

    try {
      await client.connect();
    } catch (e) {
      client.disconnect();
    }

    client.autoReconnect = true;

    // Subscribe to the same topic
    client.subscribe('esp32/cardDetected', MqttQos.exactlyOnce);
    client.subscribe('esp32/otpVerificationResult', MqttQos.exactlyOnce);

    listenForVerificationResult();
  }

  void verifyOTP() async {
    if (otpValue!.isEmpty) {
      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: 'OTP Value is Empty',
      );
      return;
    }

    if (otpValue!.length < 4) {
      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: 'OTP Value has to be 4 digits',
      );
      return;
    }

    setBusy(true);

    updateStatusMessage("Publishing Message...");

    publishMessage("${otpValue!}id:$clientID", 'esp32/otpEntered');

    updateStatusMessage("Waiting for response...");
    await Future.delayed(const Duration(seconds: 10));

    if (isBusy == true) {
      _dialogService.showCustomDialog(
          variant: DialogType.error, description: "OTP Authentication Timeout");
      setBusy(false);
    }
  }

  // Publishing to the topic
  void publishMessage(String message, String topic) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void listenForVerificationResult() async {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final topic = c[0].topic;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      //print('Received message:$message from topic: ${c[0].topic}>');

      if (message == "Success:$clientID") {
        _dialogService.showCustomDialog(
            variant: DialogType.success,
            description: "OTP Authentication Success");
        setBusy(false);
        rfid_tag = "";
      } else if (message == "Failed:$clientID") {
        _dialogService.showCustomDialog(
            variant: DialogType.error,
            description: "OTP Authentication Failed");
        setBusy(false);
        rfid_tag = "";
      } else if (topic.compareTo("esp32/cardDetected") == 0) {
        rfid_tag = message;
      }
      notifyListeners();
    });
  }

  Future<void> goToRegister() async {
    await _navigationService.navigateTo(Routes.mahasiswaRegisterView);
  }

  Future<void> goToDosenLogin() async {
    await _navigationService.navigateTo(Routes.dosenLoginView);
  }
}
