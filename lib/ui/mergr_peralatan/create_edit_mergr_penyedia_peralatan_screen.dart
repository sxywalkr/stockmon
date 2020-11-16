import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergers/models/mergr_penyedia_model.dart';
import 'package:mergers/models/mergr_peralatan_detail_model.dart';
import 'package:mergers/models/peralatan_model.dart';
import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditMergrPenyediaPeralatanScreen extends StatefulWidget {
  @override
  _CreateEditMergrPenyediaPeralatanScreenState createState() =>
      _CreateEditMergrPenyediaPeralatanScreenState();
}

class _CreateEditMergrPenyediaPeralatanScreenState
    extends State<CreateEditMergrPenyediaPeralatanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MergrPenyediaModel _mergrPenyedia;
  TextEditingController _aNamaBadanUsahaController;
  TextEditingController _xx1TempatController;
  TextEditingController _xx1WaktuController;
  TextEditingController _xJenisController;

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
    _xJenisController =
        TextEditingController(text: _mergrPenyedia != null ? '' : '');
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
            ? 'Edit Mergr Penyedia/Peralatan'
            : 'Tambah Mergr Penyedia/Peralatan'),
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
    _xJenisController.dispose();

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
              Text('Data Merger Penyedia Peralatan'),
              Text(
                'Penyedia',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              _cbxPenyedia(context),
              _cbxPeralatan(context),
              _btnAddMergrPeralatanDetail(context),
              Text(
                'Peralatan Terpilih',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              _listPeralatanTerpilih(context),
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

  Widget _btnAddMergrPeralatanDetail(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          FocusScope.of(context).unfocus();

          final firestoreDatabase =
              Provider.of<FirestoreDatabase>(context, listen: false);

          firestoreDatabase.setMergrPeralatanDetail(MergrPeralatanDetailModel(
            id: documentIdFromCurrentDate(),
            aNamaBadanUsaha: _aNamaBadanUsahaController.text,
            xJenis: _xJenisController.text,
          ));
        }
      },
      child: Text("Tambah Data Peratalan"),
    );
  }

  Widget _cbxPeralatan(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.peralatansStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PeralatanModel> peralatans = snapshot.data;
          if (peralatans.isNotEmpty) {
            final aa = <String>[''];
            peralatans.forEach((element) {
              aa.add(element.xJenis);
            });
            // print(aa);
            return DropdownButton<String>(
              value: _xJenisController.text,
              onChanged: (String newValue) {
                setState(() {
                  _xJenisController.text = newValue;
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

  Widget _listPeralatanTerpilih(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.mergrPeralatanDetailStream(
          qPenyedia: _aNamaBadanUsahaController.text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MergrPeralatanDetailModel> mergrPeralatanDetail = snapshot.data;
          if (mergrPeralatanDetail.isNotEmpty) {
            // data start here
            return Container(
              height: 100,
              child: ListView.separated(
                itemCount: mergrPeralatanDetail.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        'dismissable',
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      )),
                    ),
                    key: Key(mergrPeralatanDetail[index].id),
                    child: ListTile(
                      title: Text(mergrPeralatanDetail[index].xJenis),
                      onTap: () {},
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.5);
                },
              ),
            );
            // data end here
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
