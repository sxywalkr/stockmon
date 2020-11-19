import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergers/routes.dart';
import 'package:mergers/services/firestore_database.dart';
// import 'package:mergers/services/firestore_service.dart';
import 'package:provider/provider.dart';

// import 'package:mergers/models/peralatan_model.dart';
import 'package:mergers/models/mergr_penyedia_model.dart';
// import 'package:mergers/models/mergr_peralatan_detail_model.dart';
import 'package:mergers/ui/mergr_personel/empty_content.dart';

import 'package:mergers/ui/drawer/app_drawer.dart';
import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum PrintOpt {
  PrintPersonel,
  PrintReferensi,
}

class MergrPersonelScreen extends StatefulWidget {
  @override
  _MergrPersonelScreenState createState() => _MergrPersonelScreenState();
}

class _MergrPersonelScreenState extends State<MergrPersonelScreen> {
  var printOption = PrintOpt.PrintPersonel;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Merger Doc Personel'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_mergr_penyedia_personel,
          );
        },
      ),
      body: WillPopScope(
          onWillPop: () async => false, child: _buildBodySection(context)),
    );
  }

  Widget _buildBodySection(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
        stream: firestoreDatabase.mergrPenyediasStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MergrPenyediaModel> mergrPenyedia = snapshot.data;
            if (mergrPenyedia.isNotEmpty) {
              return ListView.separated(
                itemCount: mergrPenyedia.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)
                            .translate("todosDismissibleMsgTxt"),
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      )),
                    ),
                    key: Key(mergrPenyedia[index].id),
                    child: ListTile(
                      title: Text(mergrPenyedia[index].aNamaBadanUsaha),
                      trailing: _printOpt(
                          context, mergrPenyedia[index].aNamaBadanUsaha),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_mergr_penyedia_personel,
                            arguments: mergrPenyedia[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.5);
                },
              );
            } else {
              return EmptyContentWidget(
                title: 'Tidak ada data merger personel',
                message: 'Tap + untuk menambah merger personel',
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: AppLocalizations.of(context)
                  .translate("peralatanErrorTopMsgTxt"),
              message: AppLocalizations.of(context)
                  .translate("peralatanErrorBottomMsgTxt"),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _printOpt(BuildContext context, String a) {
    return PopupMenuButton(
      onSelected: (PrintOpt selectedValue) {
        if (selectedValue == PrintOpt.PrintPersonel) {
          genDocxPersonel(context, a);
        } else if (selectedValue == PrintOpt.PrintReferensi) {
          genDocxReferensi(context, a);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Doc Personel'),
          value: PrintOpt.PrintPersonel,
        ),
        PopupMenuItem(
          child: Text('Doc Referensi'),
          value: PrintOpt.PrintReferensi,
        ),
      ],
      icon: Icon(Icons.more_vert),
    );
  }

  void genDocxPersonel(BuildContext context, String q1) async {
    // **** data1
    Map<String, dynamic> data1 = {};
    final qSnap1 = await Firestore.instance
        .collection('mergrPenyedia')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap1.documents) {
      data1 = ds.data;
    }
    // print(data1['xx1Tempat']);

    // **** data2
    Map<String, dynamic> data2 = {};
    final qSnap2 = await Firestore.instance
        .collection('masterPenyedia')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap2.documents) {
      data2 = ds.data;
    }
    // print(data2['cNama']);

    // **** data3
    List<Map<String, dynamic>> data3 = [];
    final qSnap3 = await Firestore.instance
        .collection('mergrPersonel')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap3.documents) {
      data3.add(ds.data);
      print(data3);
    }
    // print('data3.length >> ${data3.length}');
    // print(data3);

    // start mergr doc
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result == null) {
      print('no file selected');
    }
    File file = File(result.files.single.path);
    // print(file.absolute);
    final docx = await DocxTemplate.fromBytes(await file.readAsBytes());
    try {
      Content c = Content();

      List<RowContent> aRow = [];
      for (int i = 0; i < data3.length; i++) {
        // **** data
        List<Map<String, dynamic>> data4 = [];
        final qSnap4 = await Firestore.instance
            .collection('masterPersonel')
            .where('hNama', isEqualTo: data3[i]['xhNama'])
            .getDocuments();
        for (DocumentSnapshot ds in qSnap4.documents) {
          data4.add(ds.data);
          // print(data4);
        }
        aRow.add(
          RowContent()
            ..add(TextContent("xxNo", i + 1))
            ..add(TextContent("xxNama", data3[i]['xhNama']))
            ..add(TextContent("xxPendidikan", data4[0]['hPendidikan']))
            ..add(TextContent("xxJabatan", data4[0]['hJabatan']))
            ..add(TextContent("xxPengalaman", data4[0]['hPengalaman']))
            ..add(TextContent("xxSertifikat", data4[0]['hSertifikat']))
            ..add(TextContent("xxBukti", data4[0]['hSetor'])),
        );
      }

      c
        //** doc peralatan */
        //** part tabel */
        ..add(TableContent("table", aRow));
      //** part ttd */
      c
        ..add(TextContent('xxTempat', data1['xx1Tempat']))
        ..add(TextContent('xxWaktu', data1['xx1Waktu']))
        ..add(TextContent('aNamaBadanUsaha', data1['aNamaBadanUsaha']))
        ..add(TextContent('cNama', data2['cNama']))
        ..add(TextContent('cJabatan', data2['cJabatan']));

      final d = await docx.generate(c);

      final Directory extDir = await getExternalStorageDirectory();
      final String dirPath = extDir.path.toString().substring(0, 20);
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath';
      final of = new File('$filePath' +
          'Pictures/generated Mergr Personel ${data1['aNamaBadanUsaha']}.docx');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await of.writeAsBytes(d);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Mergr Personel ${data1['aNamaBadanUsaha']} selesai dibuat'),
        duration: Duration(seconds: 3),
      ));
    } catch (err) {
      print(err);
    }
  }

  void genDocxReferensi(BuildContext context, String q1) async {
    // **** data1
    Map<String, dynamic> data1 = {};
    final qSnap1 = await Firestore.instance
        .collection('mergrPenyedia')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap1.documents) {
      data1 = ds.data;
    }
    print(data1);

    // **** data2
    Map<String, dynamic> data2 = {};
    final qSnap2 = await Firestore.instance
        .collection('masterPenyedia')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap2.documents) {
      data2 = ds.data;
    }
    print(data2);

    // **** data3
    List<Map<String, dynamic>> data3 = [];
    final qSnap3 = await Firestore.instance
        .collection('mergrPersonel')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap3.documents) {
      data3.add(ds.data);
      print(data3);
    }
    // print('data3.length >> ${data3.length}');
    // print(data3);

    // start mergr doc
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result == null) {
      print('no file selected');
    }
    File file = File(result.files.single.path);
    // print(file.absolute);
    final docx = await DocxTemplate.fromBytes(await file.readAsBytes());
    try {
      Content c = Content();

      // List<PlainContent> aRow = [];
      final aRow = <PlainContent>[];
      List<Map<String, dynamic>> data4 = [];
      for (int i = 0; i < data3.length; i++) {
        final qSnap4 = await Firestore.instance
            .collection('masterReferensi')
            .where('xxx1Nama', isEqualTo: data3[i]['xhNama'])
            .getDocuments();
        for (DocumentSnapshot ds in qSnap4.documents) {
          data4.add(ds.data);
        }
      }

      for (int i = 0; i < data3.length; i++) {
        for (int ii = 0; ii < data4.length; ii++) {
          // print(data1['aNamaBadanUsaha']);
          // print(data2['cNama']);
          // print(data2['cJabatan']);
          // print(data2['aAlamatPusat']);
          aRow.add(PlainContent('xxx1Repeat')
                ..add(
                    TextContent("xxx1NomorSurat", data4[ii]['xxx1NomorSurat']))
                ..add(TextContent("aNamaBadanUsaha", data1['aNamaBadanUsaha']))
                ..add(TextContent("cNama", data2['cNama']))
                ..add(TextContent("cJabatan", data2['cJabatan']))
                ..add(TextContent("cAlamat", data2['aAlamatPusat']))
                ..add(TextContent("xxx1Nama", data4[ii]['xxx1Nama']))
                ..add(TextContent("xxx1Alamat", data4[ii]['xxx1Alamat']))
                ..add(TextContent("xxx1Jabatan", data4[ii]['xxx1Jabatan']))
                ..add(TextContent(
                    "xxx1NamaKontrak", data4[ii]['xxx1NamaKontrak']))
                ..add(TextContent(
                    "xxx1NomorKontrak", data4[ii]['xxx1NomorKontrak']))
                ..add(TextContent("xxx1Instansi", data4[ii]['xxx1Instansi']))
                ..add(TextContent("xxx1Periode", data4[ii]['xxx1Periode']))
                ..add(TextContent("aNamaBadanUsaha", data1['aNamaBadanUsaha']))
                ..add(TextContent("cNama", data2['cNama']))
                ..add(TextContent("cJabatan", data2['cJabatan']))
                ..add(TextContent("xxx1Tempat", data4[ii]['xxx1Tempat']))
                ..add(TextContent("xxx1Waktu", data4[ii]['xxx1Waktu']))
                ..add(TextContent("xxx1Instansi", data4[ii]['xxx1Instansi']))
                ..add(TextContent(
                    "xxx1NamaPejabat", data4[ii]['xxx1NamaPejabat']))
                ..add(
                    TextContent("xxx1NipPejabat", data4[ii]['xxx1NipPejabat']))
              // ..add(TextContent("xxx1Nama", data3[i]['xhNama'])
              );
        }
      }

      c..add(ListContent('ListRepeat', aRow));

      final d = await docx.generate(c);

      final Directory extDir = await getExternalStorageDirectory();
      final String dirPath = extDir.path.toString().substring(0, 20);
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath';
      final of = new File('$filePath' +
          'Pictures/generated Mergr Referensi ${data1['aNamaBadanUsaha']}.docx');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await of.writeAsBytes(d);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Mergr Referensi ${data1['aNamaBadanUsaha']} selesai dibuat'),
        duration: Duration(seconds: 3),
      ));
    } catch (err) {
      print(err);
    }
  }
}
