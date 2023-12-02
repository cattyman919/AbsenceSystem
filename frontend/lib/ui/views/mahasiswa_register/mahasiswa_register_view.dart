import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'mahasiswa_register_viewmodel.dart';

@FormView(fields: [FormTextField(name: 'nama'), FormTextField(name: 'npm')])
class MahasiswaRegisterView extends StatelessWidget
    with $MahasiswaRegisterView {
  const MahasiswaRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MahasiswaRegisterViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
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
                    'RFID : adasok',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(labelText: 'Nama'),
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    controller: npmController,
                    decoration: InputDecoration(labelText: 'NPM'),
                    keyboardType: TextInputType.number,
                  ),
                  verticalSpaceMedium,
                  viewModel.isBusy
                      ? Container(
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )),
                              Padding(
                                  child: Text("Fetching data..."),
                                  padding: EdgeInsets.only(top: 20)),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () => _showKelasDialog(context, viewModel),
                          child: Text('Pilih Kelas'),
                        ),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigasi atau tampilkan pesan sukses
                    },
                    child: Text('Register'),
                  ),
                  verticalSpaceTiny,
                  TextButton(
                      onPressed: viewModel.goToOTP, child: Text("Verify OTP")),
                  TextButton(onPressed: () {}, child: Text("Listen Websocket")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listKelasView(MahasiswaRegisterViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.listKelas!.length,
      itemBuilder: (context, index) {
        final kelas = viewModel.listKelas![index];
        return CheckboxListTile(
          title: Text(kelas.nama!),
          value: viewModel.selectedKelas.contains(kelas.id),
          onChanged: (value) => {},
        );
      },
    );
  }

  void _showKelasDialog(
      BuildContext context, MahasiswaRegisterViewModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Kelas"),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: model.listKelas.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final kelas = model.listKelas![index];
                  return CheckboxListTile(
                    title: Text(kelas.nama!),
                    value: model.selectedKelas.contains(kelas.id),
                    onChanged: (value) => {
                      setState(() {
                        model.toggleKelasSelection(kelas.id!);
                      })
                    },
                  );
                },
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                // Logika selanjutnya setelah memilih kelas
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onViewModelReady(MahasiswaRegisterViewModel viewModel) {
    viewModel.init();
    syncFormWithViewModel(viewModel);
  }

  @override
  bool get reactive =>
      true; // Set true to rebuild the widget when notifyListeners is called

  @override
  MahasiswaRegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MahasiswaRegisterViewModel();
}
