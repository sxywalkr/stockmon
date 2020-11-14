import 'package:meta/meta.dart';

class MergrPenyediaModel {
  final String id;
  final String aNamaBadanUsaha;
  final String xx1Tempat;
  final String xx1Waktu;

  MergrPenyediaModel({
    @required this.id,
    this.aNamaBadanUsaha,
    this.xx1Tempat,
    this.xx1Waktu,
  });

  factory MergrPenyediaModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String aNamaBadanUsaha = data['aNamaBadanUsaha'];
    String xx1Tempat = data['xx1Tempat'];
    String xx1Waktu = data['xx1Waktu'];

    return MergrPenyediaModel(
      id: documentId,
      aNamaBadanUsaha: aNamaBadanUsaha,
      xx1Tempat: xx1Tempat,
      xx1Waktu: xx1Waktu,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aNamaBadanUsaha': aNamaBadanUsaha,
      'xx1Tempat': xx1Tempat,
      'xx1Waktu': xx1Waktu,
    };
  }
}
