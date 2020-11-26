import 'package:flutter/material.dart';
// import 'package:stockmon/app_localizations.dart';
// import 'package:stockmon/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockmon/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:stockmon/models/stok_brg_keluar_model.dart';
import 'package:stockmon/models/stok_brg_aktif_model.dart';

class CreateEditAppUserScreen extends StatefulWidget {
  @override
  _CreateEditAppUserScreenState createState() =>
      _CreateEditAppUserScreenState();
}

class _CreateEditAppUserScreenState extends State<CreateEditAppUserScreen> {
  //init
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  StokBarangKeluarModel _stokBarangKeluar;
  String ___uid = '';
  String ___mode = '';
  TextEditingController _cbxStokBarangAktifController;
  TextEditingController _namaBarangController;
  TextEditingController _jumlahController;
  TextEditingController _harga1Controller;
  TextEditingController _harga2Controller;
  TextEditingController _tanggalBeliController;
  TextEditingController _tag1Controller;
  TextEditingController _tag2Controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final StokBarangKeluarModel _stokBarangKeluarModel =
        ModalRoute.of(context).settings.arguments;
    if (_stokBarangKeluarModel != null) {
      _stokBarangKeluar = _stokBarangKeluarModel;
    }

    _cbxStokBarangAktifController = TextEditingController(text: 'New');

    _namaBarangController = TextEditingController(
        text: _stokBarangKeluar != null ? _stokBarangKeluar.namaBarang : '');
    _jumlahController = TextEditingController(
        text: _stokBarangKeluar != null
            ? _stokBarangKeluar.jumlah.toString()
            : '');
    _harga1Controller = TextEditingController(
        text: _stokBarangKeluar != null
            ? _stokBarangKeluar.harga1.toStringAsFixed(0)
            : '');
    _harga2Controller = TextEditingController(
        text: _stokBarangKeluar != null
            ? _stokBarangKeluar.harga2.toStringAsFixed(0)
            : '');
    _tanggalBeliController = TextEditingController(
        text: _stokBarangKeluar != null
            ? _stokBarangKeluar.tanggalJual
            : DateTime.now().toIso8601String());
    _tag1Controller = TextEditingController(
        text: _stokBarangKeluar != null ? _stokBarangKeluar.tag1 : '');
    _tag2Controller = TextEditingController(
        text: _stokBarangKeluar != null ? _stokBarangKeluar.tag2 : '');
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
        title: Text('Form Pembelian'),
        actions: <Widget>[
          FlatButton(
            child: Text("Simpan"),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                FocusScope.of(context).unfocus();

                final firestoreDatabase =
                    Provider.of<FirestoreDatabase>(context, listen: false);

                final _uid = _stokBarangKeluar != null
                    ? _stokBarangKeluar.id
                    : generateUid();

                firestoreDatabase.setStokBarangKeluar(StokBarangKeluarModel(
                  id: _stokBarangKeluar != null
                      ? _stokBarangKeluar.id
                      : documentIdFromCurrentDate(),
                  uidBarang: _uid,
                  namaBarang: _namaBarangController.text,
                  jumlah: int.tryParse(_jumlahController.text),
                  harga1: double.tryParse(_harga1Controller.text),
                  harga2: double.tryParse(_harga1Controller.text),
                  tanggalJual: _tanggalBeliController.text,
                  tag1: 'tag1',
                  tag2: 'tag2',
                ));

                // if ((_stokBarangKeluar == null && ___mode == '') ||
                //     ___mode == 'add') {
                //   firestoreDatabase.setStokBarangAktif(StokBarangAktifModel(
                //     uidBarang: _uid,
                //     namaBarang: _namaBarangController.text,
                //     jumlah: int.tryParse(_jumlahController.text),
                //     harga1: double.tryParse(_harga1Controller.text),
                //     harga2: double.tryParse(_harga1Controller.text),
                //     tanggalBeli: _tanggalBeliController.text,
                //     tag1: 'tag1',
                //     tag2: 'tag2',
                //   ));
                // }
                await _updateStok(
                  firestoreDatabase,
                  int.tryParse(_jumlahController.text),
                  // double.tryParse(_harga1Controller.text),
                  // double.tryParse(_harga1Controller.text),
                );

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Container(
        child: _buildForm(context),
      ),
    );
  }

  @override
  void dispose() {
    _cbxStokBarangAktifController.dispose();
    _namaBarangController.dispose();
    _jumlahController.dispose();
    _harga1Controller.dispose();
    _harga2Controller.dispose();
    _tanggalBeliController.dispose();
    _tag1Controller.dispose();
    _tag2Controller.dispose();

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
              _stokBarangKeluar != null
                  ? Container()
                  : _cbxstokBarangAktif(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _namaBarangController,
                  enabled: false,
                  // style: Theme.of(context).textTheme.body1,
                  // validator: (value) =>
                  //     value.isEmpty ? 'Nama Barang tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Nama Barang',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _jumlahController,
                  enabled: _stokBarangKeluar != null ? false : true,
                  // style: Theme.of(context).textTheme.body1,
                  validator: (value) =>
                      value.isEmpty ? 'Jumlah Barang tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Jumlah Barang',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _tanggalBeliController,
                  enabled: false,
                  // style: Theme.of(context).textTheme.body1,
                  // validator: (value) => value.isEmpty
                  //     ? 'Jumlah Barang tidak boleh kosong'
                  //     : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: 'Tanggal Beli Barang',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cbxstokBarangAktif(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.stokBarangAktifsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<StokBarangAktifModel> stokBarangAktif = snapshot.data;
          if (stokBarangAktif.isNotEmpty) {
            final aa = <String>['New'];
            stokBarangAktif.forEach((element) {
              aa.add(element.namaBarang);
            });
            // print(aa);
            return DropdownButton<String>(
              value: _cbxStokBarangAktifController.text,
              onChanged: (String newValue) async {
                if (newValue != null) {
                  Map<String, dynamic> data1 = {};
                  final qSnap1 = await Firestore.instance
                      .collection('stokBarangAktifs')
                      .where('namaBarang', isEqualTo: newValue)
                      .getDocuments();
                  for (DocumentSnapshot ds in qSnap1.documents) {
                    data1 = ds.data;
                  }
                  _namaBarangController.text =
                      newValue != 'New' ? data1['namaBarang'] : '';
                  _jumlahController.text = '';
                  _harga1Controller.text = newValue != 'New'
                      ? data1['harga1'].toStringAsFixed(0)
                      : '';
                  _tanggalBeliController.text =
                      DateTime.now().toIso8601String();

                  setState(() {
                    _cbxStokBarangAktifController.text = newValue;
                    ___uid = data1['uidBarang'];
                    ___mode = newValue != 'New' ? 'update' : 'add';
                  });
                  // print(___uid);
                }
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
        // return Center(child: CircularProgressIndicator());
        return Center(child: Container());
      },
    );
  }

  Future<void> _updateStok(
    FirestoreDatabase firestoreDatabase,
    int jumlah,
  ) async {
    if (___mode == 'update') {
      final dbReference = Firestore.instance;

      Map<String, dynamic> data1 = {};
      final qSnap1 = await dbReference
          .collection("stokBarangAktifs")
          .where('uidBarang', isEqualTo: ___uid)
          .getDocuments();
      for (DocumentSnapshot ds in qSnap1.documents) {
        data1 = ds.data;
      }

      dbReference.collection('stokBarangAktifs').document(___uid).updateData(
        {
          'jumlah': data1['jumlah'] - jumlah,
        },
      );
    }
  }
}
