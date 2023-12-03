class Mahasiswa {
  final int? id;
  final String? nama;
  final String? npm;

  Mahasiswa({required this.id, required this.nama, required this.npm});

  // Metode untuk mengubah JSON menjadi objek Kelas
  Mahasiswa.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int?,
        nama = json["nama"] as String?,
        npm = json['npm'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'npm': nama,
      };
}
