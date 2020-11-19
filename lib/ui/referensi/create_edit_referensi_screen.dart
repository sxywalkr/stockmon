import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mergers/models/mergr_penyedia_model.dart';
// import 'package:mergers/models/mergr_personel_detail_model.dart';
import 'package:mergers/models/referensi_model.dart';
import 'package:mergers/models/personel_model.dart';
// import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditReferensiScreen extends StatefulWidget {
  @override
  _CreateEditReferensiScreenState createState() =>
      _CreateEditReferensiScreenState();
}

class _CreateEditReferensiScreenState extends State<CreateEditReferensiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ReferensiModel _referensi;
  TextEditingController _xxx1NamaController;
  TextEditingController _xxx1AlamatController;
  TextEditingController _xxx1JabatanController;
  TextEditingController _xxx1NomorSuratController;
  TextEditingController _xxx1NamaKontrakController;
  TextEditingController _xxx1NomorKontrakController;
  TextEditingController _xxx1InstansiController;
  TextEditingController _xxx1PeriodeController;
  TextEditingController _xxx1TempatController;
  TextEditingController _xxx1WaktuController;
  TextEditingController _xxx1NamaPejabatController;
  TextEditingController _xxx1NipPejabatController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ReferensiModel _referensiModel =
        ModalRoute.of(context).settings.arguments;
    if (_referensiModel != null) {
      _referensi = _referensiModel;
    }

    _xxx1NamaController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Nama : '');
    _xxx1AlamatController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Alamat : '');
    _xxx1JabatanController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Jabatan : '');
    _xxx1NomorSuratController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1NomorSurat : '');
    _xxx1NamaKontrakController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1NamaKontrak : '');
    _xxx1NomorKontrakController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1NomorKontrak : '');
    _xxx1InstansiController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Instansi : '');
    _xxx1PeriodeController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Periode : '');
    _xxx1TempatController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Tempat : '');
    _xxx1WaktuController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1Waktu : '');
    _xxx1NamaPejabatController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1NamaPejabat : '');
    _xxx1NipPejabatController = TextEditingController(
        text: _referensi != null ? _referensi.xxx1NipPejabat : '');
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
        title: Text(_referensi != null ? 'Edit Referensi' : 'Tambah Referensi'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setReferensi(ReferensiModel(
                    id: _referensi != null
                        ? _referensi.id
                        : documentIdFromCurrentDate(),
                    xxx1Nama: _xxx1NamaController.text,
                    xxx1Alamat: _xxx1AlamatController.text,
                    xxx1Jabatan: _xxx1JabatanController.text,
                    xxx1NomorSurat: _xxx1NomorSuratController.text,
                    xxx1NamaKontrak: _xxx1NamaKontrakController.text,
                    xxx1NomorKontrak: _xxx1NomorKontrakController.text,
                    xxx1Instansi: _xxx1InstansiController.text,
                    xxx1Periode: _xxx1PeriodeController.text,
                    xxx1Tempat: _xxx1TempatController.text,
                    xxx1Waktu: _xxx1WaktuController.text,
                    xxx1NamaPejabat: _xxx1NamaPejabatController.text,
                    xxx1NipPejabat: _xxx1NipPejabatController.text,
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
    _xxx1NamaController.dispose();
    _xxx1AlamatController.dispose();
    _xxx1JabatanController.dispose();
    _xxx1NomorSuratController.dispose();
    _xxx1NamaKontrakController.dispose();
    _xxx1NomorKontrakController.dispose();
    _xxx1InstansiController.dispose();
    _xxx1PeriodeController.dispose();
    _xxx1TempatController.dispose();
    _xxx1WaktuController.dispose();
    _xxx1NamaPejabatController.dispose();
    _xxx1NipPejabatController.dispose();

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
                'Data Referensi',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Pilih Personel',
                style: Theme.of(context).textTheme.caption,
              ),
              _cbxPersonel(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1AlamatController,
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
                  controller: _xxx1JabatanController,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1NomorSuratController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor Surat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1NamaKontrakController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama Kontrak',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1NomorKontrakController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
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
                  controller: _xxx1InstansiController,
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
                  controller: _xxx1PeriodeController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Periode',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1TempatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tempat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1WaktuController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Waktu',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xxx1NamaPejabatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
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
                  controller: _xxx1NipPejabatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Email tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'NIP Pejabat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cbxPersonel(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.personelsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PersonelModel> personels = snapshot.data;
          if (personels.isNotEmpty) {
            final aa = <String>[''];
            personels.forEach((element) {
              aa.add(element.hNama);
            });

            return DropdownButton<String>(
              value: _xxx1NamaController.text,
              onChanged: (String newValue) {
                setState(() {
                  _xxx1NamaController.text = newValue;
                });
              },
              items: aa.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
