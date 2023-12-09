import 'package:flutter/material.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:iot/ui/views/mahasiswa_register/mahasiswa_register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
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
      backgroundColor: Colors.grey[850], // Moderately dark background
      appBar: AppBar(
        title: const Text('Mahasiswa Registration'),
        backgroundColor: Colors.grey[900],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Register Mahasiswa",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                verticalSpaceMedium,
                Text(
                  'RFID : ${viewModel.rfid_tag}',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
                verticalSpaceMedium,
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                      labelText: 'Nama',
                      labelStyle:
                          TextStyle(color: Colors.white70, fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder()),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  keyboardType: TextInputType.name,
                ),
                verticalSpaceSmall,
                TextField(
                  controller: npmController,
                  decoration: const InputDecoration(
                      labelText: 'NPM',
                      labelStyle:
                          TextStyle(color: Colors.white70, fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder()),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  keyboardType: TextInputType.number,
                ),
                verticalSpaceMedium,
                viewModel.isBusy
                    ? const Column(
                        children: [
                          SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Fetching data...",
                                style: TextStyle(color: Colors.grey),
                              )),
                        ],
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button color
                          minimumSize: const Size(150, 35),
                        ),
                        onPressed: () => _showKelasDialog(context, viewModel),
                        child: const Text('Pilih Kelas'),
                      ),
                verticalSpaceSmall,
                ElevatedButton(
                  onPressed: viewModel.submitRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    minimumSize: const Size(200, 40),
                  ),
                  child: const Text('Register',
                      style: TextStyle(color: Colors.white)),
                ),
                additionalNavigation(viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget additionalNavigation(MahasiswaRegisterViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          actionLink('Verify OTP', viewModel.goToOTP),
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

  Widget listKelasView(MahasiswaRegisterViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.listKelas.length,
      itemBuilder: (context, index) {
        final kelas = viewModel.listKelas[index];
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
          title: const Text("Pilih Kelas"),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: model.listKelas.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final kelas = model.listKelas[index];
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
              child: const Text("OK"),
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
