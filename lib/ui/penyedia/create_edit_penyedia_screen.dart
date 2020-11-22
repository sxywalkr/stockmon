import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditPenyediaScreen extends StatefulWidget {
  @override
  _CreateEditPenyediaScreenState createState() =>
      _CreateEditPenyediaScreenState();
}

class _CreateEditPenyediaScreenState extends State<CreateEditPenyediaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PenyediaModel _penyedia;
  TextEditingController _aNamaBadanUsahaController;
  TextEditingController _aStatusController;
  TextEditingController _aAlamatPusatController;
  TextEditingController _aTelpPusatController;
  TextEditingController _aFaxPusatController;
  TextEditingController _aEmailPusatController;
  TextEditingController _bNomorController;
  TextEditingController _bTanggalController;
  TextEditingController _bNamaNotarisController;
  TextEditingController _bNomorPengesahanController;
  TextEditingController _cNamaController;
  TextEditingController _cNomorController;
  TextEditingController _cJabatanController;
  TextEditingController _dNomorController;
  TextEditingController _dTanggalController;
  TextEditingController _dMasaController;
  TextEditingController _dInstansiController;
  TextEditingController _eNomorController;
  TextEditingController _eTanggalController;
  TextEditingController _eMasaController;
  TextEditingController _eInstansiController;
  TextEditingController _eKualifikasiController;
  TextEditingController _eKlasifikasiController;
  TextEditingController _eSubKlasifikasiController;
  TextEditingController _fNomorController;
  TextEditingController _fTanggalController;
  TextEditingController _fMasaController;
  TextEditingController _fInstansiController;
  TextEditingController _g1NamaController;
  TextEditingController _g1IdentitasController;
  TextEditingController _g1AlamatController;
  TextEditingController _g1PersentaseController;
  TextEditingController _g2NpwpController;
  TextEditingController _g2NomorController;
  TextEditingController _g2TanggalController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PenyediaModel _penyediaModel =
        ModalRoute.of(context).settings.arguments;
    if (_penyediaModel != null) {
      _penyedia = _penyediaModel;
    }

    _aNamaBadanUsahaController = TextEditingController(
        text: _penyedia != null ? _penyedia.aNamaBadanUsaha : "");
    _aStatusController =
        TextEditingController(text: _penyedia != null ? _penyedia.aStatus : "");
    _aAlamatPusatController = TextEditingController(
        text: _penyedia != null ? _penyedia.aAlamatPusat : "");
    _aTelpPusatController = TextEditingController(
        text: _penyedia != null ? _penyedia.aTelpPusat : "");
    _aFaxPusatController = TextEditingController(
        text: _penyedia != null ? _penyedia.aFaxPusat : "");
    _aEmailPusatController = TextEditingController(
        text: _penyedia != null ? _penyedia.aEmailPusat : "");
    _bNomorController =
        TextEditingController(text: _penyedia != null ? _penyedia.bNomor : '');
    _bTanggalController = TextEditingController(
        text: _penyedia != null ? _penyedia.bTanggal : '');
    _bNamaNotarisController = TextEditingController(
        text: _penyedia != null ? _penyedia.bNamaNotaris : '');
    _bNomorPengesahanController = TextEditingController(
        text: _penyedia != null ? _penyedia.bNomorPengesahan : '');
    _cNamaController =
        TextEditingController(text: _penyedia != null ? _penyedia.cNama : '');
    _cNomorController =
        TextEditingController(text: _penyedia != null ? _penyedia.cNomor : '');
    _cJabatanController = TextEditingController(
        text: _penyedia != null ? _penyedia.cJabatan : '');
    _dNomorController =
        TextEditingController(text: _penyedia != null ? _penyedia.dNomor : '');
    _dTanggalController = TextEditingController(
        text: _penyedia != null ? _penyedia.dTanggal : '');
    _dMasaController =
        TextEditingController(text: _penyedia != null ? _penyedia.dMasa : '');
    _dInstansiController = TextEditingController(
        text: _penyedia != null ? _penyedia.dInstansi : '');
    _eNomorController =
        TextEditingController(text: _penyedia != null ? _penyedia.eNomor : '');
    _eTanggalController = TextEditingController(
        text: _penyedia != null ? _penyedia.eTanggal : '');
    _eMasaController =
        TextEditingController(text: _penyedia != null ? _penyedia.eMasa : '');
    _eInstansiController = TextEditingController(
        text: _penyedia != null ? _penyedia.eInstansi : '');
    _eKualifikasiController = TextEditingController(
        text: _penyedia != null ? _penyedia.eKualifikasi : '');
    _eKlasifikasiController = TextEditingController(
        text: _penyedia != null ? _penyedia.eKlasifikasi : '');
    _eSubKlasifikasiController = TextEditingController(
        text: _penyedia != null ? _penyedia.eSubKlasifikasi : '');
    _fNomorController =
        TextEditingController(text: _penyedia != null ? _penyedia.fNomor : '');
    _fTanggalController = TextEditingController(
        text: _penyedia != null ? _penyedia.fTanggal : '');
    _fMasaController =
        TextEditingController(text: _penyedia != null ? _penyedia.fMasa : '');
    _fInstansiController = TextEditingController(
        text: _penyedia != null ? _penyedia.fInstansi : '');
    _g1NamaController =
        TextEditingController(text: _penyedia != null ? _penyedia.g1Nama : '');
    _g1IdentitasController = TextEditingController(
        text: _penyedia != null ? _penyedia.g1Identitas : '');
    _g1AlamatController = TextEditingController(
        text: _penyedia != null ? _penyedia.g1Alamat : '');
    _g1PersentaseController = TextEditingController(
        text: _penyedia != null ? _penyedia.g1Persentase : '');
    _g2NpwpController =
        TextEditingController(text: _penyedia != null ? _penyedia.g2Npwp : '');
    _g2NomorController =
        TextEditingController(text: _penyedia != null ? _penyedia.g2Nomor : '');
    _g2TanggalController = TextEditingController(
        text: _penyedia != null ? _penyedia.g2Tanggal : '');
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
        title: Text(_penyedia != null ? 'Edit Penyedia' : 'Tambah Penyedia'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setPenyedia(PenyediaModel(
                    id: _penyedia != null
                        ? _penyedia.id
                        : documentIdFromCurrentDate(),
                    aNamaBadanUsaha: _aNamaBadanUsahaController.text,
                    aStatus: _aStatusController.text,
                    aAlamatPusat: _aAlamatPusatController.text,
                    aTelpPusat: _aTelpPusatController.text,
                    aFaxPusat: _aFaxPusatController.text,
                    aEmailPusat: _aEmailPusatController.text,
                    bNomor: _bNomorController.text,
                    bTanggal: _bTanggalController.text,
                    bNamaNotaris: _bNamaNotarisController.text,
                    bNomorPengesahan: _bNomorPengesahanController.text,
                    cNama: _cNamaController.text,
                    cNomor: _cNomorController.text,
                    cJabatan: _cJabatanController.text,
                    dNomor: _dNomorController.text,
                    dTanggal: _dTanggalController.text,
                    dMasa: _dMasaController.text,
                    dInstansi: _dInstansiController.text,
                    eNomor: _eNomorController.text,
                    eTanggal: _eTanggalController.text,
                    eMasa: _eMasaController.text,
                    eInstansi: _eInstansiController.text,
                    eKualifikasi: _eKualifikasiController.text,
                    eKlasifikasi: _eKlasifikasiController.text,
                    eSubKlasifikasi: _eSubKlasifikasiController.text,
                    fNomor: _fNomorController.text,
                    fTanggal: _fTanggalController.text,
                    fMasa: _fMasaController.text,
                    fInstansi: _fInstansiController.text,
                    g1Nama: _g1NamaController.text,
                    g1Identitas: _g1IdentitasController.text,
                    g1Alamat: _g1AlamatController.text,
                    g1Persentase: _g1PersentaseController.text,
                    g2Npwp: _g2NpwpController.text,
                    g2Nomor: _g2NomorController.text,
                    g2Tanggal: _g2TanggalController.text,
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
    _aNamaBadanUsahaController.dispose();
    _aStatusController.dispose();
    _aAlamatPusatController.dispose();
    _aTelpPusatController.dispose();
    _aFaxPusatController.dispose();
    _aEmailPusatController.dispose();
    _bNomorController.dispose();
    _bTanggalController.dispose();
    _bNamaNotarisController.dispose();
    _bNomorPengesahanController.dispose();
    _cNamaController.dispose();
    _cNomorController.dispose();
    _cJabatanController.dispose();
    _dNomorController.dispose();
    _dTanggalController.dispose();
    _dMasaController.dispose();
    _dInstansiController.dispose();
    _eNomorController.dispose();
    _eTanggalController.dispose();
    _eMasaController.dispose();
    _eInstansiController.dispose();
    _eKualifikasiController.dispose();
    _eKlasifikasiController.dispose();
    _eSubKlasifikasiController.dispose();
    _fNomorController.dispose();
    _fTanggalController.dispose();
    _fMasaController.dispose();
    _fInstansiController.dispose();
    _g1NamaController.dispose();
    _g1IdentitasController.dispose();
    _g1AlamatController.dispose();
    _g1PersentaseController.dispose();
    _g2NpwpController.dispose();
    _g2NomorController.dispose();
    _g2TanggalController.dispose();
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
              Text(
                'A.	Data Administrasi',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _aNamaBadanUsahaController,
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
                  controller: _aStatusController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Status tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Status',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _aAlamatPusatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Alamat tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Alamat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _aTelpPusatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Telp tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Telp',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _aFaxPusatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Fax tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Fax',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _aEmailPusatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'B.	Landasan Hukum Pendirian Badan Usaha',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _bNomorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _bTanggalController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _bNamaNotarisController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama Notaris',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _bNomorPengesahanController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor Pengesahan',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'C.	Pengurus Badan Usaha',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _cNamaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _cNomorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _cJabatanController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Jabatan',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'D. Izin Usaha',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _dNomorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _dTanggalController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _dMasaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Masa',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _dInstansiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Instansi',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'E. Sertifikat Badan Usaha',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _eNomorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _eTanggalController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _eMasaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Masa',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _eInstansiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Instansi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _eKualifikasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Kualifikasi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _eKlasifikasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
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
                  controller: _eSubKlasifikasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Sub Klasifikasi',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'F. Sertifikat Lainnya (Apabila disyaratkan)',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _fNomorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _fTanggalController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _fMasaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Masa',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _fInstansiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Instansi',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'G. Data Keuangan',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                'G. 1. Susunan Kepemilikan Saham',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g1NamaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g1IdentitasController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Identitas',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g1AlamatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Alamat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g1PersentaseController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Persentase',
                  ),
                ),
              ),
              Text(
                'G. 2. Pajak',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g2NpwpController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'NPWP',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g2NomorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _g2TanggalController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal',
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
