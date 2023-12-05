import 'package:flutter/material.dart';
import 'package:iot/models/absenKelas.model.dart';
import 'package:iot/models/mahasiswa.model.dart';
import 'package:iot/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'kelas_viewmodel.dart';

class KelasView extends StackedView<KelasViewModel> {
  final int idKelas;
  final String namaKelas;

  const KelasView({Key? key, required this.idKelas, required this.namaKelas})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    KelasViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // Moderately dark background
      appBar: AppBar(
        title: Text(namaKelas), // Class name in the AppBar
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            DropdownMenu<int>(
              onSelected: viewModel.setMingguKe,
              initialSelection: 1,
              textStyle: TextStyle(color: Colors.white),
              menuStyle: MenuStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.grey[900]!),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                floatingLabelStyle: TextStyle(color: Colors.white),
                fillColor: Color.fromARGB(255, 29, 29, 29),
              ),
              dropdownMenuEntries:
                  viewModel.mingguOptions.map<DropdownMenuEntry<int>>((e) {
                return DropdownMenuEntry<int>(
                    value: e,
                    label: 'Minggu ke-${e}',
                    style: MenuItemButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      foregroundColor: Colors.white,
                    ));
              }).toList(),
            ),
            verticalSpaceMedium,
            Text(
              'Hadir',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            verticalSpaceSmall,
            viewModel.isBusy ? loadingSpinner() : hadirKelas(viewModel),
            verticalSpaceMedium,
            Text(
              'Tidak Hadir',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            verticalSpaceMedium,
            viewModel.isBusy ? loadingSpinner() : tidakHadirKelas(viewModel),
          ]),
        ),
      ),
    );
  }

  Widget hadirKelas(KelasViewModel viewModel) {
    return viewModel.absenKelas.hadir.length == 0
        ? Center(
            child: Text(
              'Kosong',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showBottomBorder: true,
              columns: [
                DataColumn(
                    label: Text('Nama',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ))),
                DataColumn(
                    label: Text('Waktu Masuk',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ))),
                DataColumn(
                    label: Text('Waktu Keluar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ))),
                DataColumn(
                    label: Text('Action',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ))),
              ],
              rows: viewModel.absenKelas.hadir.map<DataRow>((Hadir absensi) {
                final waktu_masuk = absensi.waktu_masuk;
                final waktu_keluar = absensi.waktu_keluar;
                return DataRow(cells: [
                  DataCell(Text(absensi.mahasiswa!.nama!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(
                      '${waktu_masuk!.hour}:${waktu_masuk!.minute}:${waktu_masuk.second}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(
                      textAlign: TextAlign.center,
                      "${waktu_keluar?.hour ?? '-'}:${waktu_keluar?.minute ?? '-'}:${waktu_keluar?.second ?? '-'}",
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text('Delete')),
                ]);
              }).toList(),
            ),
          );
  }

  Widget tidakHadirKelas(KelasViewModel viewModel) {
    return viewModel.absenKelas.tidakHadir.length == 0
        ? Center(
            child: Text(
              'Kosong',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        : SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              columns: [
                DataColumn(
                    label: Text('Nama', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('NPM', style: TextStyle(color: Colors.white))),
              ],
              rows: viewModel.absenKelas.tidakHadir
                  .map<DataRow>((Mahasiswa mahasiswa) {
                return DataRow(cells: [
                  DataCell(Text(mahasiswa.nama!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(mahasiswa.npm!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white))),
                ]);
              }).toList(),
            ),
          );
  }

  Widget loadingSpinner() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(top: 30),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  strokeWidth: 3,
                )),
            Padding(
                child: Text(
                  "Fetching data...",
                  style: TextStyle(color: Colors.grey),
                ),
                padding: EdgeInsets.only(top: 20)),
          ],
        ));
  }

  @override
  void onViewModelReady(KelasViewModel viewModel) {
    viewModel.init();
  }

  @override
  KelasViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      KelasViewModel(idKelas);
}
