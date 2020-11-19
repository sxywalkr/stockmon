import 'package:meta/meta.dart';

class ReferensiModel {
  final String id;
  final String xxx1Nama;
  final String xxx1Alamat;
  final String xxx1Jabatan;
  final String xxx1NomorSurat;
  final String xxx1NamaKontrak;
  final String xxx1NomorKontrak;
  final String xxx1Instansi;
  final String xxx1Periode;
  final String xxx1Tempat;
  final String xxx1Waktu;
  final String xxx1NamaPejabat;
  final String xxx1NipPejabat;

  ReferensiModel({
    @required this.id,
    this.xxx1Nama,
    this.xxx1Alamat,
    this.xxx1Jabatan,
    this.xxx1NomorSurat,
    this.xxx1NamaKontrak,
    this.xxx1NomorKontrak,
    this.xxx1Instansi,
    this.xxx1Periode,
    this.xxx1Tempat,
    this.xxx1Waktu,
    this.xxx1NamaPejabat,
    this.xxx1NipPejabat,
  });

  factory ReferensiModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String xxx1Nama = data['xxx1Nama'];
    String xxx1Alamat = data['xxx1Alamat'];
    String xxx1Jabatan = data['xxx1Jabatan'];
    String xxx1NomorSurat = data['xxx1NomorSurat'];
    String xxx1NamaKontrak = data['xxx1NamaKontrak'];
    String xxx1NomorKontrak = data['xxx1NomorKontrak'];
    String xxx1Instansi = data['xxx1Instansi'];
    String xxx1Periode = data['xxx1Periode'];
    String xxx1Tempat = data['xxx1Tempat'];
    String xxx1Waktu = data['xxx1Waktu'];
    String xxx1NamaPejabat = data['xxx1NamaPejabat'];
    String xxx1NipPejabat = data['xxx1NipPejabat'];

    return ReferensiModel(
      id: documentId,
      xxx1Nama: xxx1Nama,
      xxx1Alamat: xxx1Alamat,
      xxx1Jabatan: xxx1Jabatan,
      xxx1NomorSurat: xxx1NomorSurat,
      xxx1NamaKontrak: xxx1NamaKontrak,
      xxx1NomorKontrak: xxx1NomorKontrak,
      xxx1Instansi: xxx1Instansi,
      xxx1Periode: xxx1Periode,
      xxx1Tempat: xxx1Tempat,
      xxx1Waktu: xxx1Waktu,
      xxx1NamaPejabat: xxx1NamaPejabat,
      xxx1NipPejabat: xxx1NipPejabat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'xxx1Nama': xxx1Nama,
      'xxx1Alamat': xxx1Alamat,
      'xxx1Jabatan': xxx1Jabatan,
      'xxx1NomorSurat': xxx1NomorSurat,
      'xxx1NamaKontrak': xxx1NamaKontrak,
      'xxx1NomorKontrak': xxx1NomorKontrak,
      'xxx1Instansi': xxx1Instansi,
      'xxx1Periode': xxx1Periode,
      'xxx1Tempat': xxx1Tempat,
      'xxx1Waktu': xxx1Waktu,
      'xxx1NamaPejabat': xxx1NamaPejabat,
      'xxx1NipPejabat': xxx1NipPejabat,
    };
  }
}
