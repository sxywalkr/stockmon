import 'package:meta/meta.dart';

class PekerjaanModel {
  final String id;
  final String kNamaPenyedia;
  final String kNamaPaket;
  final String kKlasifikasi;
  final String kSubKlasifikasi;
  final String kLingkup;
  final String kLokasi;
  final String kNamaPejabat;
  final String kAlamatPejabat;
  final String kTeleponPejabat;
  final String kNomorKontrak;
  final String kTanggalKontrak;
  final String kNilaiKontrak;
  final String kTanggalKontrakPho;
  final String kBaKontrakPho;
  final String kNomorProgres;
  final String kTanggalProgres;
  final String kTotalProgres;

  PekerjaanModel({
    @required this.id,
    @required this.kNamaPenyedia,
    @required this.kNamaPaket,
    this.kKlasifikasi,
    this.kSubKlasifikasi,
    this.kLingkup,
    this.kLokasi,
    this.kNamaPejabat,
    this.kAlamatPejabat,
    this.kTeleponPejabat,
    this.kNomorKontrak,
    this.kTanggalKontrak,
    this.kNilaiKontrak,
    this.kTanggalKontrakPho,
    this.kBaKontrakPho,
    this.kNomorProgres,
    this.kTanggalProgres,
    this.kTotalProgres,
  });

  factory PekerjaanModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String kNamaPenyedia = data['kNamaPenyedia'];
    String kNamaPaket = data['kNamaPaket'];
    String kKlasifikasi = data['kKlasifikasi'];
    String kSubKlasifikasi = data['kSubKlasifikasi'];
    String kLingkup = data['kLingkup'];
    String kLokasi = data['kLokasi'];
    String kNamaPejabat = data['kNamaPejabat'];
    String kAlamatPejabat = data['kAlamatPejabat'];
    String kTeleponPejabat = data['kTeleponPejabat'];
    String kNomorKontrak = data['kNomorKontrak'];
    String kTanggalKontrak = data['kTanggalKontrak'];
    String kNilaiKontrak = data['kNilaiKontrak'];
    String kTanggalKontrakPho = data['kTanggalKontrakPho'];
    String kBaKontrakPho = data['kBaKontrakPho'];
    String kNomorProgres = data['kNomorProgres'];
    String kTanggalProgres = data['kTanggalProgres'];
    String kTotalProgres = data['kTotalProgres'];

    return PekerjaanModel(
      id: documentId,
      kNamaPenyedia: kNamaPenyedia,
      kNamaPaket: kNamaPaket,
      kKlasifikasi: kKlasifikasi,
      kSubKlasifikasi: kSubKlasifikasi,
      kLingkup: kLingkup,
      kLokasi: kLokasi,
      kNamaPejabat: kNamaPejabat,
      kAlamatPejabat: kAlamatPejabat,
      kTeleponPejabat: kTeleponPejabat,
      kNomorKontrak: kNomorKontrak,
      kTanggalKontrak: kTanggalKontrak,
      kNilaiKontrak: kNilaiKontrak,
      kTanggalKontrakPho: kTanggalKontrakPho,
      kBaKontrakPho: kBaKontrakPho,
      kNomorProgres: kNomorProgres,
      kTanggalProgres: kTanggalProgres,
      kTotalProgres: kTotalProgres,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kNamaPenyedia': kNamaPenyedia,
      'kNamaPaket': kNamaPaket,
      'kKlasifikasi': kKlasifikasi,
      'kSubKlasifikasi': kSubKlasifikasi,
      'kLingkup': kLingkup,
      'kLokasi': kLokasi,
      'kNamaPejabat': kNamaPejabat,
      'kAlamatPejabat': kAlamatPejabat,
      'kTeleponPejabat': kTeleponPejabat,
      'kNomorKontrak': kNomorKontrak,
      'kTanggalKontrak': kTanggalKontrak,
      'kNilaiKontrak': kNilaiKontrak,
      'kTanggalKontrakPho': kTanggalKontrakPho,
      'kBaKontrakPho': kBaKontrakPho,
      'kNomorProgres': kNomorProgres,
      'kTanggalProgres': kTanggalProgres,
      'kTotalProgres': kTotalProgres,
    };
  }
}
