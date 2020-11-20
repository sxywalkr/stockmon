import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/mergr_penyedia_model.dart';
import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditMergrPenyediaScreen extends StatefulWidget {
  @override
  _CreateEditMergrPenyediaScreenState createState() =>
      _CreateEditMergrPenyediaScreenState();
}

class _CreateEditMergrPenyediaScreenState
    extends State<CreateEditMergrPenyediaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MergrPenyediaModel _mergrPenyedia;
  TextEditingController _aNamaBadanUsahaController;
  TextEditingController _xx1TempatController;
  TextEditingController _xx1WaktuController;
  TextEditingController _xx1NilaiPenawaranController;
  TextEditingController _xx1NomorSuratPenawaranController;
  TextEditingController _xx1InstansiPemberiTugasController;
  TextEditingController _xx1NamaPaketController;
  TextEditingController _xx1NomorUndanganController;
  TextEditingController _xx1TanggalUndanganController;
  TextEditingController _xx1JangkaWaktuController;
  TextEditingController _xx1MasaBerlakuController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MergrPenyediaModel _mergrPenyediaModel =
        ModalRoute.of(context).settings.arguments;
    if (_mergrPenyediaModel != null) {
      _mergrPenyedia = _mergrPenyediaModel;
    }

    _aNamaBadanUsahaController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.aNamaBadanUsaha : '');
    _xx1TempatController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1Tempat : '');
    _xx1WaktuController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1Waktu : '');
    _xx1NilaiPenawaranController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1NilaiPenawaran : '');
    _xx1NomorSuratPenawaranController = TextEditingController(
        text: _mergrPenyedia != null
            ? _mergrPenyedia.xx1NomorSuratPenawaran
            : '');
    _xx1InstansiPemberiTugasController = TextEditingController(
        text: _mergrPenyedia != null
            ? _mergrPenyedia.xx1InstansiPemberiTugas
            : '');
    _xx1NamaPaketController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1NamaPaket : '');
    _xx1NomorUndanganController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1NomorUndangan : '');
    _xx1TanggalUndanganController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1TanggalUndangan : '');
    _xx1JangkaWaktuController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1JangkaWaktu : '');
    _xx1MasaBerlakuController = TextEditingController(
        text: _mergrPenyedia != null ? _mergrPenyedia.xx1MasaBerlaku : '');
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
        title: Text(_mergrPenyedia != null
            ? 'Edit Mergr Penyedia'
            : 'Tambah Mergr Penyedia'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setMergrPenyedia(MergrPenyediaModel(
                    id: _mergrPenyedia != null
                        ? _mergrPenyedia.id
                        : documentIdFromCurrentDate(),
                    aNamaBadanUsaha: _aNamaBadanUsahaController.text,
                    xx1Tempat: _xx1TempatController.text,
                    xx1Waktu: _xx1WaktuController.text,
                    xx1NilaiPenawaran: _xx1NilaiPenawaranController.text,
                    xx1NomorSuratPenawaran:
                        _xx1NomorSuratPenawaranController.text,
                    xx1InstansiPemberiTugas:
                        _xx1InstansiPemberiTugasController.text,
                    xx1NamaPaket: _xx1NamaPaketController.text,
                    xx1NomorUndangan: _xx1NomorUndanganController.text,
                    xx1TanggalUndangan: _xx1TanggalUndanganController.text,
                    xx1JangkaWaktu: _xx1JangkaWaktuController.text,
                    xx1MasaBerlaku: _xx1MasaBerlakuController.text,
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
    _xx1TempatController.dispose();
    _xx1WaktuController.dispose();
    _xx1NilaiPenawaranController.dispose();
    _xx1NomorSuratPenawaranController.dispose();
    _xx1InstansiPemberiTugasController.dispose();
    _xx1NamaPaketController.dispose();
    _xx1NomorUndanganController.dispose();
    _xx1TanggalUndanganController.dispose();
    _xx1JangkaWaktuController.dispose();
    _xx1MasaBerlakuController.dispose();

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
              Text('Data Merger Penyedia'),
              _cbxPenyedia(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1TempatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
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
                  controller: _xx1WaktuController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
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
                  controller: _xx1NilaiPenawaranController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nilai Penawaran',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1NomorSuratPenawaranController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor Surat Penawaran',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1InstansiPemberiTugasController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Instansi Pemberi Tugas',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1NamaPaketController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
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
                  controller: _xx1NomorUndanganController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nomor Undangan',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1TanggalUndanganController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal Undangan',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1JangkaWaktuController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Jangka Waktu',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xx1MasaBerlakuController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Masa Berlaku',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cbxPenyedia(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.penyediasStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PenyediaModel> penyedias = snapshot.data;
          if (penyedias.isNotEmpty) {
            final aa = <String>[''];
            penyedias.forEach((element) {
              aa.add(element.aNamaBadanUsaha);
            });
            // print(aa);
            return DropdownButton<String>(
              value: _aNamaBadanUsahaController.text,
              onChanged: (String newValue) {
                setState(() {
                  _aNamaBadanUsahaController.text = newValue;
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
