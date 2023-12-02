import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'mahasiswa_register_viewmodel.dart';

@FormView(fields: [FormTextField(name: 'nama'), FormTextField(name: 'npm')])
class MahasiswaRegisterView extends StackedView<MahasiswaRegisterViewModel>
    with $MahasiswaRegisterView {
  const MahasiswaRegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MahasiswaRegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Register Mahasiswa",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            verticalSpaceMedium,
            Text(
              'RFID : ${123}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nama'),
              keyboardType: TextInputType.name,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'NPM'),
              keyboardType: TextInputType.number,
            ),
            verticalSpaceMedium,
            ElevatedButton(
              onPressed: () async {
                // Navigasi atau tampilkan pesan sukses
              },
              child: Text('Register'),
            ),
            verticalSpaceTiny,
            TextButton(onPressed: viewModel.goToOTP, child: Text("Verify OTP")),
            TextButton(onPressed: () {}, child: Text("Listen Websocket")),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(MahasiswaRegisterViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  MahasiswaRegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MahasiswaRegisterViewModel();
}
