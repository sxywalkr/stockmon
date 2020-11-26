class StokBarangAktifModel {
  String uidBarang;
  String namaBarang;
  int jumlah;
  double harga1;
  double harga2;
  String tanggalBeli;
  String tag1;
  String tag2;

  StokBarangAktifModel({
    this.uidBarang,
    this.namaBarang,
    this.jumlah,
    this.harga1,
    this.harga2,
    this.tanggalBeli,
    this.tag1,
    this.tag2,
  });

  factory StokBarangAktifModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String uidBarang = data['uidBarang'];
    String namaBarang = data['namaBarang'];
    int jumlah = data['jumlah'];
    double harga1 = data['harga1'];
    double harga2 = data['harga2'];
    String tanggalBeli = data['tanggalBeli'];
    String tag1 = data['tag1'];
    String tag2 = data['tag2'];

    return StokBarangAktifModel(
      uidBarang: uidBarang,
      namaBarang: namaBarang,
      jumlah: jumlah,
      harga1: harga1,
      harga2: harga2,
      tanggalBeli: tanggalBeli,
      tag1: tag1,
      tag2: tag2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uidBarang': uidBarang,
      'namaBarang': namaBarang,
      'jumlah': jumlah,
      'harga1': harga1,
      'harga2': harga2,
      'tanggalBeli': tanggalBeli,
      'tag1': tag1,
      'tag2': tag2,
    };
  }
}
