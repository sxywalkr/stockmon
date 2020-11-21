import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/pekerjaan_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditPekerjaanScreen extends StatefulWidget {
  @override
  _CreateEditPekerjaanScreenState createState() =>
      _CreateEditPekerjaanScreenState();
}

class _CreateEditPekerjaanScreenState extends State<CreateEditPekerjaanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PekerjaanModel _pekerjaan;
  TextEditingController _kNamaPenyediaController;
  TextEditingController _kNamaPaketController;
  TextEditingController _kKlasifikasiController;
  TextEditingController _kSubKlasifikasiController;
  TextEditingController _kLingkupController;
  TextEditingController _kLokasiController;
  TextEditingController _kNamaPejabatController;
  TextEditingController _kAlamatPejabatController;
  TextEditingController _kTeleponPejabatController;
  TextEditingController _kNomorKontrakController;
  TextEditingController _kTanggalKontrakController;
  TextEditingController _kNilaiKontrakController;
  TextEditingController _kTanggalKontrakPhoController;
  TextEditingController _kBaKontrakPhoController;
  TextEditingController _kNomorProgresController;
  TextEditingController _kTanggalProgresController;
  TextEditingController _kTotalProgresController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PekerjaanModel _pekerjaanModel =
        ModalRoute.of(context).settings.arguments;
    if (_pekerjaanModel != null) {
      _pekerjaan = _pekerjaanModel;
    }

    _kNamaPenyediaController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kNamaPenyedia : '');
    _kNamaPaketController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kNamaPaket : '');
    _kKlasifikasiController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kKlasifikasi : '');
    _kSubKlasifikasiController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kSubKlasifikasi : '');
    _kLingkupController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kLingkup : '');
    _kLokasiController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kLokasi : '');
    _kNamaPejabatController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kNamaPejabat : '');
    _kAlamatPejabatController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kAlamatPejabat : '');
    _kTeleponPejabatController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kTeleponPejabat : '');
    _kNomorKontrakController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kNomorKontrak : '');
    _kTanggalKontrakController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kTanggalKontrak : '');
    _kNilaiKontrakController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kNilaiKontrak : '');
    _kTanggalKontrakPhoController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kTanggalKontrakPho : '');
    _kBaKontrakPhoController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kBaKontrakPho : '');
    _kNomorProgresController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kNomorProgres : '');
    _kTanggalProgresController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kTanggalProgres : '');
    _kTotalProgresController = TextEditingController(
        text: _pekerjaan != null ? _pekerjaan.kTotalProgres : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(_pekerjaan != null ? 'Edit Pekerjaan' : 'Tambah Pekerjaan'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setPekerjaan(PekerjaanModel(
                    id: _pekerjaan != null
                        ? _pekerjaan.id
                        : documentIdFromCurrentDate(),
                    kNamaPenyedia: _kNamaPenyediaController.text,
                    kNamaPaket: _kNamaPaketController.text,
                    kKlasifikasi: _kKlasifikasiController.text,
                    kSubKlasifikasi: _kSubKlasifikasiController.text,
                    kLingkup: _kLingkupController.text,
                    kLokasi: _kLokasiController.text,
                    kNamaPejabat: _kNamaPejabatController.text,
                    kAlamatPejabat: _kAlamatPejabatController.text,
                    kTeleponPejabat: _kTeleponPejabatController.text,
                    kNomorKontrak: _kNomorKontrakController.text,
                    kTanggalKontrak: _kTanggalKontrakController.text,
                    kNilaiKontrak: _kNilaiKontrakController.text,
                    kTanggalKontrakPho: _kTanggalKontrakPhoController.text,
                    kBaKontrakPho: _kBaKontrakPhoController.text,
                    kNomorProgres: _kNomorProgresController.text,
                    kTanggalProgres: _kTanggalProgresController.text,
                    kTotalProgres: _kTotalProgresController.text,
                  ));

                  Navigator.of(context).pop();
                }
              },
              child: Text("Simpan"))
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
    );
  }

  @override
  void dispose() {
    _kNamaPenyediaController.dispose();
    _kNamaPaketController.dispose();
    _kKlasifikasiController.dispose();
    _kSubKlasifikasiController.dispose();
    _kLingkupController.dispose();
    _kLokasiController.dispose();
    _kNamaPejabatController.dispose();
    _kAlamatPejabatController.dispose();
    _kTeleponPejabatController.dispose();
    _kNomorKontrakController.dispose();
    _kTanggalKontrakController.dispose();
    _kNilaiKontrakController.dispose();
    _kTanggalKontrakPhoController.dispose();
    _kBaKontrakPhoController.dispose();
    _kNomorProgresController.dispose();
    _kTanggalProgresController.dispose();
    _kTotalProgresController.dispose();

    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('I. Data Pengalaman Kerja'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kNamaPenyediaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama Penyedia',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kNamaPaketController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Nama Paket tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama Paket',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kKlasifikasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Klasifikasi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kSubKlasifikasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Sub Klasifikasi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kLingkupController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Lingkup',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kLokasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Lokasi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kNamaPejabatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama Pejabat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kAlamatPejabatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Alamat Pejabat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kTeleponPejabatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Telepon Pejabat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kNomorKontrakController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor Kontrak',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kTanggalKontrakController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal Kontrak',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kNilaiKontrakController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nilai Kontrak',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kTanggalKontrakPhoController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal Kontrak Pho',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kBaKontrakPhoController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'BA Kontrak PHO',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kNomorProgresController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor Progres',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kTanggalProgresController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal Progres',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _kTotalProgresController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Penyedia tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Total Progres',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
