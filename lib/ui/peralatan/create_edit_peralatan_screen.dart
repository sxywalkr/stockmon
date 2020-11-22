import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/peralatan_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditPeralatanScreen extends StatefulWidget {
  @override
  _CreateEditPeralatanScreenState createState() =>
      _CreateEditPeralatanScreenState();
}

class _CreateEditPeralatanScreenState extends State<CreateEditPeralatanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PeralatanModel _peralatan;
  TextEditingController _xJenisController;
  TextEditingController _xMerkController;
  TextEditingController _xLokasiController;
  TextEditingController _xKapasitasController;
  TextEditingController _xJumlahController;
  TextEditingController _xStatusController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PeralatanModel _peralatanModel =
        ModalRoute.of(context).settings.arguments;
    if (_peralatanModel != null) {
      _peralatan = _peralatanModel;
    }

    _xJenisController = TextEditingController(
        text: _peralatan != null ? _peralatan.xJenis : '');
    _xMerkController =
        TextEditingController(text: _peralatan != null ? _peralatan.xMerk : '');
    _xLokasiController = TextEditingController(
        text: _peralatan != null ? _peralatan.xLokasi : '');
    _xKapasitasController = TextEditingController(
        text: _peralatan != null ? _peralatan.xKapasitas : '');
    _xJumlahController = TextEditingController(
        text: _peralatan != null ? _peralatan.xJumlah : '');
    _xStatusController = TextEditingController(
        text: _peralatan != null ? _peralatan.xStatus : '');
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
        title: Text(_peralatan != null ? 'Edit Peralatan' : 'Tambah Peralatan'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase.setPeralatan(PeralatanModel(
                    id: _peralatan != null
                        ? _peralatan.id
                        : documentIdFromCurrentDate(),
                    xJenis: _xJenisController.text,
                    xMerk: _xMerkController.text,
                    xLokasi: _xLokasiController.text,
                    xKapasitas: _xKapasitasController.text,
                    xJumlah: _xJumlahController.text,
                    xStatus: _xStatusController.text,
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
    _xJenisController.dispose();
    _xMerkController.dispose();
    _xLokasiController.dispose();
    _xKapasitasController.dispose();
    _xJumlahController.dispose();
    _xStatusController.dispose();

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
                'Data Peralatan',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xJenisController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (value) =>
                      value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Jenis',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xMerkController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Merk',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xLokasiController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
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
                  controller: _xKapasitasController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Kapasitas',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xJumlahController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Jumlah',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _xStatusController,
                  style: Theme.of(context).textTheme.bodyText1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Status',
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
