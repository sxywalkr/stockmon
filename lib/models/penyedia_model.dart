import 'package:meta/meta.dart';

class PenyediaModel {
  final String id;
  final String aNamaBadanUsaha;
  final String aStatus;
  final String aAlamatPusat;
  final String aTelpPusat;
  final String aFaxPusat;
  final String aEmailPusat;
  final String bNomor;
  final String bTanggal;
  final String bNamaNotaris;
  final String bNomorPengesahan;
  final String cNama;
  final String cNomor;
  final String cJabatan;
  final String dNomor;
  final String dTanggal;
  final String dMasa;
  final String dInstansi;
  final String eNomor;
  final String eTanggal;
  final String eMasa;
  final String eInstansi;
  final String eKualifikasi;
  final String eKlasifikasi;
  final String eSubKlasifikasi;
  final String fNomor;
  final String fTanggal;
  final String fMasa;
  final String fInstansi;
  final String g1Nama;
  final String g1Identitas;
  final String g1Alamat;
  final String g1Persentase;
  final String g2Npwp;
  final String g2Nomor;
  final String g2Tanggal;

  PenyediaModel({
    @required this.id,
    @required this.aNamaBadanUsaha,
    this.aStatus,
    this.aAlamatPusat,
    this.aTelpPusat,
    this.aFaxPusat,
    this.aEmailPusat,
    this.bNomor,
    this.bTanggal,
    this.bNamaNotaris,
    this.bNomorPengesahan,
    this.cNama,
    this.cNomor,
    this.cJabatan,
    this.dNomor,
    this.dTanggal,
    this.dMasa,
    this.dInstansi,
    this.eNomor,
    this.eTanggal,
    this.eMasa,
    this.eInstansi,
    this.eKualifikasi,
    this.eKlasifikasi,
    this.eSubKlasifikasi,
    this.fNomor,
    this.fTanggal,
    this.fMasa,
    this.fInstansi,
    this.g1Nama,
    this.g1Identitas,
    this.g1Alamat,
    this.g1Persentase,
    this.g2Npwp,
    this.g2Nomor,
    this.g2Tanggal,
  });

  factory PenyediaModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String aNamaBadanUsaha = data['aNamaBadanUsaha'];
    String aStatus = data['aStatus'];
    String aAlamatPusat = data['aAlamatPusat'];
    String aTelpPusat = data['aTelpPusat'];
    String aFaxPusat = data['aFaxPusat'];
    String aEmailPusat = data['aEmailPusat'];
    String bNomor = data['bNomor'];
    String bTanggal = data['bTanggal'];
    String bNamaNotaris = data['bNamaNotaris'];
    String bNomorPengesahan = data['bNamaPengesahan'];
    String cNama = data['cNama'];
    String cNomor = data['cNomor'];
    String cJabatan = data['cJabatan'];
    String dNomor = data['dNomor'];
    String dTanggal = data['dTanggal'];
    String dMasa = data['dMasa'];
    String dInstansi = data['dInstansi'];
    String eNomor = data['eNomor'];
    String eTanggal = data['eTanggal'];
    String eMasa = data['eMasa'];
    String eInstansi = data['eInstansi'];
    String eKualifikasi = data['eKualifikasi'];
    String eKlasifikasi = data['eKlasifikasi'];
    String eSubKlasifikasi = data['eSubKlasifikasi'];
    String fNomor = data['fNomor'];
    String fTanggal = data['fTanggal'];
    String fMasa = data['fMasa'];
    String fInstansi = data['fInstansi'];
    String g1Nama = data['g1Nama'];
    String g1Identitas = data['g1Identitas'];
    String g1Alamat = data['g1Alamat'];
    String g1Persentase = data['g1Persentase'];
    String g2Npwp = data['g2Npwp'];
    String g2Nomor = data['g2Nomor'];
    String g2Tanggal = data['g2Tanggal'];

    return PenyediaModel(
      id: documentId,
      aNamaBadanUsaha: aNamaBadanUsaha,
      aStatus: aStatus,
      aAlamatPusat: aAlamatPusat,
      aTelpPusat: aTelpPusat,
      aFaxPusat: aFaxPusat,
      aEmailPusat: aEmailPusat,
      bNomor: bNomor,
      bTanggal: bTanggal,
      bNamaNotaris: bNamaNotaris,
      bNomorPengesahan: bNomorPengesahan,
      cNama: cNama,
      cNomor: cNomor,
      cJabatan: cJabatan,
      dNomor: dNomor,
      dTanggal: dTanggal,
      dMasa: dMasa,
      dInstansi: dInstansi,
      eNomor: eNomor,
      eTanggal: eTanggal,
      eMasa: eMasa,
      eInstansi: eInstansi,
      eKualifikasi: eKualifikasi,
      eKlasifikasi: eKlasifikasi,
      eSubKlasifikasi: eSubKlasifikasi,
      fNomor: fNomor,
      fTanggal: fTanggal,
      fMasa: fMasa,
      fInstansi: fInstansi,
      g1Nama: g1Nama,
      g1Identitas: g1Identitas,
      g1Alamat: g1Alamat,
      g1Persentase: g1Persentase,
      g2Npwp: g2Npwp,
      g2Nomor: g2Nomor,
      g2Tanggal: g2Tanggal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aNamaBadanUsaha': aNamaBadanUsaha,
      'aStatus': aStatus,
      'aAlamatPusat': aAlamatPusat,
      'aTelpPusat': aTelpPusat,
      'aFaxPusat': aFaxPusat,
      'aEmailPusat': aEmailPusat,
      'bNomor': bNomor,
      'bTanggal': bTanggal,
      'bNamaNotaris': bNamaNotaris,
      'bNomorPengesahan': bNomorPengesahan,
      'cNama': cNama,
      'cNomor': cNomor,
      'cJabatan': cJabatan,
      'dNomor': dNomor,
      'dTanggal': dTanggal,
      'dMasa': dMasa,
      'dInstansi': dInstansi,
      'eNomor': eNomor,
      'eTanggal': eTanggal,
      'eMasa': eMasa,
      'eInstansi': eInstansi,
      'eKualifikasi': eKualifikasi,
      'eKlasifikasi': eKlasifikasi,
      'eSubKlasifikasi': eSubKlasifikasi,
      'fNomor': fNomor,
      'fTanggal': fTanggal,
      'fMasa': fMasa,
      'fInstansi': fInstansi,
      'g1Nama': g1Nama,
      'g1Identitas': g1Identitas,
      'g1Alamat': g1Alamat,
      'g1Persentase': g1Persentase,
      'g2Npwp': g2Npwp,
      'g2Nomor': g2Nomor,
      'g2Tanggal': g2Tanggal,
    };
  }
}
