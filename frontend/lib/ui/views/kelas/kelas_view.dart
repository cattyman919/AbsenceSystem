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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '$namaKelas',
            textScaleFactor: 2,
          ),
          verticalSpaceMedium,
          DropdownMenu<int>(
            onSelected: viewModel.setMingguKe,
            initialSelection: 1,
            dropdownMenuEntries:
                viewModel.mingguOptions.map<DropdownMenuEntry<int>>((e) {
              return DropdownMenuEntry<int>(
                value: e,
                label: 'Minggu ke-${e}',
                style: MenuItemButton.styleFrom(
                    // foregroundColor: color.color,
                    ),
              );
            }).toList(),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          verticalSpaceMedium,
          Text(
            'Hadir',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.3,
          ),
          verticalSpaceSmall,
          viewModel.isBusy ? loadingSpinner() : hadirKelas(viewModel),
          verticalSpaceMedium,
          Text(
            'Tidak Hadir',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.3,
          ),
          viewModel.isBusy ? loadingSpinner() : tidakHadirKelas(viewModel),
        ]),
      ),
    );
  }

  Widget hadirKelas(KelasViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showBottomBorder: true,
        columns: [
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Waktu Masuk')),
          DataColumn(label: Text('Waktu Keluar')),
          DataColumn(label: Text('Action')),
        ],
        rows: viewModel.absenKelas.hadir.map<DataRow>((Hadir absensi) {
          final waktu_masuk = absensi.waktu_masuk;
          final waktu_keluar = absensi.waktu_keluar;
          return DataRow(cells: [
            DataCell(Text(absensi.mahasiswa!.nama!)),
            DataCell(Text(
                '${waktu_masuk!.hour}:${waktu_masuk!.minute}:${waktu_masuk.second}')),
            DataCell(Text(
                "${waktu_keluar?.hour ?? '-'}:${waktu_keluar?.minute ?? '-'}:${waktu_keluar?.second ?? '-'}")),
            DataCell(Text('Delete')),
          ]);
        }).toList(),
      ),
    );
  }

  Widget tidakHadirKelas(KelasViewModel viewModel) {
    return SingleChildScrollView(
      child: DataTable(
        showBottomBorder: true,
        columns: [
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('NPM')),
        ],
        rows:
            viewModel.absenKelas.tidakHadir.map<DataRow>((Mahasiswa mahasiswa) {
          return DataRow(cells: [
            DataCell(Text(mahasiswa.nama!)),
            DataCell(Text(mahasiswa.npm!)),
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
                  color: Colors.black,
                  strokeWidth: 3,
                )),
            Padding(
                child: Text("Fetching data..."),
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
