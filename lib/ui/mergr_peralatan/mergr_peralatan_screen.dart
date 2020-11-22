import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergers/routes.dart';
import 'package:mergers/services/firestore_database.dart';
// import 'package:mergers/services/firestore_service.dart';
import 'package:provider/provider.dart';

import 'package:mergers/models/peralatan_model.dart';
import 'package:mergers/models/mergr_penyedia_model.dart';
import 'package:mergers/models/mergr_peralatan_detail_model.dart';
import 'package:mergers/ui/mergr_peralatan/empty_content.dart';

import 'package:mergers/ui/drawer/app_drawer.dart';
import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MergrPeralatanScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void genDocxPeralatan(BuildContext context, String q1) async {
    // **** data1
    Map<String, dynamic> data1 = {};
    final qSnap1 = await Firestore.instance
        .collection('mergrPenyedia')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap1.documents) {
      data1 = ds.data;
    }
    print(data1['xx1Tempat']);

    // **** data2
    Map<String, dynamic> data2 = {};
    final qSnap2 = await Firestore.instance
        .collection('masterPenyedia')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap2.documents) {
      data2 = ds.data;
    }
    print(data2['cNama']);

    // **** data3
    List<Map<String, dynamic>> data3 = [];
    final qSnap3 = await Firestore.instance
        .collection('mergrPeralatanDetail')
        .where('aNamaBadanUsaha', isEqualTo: q1)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap3.documents) {
      data3.add(ds.data);
      print(data3);
    }
    print('data3.length >> ${data3.length}');
    print(data3);

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
            .collection('masterPeralatan')
            .where('xJenis', isEqualTo: data3[i]['xJenis'])
            .getDocuments();
        for (DocumentSnapshot ds in qSnap4.documents) {
          data4.add(ds.data);
          // print(data4);
        }
        aRow.add(
          RowContent()
            ..add(TextContent("xxNo", i + 1))
            ..add(TextContent("xxJenis", data3[i]['xJenis']))
            ..add(TextContent("xxMerk", data4[0]['xMerk']))
            ..add(TextContent("xxLokasi", data4[0]['xLokasi']))
            ..add(TextContent("xxKapasitas", data4[0]['xKapasitas']))
            ..add(TextContent("xxJumlah", data4[0]['xJumlah']))
            ..add(TextContent("xxStatus", data4[0]['xStatus'])),
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
          'Pictures/generated Mergr Peralatan ${data1['aNamaBadanUsaha']}.docx');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await of.writeAsBytes(d);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Mergr Peralatan ${data1['aNamaBadanUsaha']} selesai dibuat'),
        duration: Duration(seconds: 3),
      ));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Merger Doc Peralatan'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_mergr_penyedia_peralatan,
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
                      // trailing: IconButton(
                      //     icon: Icon(Icons.print),
                      //     onPressed: () {
                      //       genDocxPeralatan(
                      //           context, mergrPenyedia[index].aNamaBadanUsaha);
                      //     }),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_mergr_penyedia_peralatan,
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
                title: 'Tidak ada data merger peralatan',
                message: 'Tap + untuk menambah merger peralatan',
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
}
