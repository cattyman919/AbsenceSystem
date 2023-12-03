import 'package:iot/models/mahasiswa.model.dart';

class AbsenKelas {
  final List<Hadir> hadir;
  final List<Mahasiswa> tidakHadir;

  AbsenKelas({required this.hadir, required this.tidakHadir});

  // Metode untuk mengubah JSON menjadi objek Kelas
  factory AbsenKelas.fromJson(Map<String, dynamic> json) {
    var list = json["hadir"] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<Hadir> hadirList = list.map((i) => Hadir.fromJson(i)).toList();

    list = json['tidakHadir'] as List;
    List<Mahasiswa> tidakHadirList =
        list.map((i) => Mahasiswa.fromJson(i)).toList();

    return AbsenKelas(hadir: hadirList, tidakHadir: tidakHadirList);
  }
  Map<String, dynamic> toJson() => {
        'hadir': hadir,
        'tidakHadir': tidakHadir,
      };
}

class Hadir {
  final DateTime? waktu_masuk;
  final DateTime? waktu_keluar;
  final Mahasiswa? mahasiswa;

  Hadir(
      {required this.waktu_masuk,
      required this.waktu_keluar,
      required this.mahasiswa});

  // Metode untuk mengubah JSON menjadi objek Kelas
  Hadir.fromJson(Map<String, dynamic> json)
      : waktu_masuk = DateTime.parse(json["waktu_masuk"]) as DateTime?,
        waktu_keluar = DateTime.parse(json["waktu_keluar"]) as DateTime?,
        mahasiswa = Mahasiswa.fromJson(json['mahasiswa']) as Mahasiswa?;

  Map<String, dynamic> toJson() => {
        'waktu_masuk': waktu_masuk,
        'waktu_keluar': waktu_keluar,
        'mahasiswa': mahasiswa
      };
}
