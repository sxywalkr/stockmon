import 'package:meta/meta.dart';

class MergrPersonelModel {
  final String id;
  final String aNamaBadanUsaha;
  final String xhNama;

  MergrPersonelModel({
    @required this.id,
    this.aNamaBadanUsaha,
    this.xhNama,
  });

  factory MergrPersonelModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String aNamaBadanUsaha = data['aNamaBadanUsaha'];
    String xhNama = data['xhNama'];

    return MergrPersonelModel(
      id: documentId,
      aNamaBadanUsaha: aNamaBadanUsaha,
      xhNama: xhNama,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aNamaBadanUsaha': aNamaBadanUsaha,
      'xhNama': xhNama,
    };
  }
}
