import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergers/models/mergr_penyedia_model.dart';
import 'package:mergers/models/mergr_personel_detail_model.dart';
import 'package:mergers/models/personel_model.dart';
import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditMergrPenyediaPersonelScreen extends StatefulWidget {
  @override
  _CreateEditMergrPenyediaPersonelScreenState createState() =>
      _CreateEditMergrPenyediaPersonelScreenState();
}

class _CreateEditMergrPenyediaPersonelScreenState
    extends State<CreateEditMergrPenyediaPersonelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MergrPenyediaModel _mergrPenyedia;
  TextEditingController _aNamaBadanUsahaController;
  TextEditingController _xx1TempatController;
  TextEditingController _xx1WaktuController;
  TextEditingController _xhNamaController;

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
    _xhNamaController =
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
            ? 'Edit Mergr Penyedia/Personel'
            : 'Tambah Mergr Penyedia/Personel'),
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
    _xhNamaController.dispose();

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
                'Data Merger Penyedia Personel',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Penyedia',
                style: Theme.of(context).textTheme.caption,
              ),
              _cbxPenyedia(context),
              Text(
                'Pilih Personel',
                style: Theme.of(context).textTheme.caption,
              ),
              _cbxPersonel(context),
              _btnAddMergrPersonelDetail(context),
              Text(
                'Personel Terpilih',
                style: Theme.of(context).textTheme.caption,
              ),
              _listPersonelTerpilih(context),
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

  Widget _btnAddMergrPersonelDetail(BuildContext context) {
    return FlatButton(
      color: Theme.of(context).accentColor,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          FocusScope.of(context).unfocus();

          final firestoreDatabase =
              Provider.of<FirestoreDatabase>(context, listen: false);

          firestoreDatabase.setMergrPersonel(MergrPersonelModel(
            id: documentIdFromCurrentDate(),
            aNamaBadanUsaha: _aNamaBadanUsahaController.text,
            xhNama: _xhNamaController.text,
          ));
        }
      },
      child: Text("Tambah Data Personel"),
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
              value: _xhNamaController.text,
              onChanged: (String newValue) {
                setState(() {
                  _xhNamaController.text = newValue;
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

  Widget _listPersonelTerpilih(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.mergrPersonelByQ1Stream(
          query1: _aNamaBadanUsahaController.text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MergrPersonelModel> mergrPersonel = snapshot.data;
          if (mergrPersonel.isNotEmpty) {
            // data start here
            return Container(
              color: Colors.black12,
              height: 270,
              child: ListView.separated(
                itemCount: mergrPersonel.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        'Geser untuk hapus',
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      )),
                    ),
                    key: Key(mergrPersonel[index].id),
                    onDismissed: (direction) {
                      firestoreDatabase
                          .deleteMergrPersonel(mergrPersonel[index]);

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).appBarTheme.color,
                        content: Text(
                          'Hapus ' + mergrPersonel[index].xhNama,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Batal',
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            firestoreDatabase
                                .setMergrPersonel(mergrPersonel[index]);
                          },
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(mergrPersonel[index].xhNama),
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
