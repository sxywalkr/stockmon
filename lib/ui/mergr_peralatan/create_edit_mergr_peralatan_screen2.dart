import 'package:flutter/material.dart';
// import 'package:mergers/app_localizations.dart';
import 'package:mergers/models/peralatan_model.dart';
import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/models/mergr_penyedia_model.dart';
import 'package:mergers/models/mergr_peralatan_detail_model.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

class CreateEditMergrPeralatanScreen extends StatefulWidget {
  @override
  _CreateEditMergrPeralatanScreenState createState() =>
      _CreateEditMergrPeralatanScreenState();
}

class _CreateEditMergrPeralatanScreenState
    extends State<CreateEditMergrPeralatanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MergrPenyediaModel _mergrPenyedia;
  MergrPeralatanDetailModel _mergrPeralatanDetail;
  TextEditingController _aNamaBadanUsahaController;
  TextEditingController _xJenisController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MergrPeralatanDetailModel _mergrPeralatanDetailModel =
        ModalRoute.of(context).settings.arguments;
    if (_mergrPeralatanDetailModel != null) {
      _mergrPeralatanDetail = _mergrPeralatanDetailModel;
    }

    _xJenisController = TextEditingController(
        text:
            _mergrPeralatanDetail != null ? _mergrPeralatanDetail.xJenis : '');
    _aNamaBadanUsahaController = TextEditingController(
        text: _mergrPeralatanDetail != null
            ? _mergrPeralatanDetail.aNamaBadanUsaha
            : '');
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
        title: Text(_mergrPeralatanDetail != null
            ? 'Edit Merger Peralatan'
            : 'Tambah Merger Peralatan'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final firestoreDatabase =
                      Provider.of<FirestoreDatabase>(context, listen: false);

                  firestoreDatabase
                      .setMergrPeralatanDetail(MergrPeralatanDetailModel(
                    id: _mergrPeralatanDetail != null
                        ? _mergrPeralatanDetail.id
                        : documentIdFromCurrentDate(),
                    aNamaBadanUsaha: _aNamaBadanUsahaController.text,
                    xJenis: _xJenisController.text,
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
              Text('Data Peralatan'),
              _cbxPenyedia(context),
              _cbxPeralatan(context),
              _btnAddMergrPeralatanDetail(context),
              _listPeralatanTerpilih(context),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: TextFormField(
              //     controller: _xJenisController,
              //     style: Theme.of(context).textTheme.bodyText1,
              //     validator: (value) =>
              //         value.isEmpty ? 'Jenis tidak boleh kosong' : null,
              //     decoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //               color: Theme.of(context).iconTheme.color,
              //               width: 2)),
              //       labelText: 'Jenis',
              //     ),
              //   ),
              // ),
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
          List<MergrPenyediaModel> penyedias = snapshot.data;
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

  Widget _btnAddMergrPeralatanDetail(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          FocusScope.of(context).unfocus();

          final firestoreDatabase =
              Provider.of<FirestoreDatabase>(context, listen: false);

          firestoreDatabase.setMergrPeralatanDetail(MergrPeralatanDetailModel(
            id: _mergrPeralatanDetail != null
                ? _mergrPeralatanDetail.id
                : documentIdFromCurrentDate(),
            aNamaBadanUsaha: _aNamaBadanUsahaController.text,
            xJenis: _xJenisController.text,
          ));
        }
      },
      child: Text("Tambah Data Peratalan"),
    );
  }

  Widget _listPeralatanTerpilih(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.mergrPeralatanDetailsStream(),
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
