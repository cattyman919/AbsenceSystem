import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:iot/ui/views/mahasiswa_otp/mahasiswa_otp_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'mahasiswa_otp_viewmodel.dart';

@FormView(fields: [FormTextField(name: 'otp')])
class MahasiswaOtpView extends StackedView<MahasiswaOtpViewModel>
    with $MahasiswaOtpView {
  const MahasiswaOtpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MahasiswaOtpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "OTP",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              verticalSpaceMedium,
              Text(
                'RFID : ${viewModel.rfid_tag}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              verticalSpaceMedium,
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder()),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              verticalSpaceMedium,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 40),
                ),
                onPressed: viewModel.verifyOTP,
                child: viewModel.isBusy
                    ? loadingSpinnerSmall()
                    : const Text('Verifikasi OTP',
                        style: TextStyle(color: Colors.white)),
              ),
              navigationLinks(viewModel)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(MahasiswaOtpViewModel viewModel) async {
    viewModel.init();
    syncFormWithViewModel(viewModel);
  }

  @override
  MahasiswaOtpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MahasiswaOtpViewModel();

  Widget loadingSpinnerSmall() {
    return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ));
  }

  Widget navigationLinks(MahasiswaOtpViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          actionLink('Login as Dosen', viewModel.goToDosenLogin),
          actionLink('Register Mahasiswa', viewModel.goToRegister),
        ],
      ),
    );
  }

  Widget actionLink(String text, VoidCallback action) {
    return TextButton(
      onPressed: action,
      child: Text(
        text,
        style: const TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
