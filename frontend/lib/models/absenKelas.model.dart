import 'package:iot/models/kelas.model.dart';
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
  final int id;
  final DateTime? waktu_masuk;
  final DateTime? waktu_keluar;
  final int minggu_ke;
  final Mahasiswa? mahasiswa;
  final Kelas? kelas;

  Hadir(
      {required this.id,
      required this.waktu_masuk,
      required this.waktu_keluar,
      required this.minggu_ke,
      required this.mahasiswa,
      required this.kelas});

  // Metode untuk mengubah JSON menjadi objek Kelas
  Hadir.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        waktu_masuk = DateTime.parse(json["waktu_masuk"]),
        waktu_keluar = DateTime.parse(json["waktu_keluar"]),
        minggu_ke = json['minggu_ke'] as int,
        mahasiswa = Mahasiswa.fromJson(json['mahasiswa']),
        kelas = Kelas.fromJson(json['kelas']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'waktu_masuk': waktu_masuk,
        'waktu_keluar': waktu_keluar,
        'minggu_ke': minggu_ke,
        'mahasiswa': mahasiswa,
        'kelas': kelas
      };
}
