class Kelas {
  final int? id;
  final String? nama;

  Kelas({required this.id, required this.nama});

  // Metode untuk mengubah JSON menjadi objek Kelas
  Kelas.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int?,
        nama = json["nama"] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
      };
}
