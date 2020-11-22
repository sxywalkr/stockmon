import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/personel_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditPersonelScreen extends StatefulWidget {
  @override
  _CreateEditPersonelScreenState createState() =>
      _CreateEditPersonelScreenState();
}

class _CreateEditPersonelScreenState extends State<CreateEditPersonelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PersonelModel _personel;
  TextEditingController _hNamaController;
  TextEditingController _hPendidikanController;
  TextEditingController _hJabatanController;
  TextEditingController _hPengalamanController;
  TextEditingController _hSertifikatController;
  TextEditingController _hSetorController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PersonelModel _personelModel =
        ModalRoute.of(context).settings.arguments;
    if (_personelModel != null) {
      _personel = _personelModel;
    }

    _hNamaController =
        TextEditingController(text: _personel != null ? _personel.hNama : '');
    _hPendidikanController = TextEditingController(
        text: _personel != null ? _personel.hPendidikan : '');
    _hJabatanController = TextEditingController(
        text: _personel != null ? _personel.hJabatan : '');
    _hPengalamanController = TextEditingController(
        text: _personel != null ? _personel.hPengalaman : '');
    _hSertifikatController = TextEditingController(
        text: _personel != null ? _personel.hSertifikat : '');
    _hSetorController =
        TextEditingController(text: _personel != null ? _personel.hSetor : '');
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
        title: Text(_personel != null ? 'Edit Personel' : 'Tambah Personel'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setPersonel(PersonelModel(
                    id: _personel != null
                        ? _personel.id
                        : documentIdFromCurrentDate(),
                    hNama: _hNamaController.text,
                    hPendidikan: _hPendidikanController.text,
                    hJabatan: _hJabatanController.text,
                    hPengalaman: _hPengalamanController.text,
                    hSertifikat: _hSertifikatController.text,
                    hSetor: _hSetorController.text,
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
    _hNamaController.dispose();
    _hPendidikanController.dispose();
    _hJabatanController.dispose();
    _hPengalamanController.dispose();
    _hSertifikatController.dispose();
    _hSetorController.dispose();

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
                'H. Data Personel',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _hNamaController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Nama Personel tidak boleh kosong' : null,
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
                  controller: _hPendidikanController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Personel tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Pendidikan',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _hJabatanController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Personel tidak boleh kosong' : null,
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
                  controller: _hPengalamanController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Personel tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Pengalaman',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _hSertifikatController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Personel tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Sertifikat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _hSetorController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Personel tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Bukti Setor Pajak',
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
