import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/pengalaman_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditPengalamanScreen extends StatefulWidget {
  @override
  _CreateEditPengalamanScreenState createState() =>
      _CreateEditPengalamanScreenState();
}

class _CreateEditPengalamanScreenState
    extends State<CreateEditPengalamanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PengalamanModel _pengalaman;
  TextEditingController _iNamaPenyediaController;
  TextEditingController _iNamaPaketController;
  TextEditingController _iKlasifikasiController;
  TextEditingController _iSubKlasifikasiController;
  TextEditingController _iLingkupController;
  TextEditingController _iLokasiController;
  TextEditingController _iNamaPejabatController;
  TextEditingController _iAlamatPejabatController;
  TextEditingController _iTeleponPejabatController;
  TextEditingController _iNomorKontrakController;
  TextEditingController _iTanggalKontrakController;
  TextEditingController _iNilaiKontrakController;
  TextEditingController _iTanggalKontrakPhoController;
  TextEditingController _iBaKontrakPhoController;
  TextEditingController _iNomorProgresController;
  TextEditingController _iTanggalProgresController;
  TextEditingController _iTotalProgresController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PengalamanModel _pengalamanModel =
        ModalRoute.of(context).settings.arguments;
    if (_pengalamanModel != null) {
      _pengalaman = _pengalamanModel;
    }

    _iNamaPenyediaController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iNamaPenyedia : '');
    _iNamaPaketController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iNamaPaket : '');
    _iKlasifikasiController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iKlasifikasi : '');
    _iSubKlasifikasiController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iSubKlasifikasi : '');
    _iLingkupController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iLingkup : '');
    _iLokasiController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iLokasi : '');
    _iNamaPejabatController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iNamaPejabat : '');
    _iAlamatPejabatController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iAlamatPejabat : '');
    _iTeleponPejabatController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iTeleponPejabat : '');
    _iNomorKontrakController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iNomorKontrak : '');
    _iTanggalKontrakController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iTanggalKontrak : '');
    _iNilaiKontrakController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iNilaiKontrak : '');
    _iTanggalKontrakPhoController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iTanggalKontrakPho : '');
    _iBaKontrakPhoController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iBaKontrakPho : '');
    _iNomorProgresController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iNomorProgres : '');
    _iTanggalProgresController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iTanggalProgres : '');
    _iTotalProgresController = TextEditingController(
        text: _pengalaman != null ? _pengalaman.iTotalProgres : '');
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
        title:
            Text(_pengalaman != null ? 'Edit Pengalaman' : 'Tambah Pengalaman'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setPengalaman(PengalamanModel(
                    id: _pengalaman != null
                        ? _pengalaman.id
                        : documentIdFromCurrentDate(),
                    iNamaPenyedia: _iNamaPenyediaController.text,
                    iNamaPaket: _iNamaPaketController.text,
                    iKlasifikasi: _iKlasifikasiController.text,
                    iSubKlasifikasi: _iSubKlasifikasiController.text,
                    iLingkup: _iLingkupController.text,
                    iLokasi: _iLokasiController.text,
                    iNamaPejabat: _iNamaPejabatController.text,
                    iAlamatPejabat: _iAlamatPejabatController.text,
                    iTeleponPejabat: _iTeleponPejabatController.text,
                    iNomorKontrak: _iNomorKontrakController.text,
                    iTanggalKontrak: _iTanggalKontrakController.text,
                    iNilaiKontrak: _iNilaiKontrakController.text,
                    iTanggalKontrakPho: _iTanggalKontrakPhoController.text,
                    iBaKontrakPho: _iBaKontrakPhoController.text,
                    iNomorProgres: _iNomorProgresController.text,
                    iTanggalProgres: _iTanggalProgresController.text,
                    iTotalProgres: _iTotalProgresController.text,
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
    _iNamaPenyediaController.dispose();
    _iNamaPaketController.dispose();
    _iKlasifikasiController.dispose();
    _iSubKlasifikasiController.dispose();
    _iLingkupController.dispose();
    _iLokasiController.dispose();
    _iNamaPejabatController.dispose();
    _iAlamatPejabatController.dispose();
    _iTeleponPejabatController.dispose();
    _iNomorKontrakController.dispose();
    _iTanggalKontrakController.dispose();
    _iNilaiKontrakController.dispose();
    _iTanggalKontrakPhoController.dispose();
    _iBaKontrakPhoController.dispose();
    _iNomorProgresController.dispose();
    _iTanggalProgresController.dispose();
    _iTotalProgresController.dispose();

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
                  controller: _iNamaPenyediaController,
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
                  controller: _iNamaPaketController,
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
                  controller: _iKlasifikasiController,
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
                  controller: _iSubKlasifikasiController,
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
                  controller: _iLingkupController,
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
                  controller: _iLokasiController,
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
                  controller: _iNamaPejabatController,
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
                  controller: _iAlamatPejabatController,
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
                  controller: _iTeleponPejabatController,
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
                  controller: _iNomorKontrakController,
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
                  controller: _iTanggalKontrakController,
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
                  controller: _iNilaiKontrakController,
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
                  controller: _iTanggalKontrakPhoController,
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
                  controller: _iBaKontrakPhoController,
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
                  controller: _iNomorProgresController,
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
                  controller: _iTanggalProgresController,
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
                  controller: _iTotalProgresController,
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
