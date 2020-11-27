class StokBarangKeluarModel {
  String id;
  String uidBarang;
  String namaBarang;
  int jumlah;
  double harga1;
  double harga2;
  String tanggalJual;
  String tag1;
  String tag2;
  String orderByUser;
  String orderStatus;

  StokBarangKeluarModel({
    this.id,
    this.uidBarang,
    this.namaBarang,
    this.jumlah,
    this.harga1,
    this.harga2,
    this.tanggalJual,
    this.tag1,
    this.tag2,
    this.orderByUser,
    this.orderStatus,
  });

  factory StokBarangKeluarModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String id = data['id'];
    String uidBarang = data['uidBarang'];
    String namaBarang = data['namaBarang'];
    int jumlah = data['jumlah'];
    double harga1 = data['harga1'];
    double harga2 = data['harga2'];
    String tanggalJual = data['tanggalJual'];
    String tag1 = data['tag1'];
    String tag2 = data['tag2'];
    String orderByUser = data['orderByUser'];
    String orderStatus = data['orderStatus'];

    return StokBarangKeluarModel(
      id: id,
      uidBarang: uidBarang,
      namaBarang: namaBarang,
      jumlah: jumlah,
      harga1: harga1,
      harga2: harga2,
      tanggalJual: tanggalJual,
      tag1: tag1,
      tag2: tag2,
      orderByUser: orderByUser,
      orderStatus: orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uidBarang': uidBarang,
      'namaBarang': namaBarang,
      'jumlah': jumlah,
      'harga1': harga1,
      'harga2': harga2,
      'tanggalJual': tanggalJual,
      'tag1': tag1,
      'tag2': tag2,
      'orderByUser': orderByUser,
      'orderStatus': orderStatus,
    };
  }
}
