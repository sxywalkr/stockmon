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
