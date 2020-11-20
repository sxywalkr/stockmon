import 'package:meta/meta.dart';

class MergrPenyediaModel {
  final String id;
  final String aNamaBadanUsaha;
  final String xx1Tempat;
  final String xx1Waktu;
  final String xx1NilaiPenawaran;
  final String xx1NomorSuratPenawaran;
  final String xx1InstansiPemberiTugas;
  final String xx1NamaPaket;
  final String xx1NomorUndangan;
  final String xx1TanggalUndangan;
  final String xx1JangkaWaktu;
  final String xx1MasaBerlaku;

  MergrPenyediaModel({
    @required this.id,
    this.aNamaBadanUsaha,
    this.xx1Tempat,
    this.xx1Waktu,
    this.xx1NilaiPenawaran,
    this.xx1NomorSuratPenawaran,
    this.xx1InstansiPemberiTugas,
    this.xx1NamaPaket,
    this.xx1NomorUndangan,
    this.xx1TanggalUndangan,
    this.xx1JangkaWaktu,
    this.xx1MasaBerlaku,
  });

  factory MergrPenyediaModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String aNamaBadanUsaha = data['aNamaBadanUsaha'];
    String xx1Tempat = data['xx1Tempat'];
    String xx1Waktu = data['xx1Waktu'];
    String xx1NilaiPenawaran = data['xx1NilaiPenawaran'];
    String xx1NomorSuratPenawaran = data['xx1NomorSuratPenawaran'];
    String xx1InstansiPemberiTugas = data['xx1InstansiPemberiTugas'];
    String xx1NamaPaket = data['xx1NamaPaket'];
    String xx1NomorUndangan = data['xx1NomorUndangan'];
    String xx1TanggalUndangan = data['xx1TanggalUndangan'];
    String xx1JangkaWaktu = data['xx1JangkaWaktu'];
    String xx1MasaBerlaku = data['xx1MasaBerlaku'];

    return MergrPenyediaModel(
      id: documentId,
      aNamaBadanUsaha: aNamaBadanUsaha,
      xx1Tempat: xx1Tempat,
      xx1Waktu: xx1Waktu,
      xx1NilaiPenawaran: xx1NilaiPenawaran,
      xx1NomorSuratPenawaran: xx1NomorSuratPenawaran,
      xx1InstansiPemberiTugas: xx1InstansiPemberiTugas,
      xx1NamaPaket: xx1NamaPaket,
      xx1NomorUndangan: xx1NomorUndangan,
      xx1TanggalUndangan: xx1TanggalUndangan,
      xx1JangkaWaktu: xx1JangkaWaktu,
      xx1MasaBerlaku: xx1MasaBerlaku,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aNamaBadanUsaha': aNamaBadanUsaha,
      'xx1Tempat': xx1Tempat,
      'xx1Waktu': xx1Waktu,
      'xx1NilaiPenawaran': xx1NilaiPenawaran,
      'xx1NomorSuratPenawaran': xx1NomorSuratPenawaran,
      'xx1InstansiPemberiTugas': xx1InstansiPemberiTugas,
      'xx1NamaPaket': xx1NamaPaket,
      'xx1NomorUndangan': xx1NomorUndangan,
      'xx1TanggalUndangan': xx1TanggalUndangan,
      'xx1JangkaWaktu': xx1JangkaWaktu,
      'xx1MasaBerlaku': xx1MasaBerlaku,
    };
  }
}
