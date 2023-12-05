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
              textStyle: const TextStyle(color: Colors.white),
              menuStyle: MenuStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.grey[900]!),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                floatingLabelStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                fillColor: Color.fromARGB(255, 29, 29, 29),
              ),
              dropdownMenuEntries:
                  viewModel.mingguOptions.map<DropdownMenuEntry<int>>((e) {
                return DropdownMenuEntry<int>(
                    value: e,
                    label: 'Minggu ke-$e',
                    style: MenuItemButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      foregroundColor: Colors.white,
                    ));
              }).toList(),
            ),
            verticalSpaceMedium,
            const Text(
              'Hadir',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            verticalSpaceMedium,
            viewModel.isBusy ? loadingSpinner() : hadirKelas(viewModel),
            verticalSpaceMedium,
            const Text(
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
    return viewModel.absenKelas.hadir.isEmpty
        ? const Center(
            child: Text(
              'Kosong',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
              showBottomBorder: true,
              columns: const [
                DataColumn(
                    label: Center(
                  child: Text('Nama',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Waktu Masuk',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Waktu Keluar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Action',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                )),
              ],
              rows: viewModel.absenKelas.hadir.map<DataRow>((Hadir absensi) {
                final waktuMasuk = absensi.waktu_masuk;
                final waktuKeluar = absensi.waktu_keluar;

                void deleteAbsenCell() {
                  viewModel.deleteAbsensi(absensi.id, absensi.minggu_ke);
                }

                return DataRow(cells: [
                  DataCell(Center(
                    child: Text(absensi.mahasiswa!.nama!,
                        style: const TextStyle(color: Colors.white)),
                  )),
                  DataCell(Center(
                    child: Text(
                        '${waktuMasuk!.hour}:${waktuMasuk.minute}:${waktuMasuk.second}',
                        style: const TextStyle(color: Colors.white)),
                  )),
                  DataCell(Center(
                    child: Text(
                        "${waktuKeluar?.hour ?? '-'}:${waktuKeluar?.minute ?? '-'}:${waktuKeluar?.second ?? '-'}",
                        style: const TextStyle(color: Colors.white)),
                  )),
                  DataCell(
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: deleteAbsenCell,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          );
  }

  Widget tidakHadirKelas(KelasViewModel viewModel) {
    return viewModel.absenKelas.tidakHadir.isEmpty
        ? const Center(
            child: Text(
              'Kosong',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        : SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              border: TableBorder.all(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
              columns: const [
                DataColumn(
                    label: Center(
                        child: Text('Nama',
                            style: TextStyle(color: Colors.white)))),
                DataColumn(
                    label: Center(
                        child: Text('NPM',
                            style: TextStyle(color: Colors.white)))),
              ],
              rows: viewModel.absenKelas.tidakHadir
                  .map<DataRow>((Mahasiswa mahasiswa) {
                return DataRow(cells: [
                  DataCell(Center(
                    child: Text(mahasiswa.nama!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white)),
                  )),
                  DataCell(Center(
                    child: Text(mahasiswa.npm!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white)),
                  )),
                ]);
              }).toList(),
            ),
          );
  }

  Widget loadingSpinner() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsetsDirectional.only(top: 30),
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
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Fetching data...",
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                )),
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
