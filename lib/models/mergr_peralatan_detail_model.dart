import 'package:meta/meta.dart';

class MergrPeralatanDetailModel {
  final String id;
  final String aNamaBadanUsaha;
  final String xJenis;
  final String xMerk;
  final String xLokasi;
  final String xKapasitas;
  final String xJumlah;
  final String xStatus;

  MergrPeralatanDetailModel({
    @required this.id,
    this.aNamaBadanUsaha,
    this.xJenis,
    this.xMerk,
    this.xLokasi,
    this.xKapasitas,
    this.xJumlah,
    this.xStatus,
  });

  factory MergrPeralatanDetailModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String aNamaBadanUsaha = data['aNamaBadanUsaha'];
    String xJenis = data['xJenis'];
    String xMerk = data['xMerk'];
    String xLokasi = data['xLokasi'];
    String xKapasitas = data['xKapasitas'];
    String xJumlah = data['xJumlah'];
    String xStatus = data['xStatus'];

    return MergrPeralatanDetailModel(
      id: documentId,
      aNamaBadanUsaha: aNamaBadanUsaha,
      xJenis: xJenis,
      xMerk: xMerk,
      xLokasi: xLokasi,
      xKapasitas: xKapasitas,
      xJumlah: xJumlah,
      xStatus: xStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aNamaBadanUsaha': aNamaBadanUsaha,
      'xJenis': xJenis,
      'xMerk': xMerk,
      'xLokasi': xLokasi,
      'xKapasitas': xKapasitas,
      'xJumlah': xJumlah,
      'xStatus': xStatus,
    };
  }
}
