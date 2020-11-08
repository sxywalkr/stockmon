import 'package:meta/meta.dart';

class PengalamanModel {
  final String id;
  final String iNamaPenyedia;
  final String iNamaPaket;
  final String iKlasifikasi;
  final String iSubKlasifikasi;
  final String iLingkup;
  final String iLokasi;
  final String iNamaPejabat;
  final String iAlamatPejabat;
  final String iTeleponPejabat;
  final String iNomorKontrak;
  final String iTanggalKontrak;
  final String iNilaiKontrak;
  final String iTanggalKontrakPho;
  final String iBaKontrakPho;
  final String iNomorProgres;
  final String iTanggalProgres;
  final String iTotalProgres;

  PengalamanModel({
    @required this.id,
    @required this.iNamaPenyedia,
    @required this.iNamaPaket,
    this.iKlasifikasi,
    this.iSubKlasifikasi,
    this.iLingkup,
    this.iLokasi,
    this.iNamaPejabat,
    this.iAlamatPejabat,
    this.iTeleponPejabat,
    this.iNomorKontrak,
    this.iTanggalKontrak,
    this.iNilaiKontrak,
    this.iTanggalKontrakPho,
    this.iBaKontrakPho,
    this.iNomorProgres,
    this.iTanggalProgres,
    this.iTotalProgres,
  });

  factory PengalamanModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String iNamaPenyedia = data['iNamaPenyedia'];
    String iNamaPaket = data['iNamaPaket'];
    String iKlasifikasi = data['iKlasifikasi'];
    String iSubKlasifikasi = data['iSubKlasifikasi'];
    String iLingkup = data['iLingkup'];
    String iLokasi = data['iLokasi'];
    String iNamaPejabat = data['iNamaPejabat'];
    String iAlamatPejabat = data['iAlamatPejabat'];
    String iTeleponPejabat = data['iTeleponPejabat'];
    String iNomorKontrak = data['iNomorKontrak'];
    String iTanggalKontrak = data['iTanggalKontrak'];
    String iNilaiKontrak = data['iNilaiKontrak'];
    String iTanggalKontrakPho = data['iTanggalKontrakPho'];
    String iBaKontrakPho = data['iBaKontrakPho'];
    String iNomorProgres = data['iNomorProgres'];
    String iTanggalProgres = data['iTanggalProgres'];
    String iTotalProgres = data['iTotalProgres'];

    return PengalamanModel(
      id: documentId,
      iNamaPenyedia: iNamaPenyedia,
      iNamaPaket: iNamaPaket,
      iKlasifikasi: iKlasifikasi,
      iSubKlasifikasi: iSubKlasifikasi,
      iLingkup: iLingkup,
      iLokasi: iLokasi,
      iNamaPejabat: iNamaPejabat,
      iAlamatPejabat: iAlamatPejabat,
      iTeleponPejabat: iTeleponPejabat,
      iNomorKontrak: iNomorKontrak,
      iTanggalKontrak: iTanggalKontrak,
      iNilaiKontrak: iNilaiKontrak,
      iTanggalKontrakPho: iTanggalKontrakPho,
      iBaKontrakPho: iBaKontrakPho,
      iNomorProgres: iNomorProgres,
      iTanggalProgres: iTanggalProgres,
      iTotalProgres: iTotalProgres,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iNamaPenyedia': iNamaPenyedia,
      'iNamaPaket': iNamaPaket,
      'iKlasifikasi': iKlasifikasi,
      'iSubKlasifikasi': iSubKlasifikasi,
      'iLingkup': iLingkup,
      'iLokasi': iLokasi,
      'iNamaPejabat': iNamaPejabat,
      'iAlamatPejabat': iAlamatPejabat,
      'iTeleponPejabat': iTeleponPejabat,
      'iNomorKontrak': iNomorKontrak,
      'iTanggalKontrak': iTanggalKontrak,
      'iNilaiKontrak': iNilaiKontrak,
      'iTanggalKontrakPho': iTanggalKontrakPho,
      'iBaKontrakPho': iBaKontrakPho,
      'iNomorProgres': iNomorProgres,
      'iTanggalProgres': iTanggalProgres,
      'iTotalProgres': iTotalProgres,
    };
  }
}
