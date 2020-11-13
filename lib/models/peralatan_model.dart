import 'package:meta/meta.dart';

class PeralatanModel {
  final String id;
  final String xJenis;
  final String xMerk;
  final String xLokasi;
  final String xKapasitas;
  final String xJumlah;
  final String xStatus;

  PeralatanModel({
    @required this.id,
    this.xJenis,
    this.xMerk,
    this.xLokasi,
    this.xKapasitas,
    this.xJumlah,
    this.xStatus,
  });

  factory PeralatanModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String xJenis = data['xJenis'];
    String xMerk = data['xMerk'];
    String xLokasi = data['xLokasi'];
    String xKapasitas = data['xKapasitas'];
    String xJumlah = data['xJumlah'];
    String xStatus = data['xStatus'];

    return PeralatanModel(
      id: documentId,
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
      'xJenis': xJenis,
      'xMerk': xMerk,
      'xLokasi': xLokasi,
      'xKapasitas': xKapasitas,
      'xJumlah': xJumlah,
      'xStatus': xStatus,
    };
  }
}
