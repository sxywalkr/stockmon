import 'package:meta/meta.dart';

class PersonelModel {
  final String id;
  final String hNama;
  final String hPendidikan;
  final String hJabatan;
  final String hPengalaman;
  final String hSertifikat;
  final String hSetor;

  PersonelModel({
    @required this.id,
    this.hNama,
    this.hPendidikan,
    this.hJabatan,
    this.hPengalaman,
    this.hSertifikat,
    this.hSetor,
  });

  factory PersonelModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String hNama = data['hNama'];
    String hPendidikan = data['hPendidikan'];
    String hJabatan = data['hJabatan'];
    String hPengalaman = data['hPengalaman'];
    String hSertifikat = data['hSertifikat'];
    String hSetor = data['hSetor'];

    return PersonelModel(
      id: documentId,
      hNama: hNama,
      hPendidikan: hPendidikan,
      hJabatan: hJabatan,
      hPengalaman: hPengalaman,
      hSertifikat: hSertifikat,
      hSetor: hSetor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hNama': hNama,
      'hPendidikan': hPendidikan,
      'hJabatan': hJabatan,
      'hPengalaman': hPengalaman,
      'hSertifikat': hSertifikat,
      'hSetor': hSetor,
    };
  }
}
