import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:mergers/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

import 'package:mergers/models/mergr_penyedia_model.dart';
import 'package:mergers/ui/mergr_penyedia/empty_content.dart';

import 'package:mergers/ui/drawer/app_drawer.dart';
import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum PrintOpt {
  PrintKualifikasi,
  PrintPernyataan,
}

class MergrPenyediaScreen extends StatelessWidget {
  // var printOption = PrintOpt.PrintKualifikasi;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Merger Penyedia'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_mergr_penyedia,
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
                    // onDismissed: (direction) {
                    //   firestoreDatabase.deleteTodo(peralatan[index]);

                    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
                    //     backgroundColor: Theme.of(context).appBarTheme.color,
                    //     content: Text(
                    //       AppLocalizations.of(context)
                    //               .translate("todosSnackBarContent") +
                    //           todos[index].task,
                    //       style:
                    //           TextStyle(color: Theme.of(context).canvasColor),
                    //     ),
                    //     duration: Duration(seconds: 3),
                    //     action: SnackBarAction(
                    //       label: AppLocalizations.of(context)
                    //           .translate("todosSnackBarActionLbl"),
                    //       textColor: Theme.of(context).canvasColor,
                    //       onPressed: () {
                    //         firestoreDatabase.setTodo(todos[index]);
                    //       },
                    //     ),
                    //   ));
                    // },
                    child: ListTile(
                      title: Text(mergrPenyedia[index].aNamaBadanUsaha),
                      trailing: _printOpt(
                          context, mergrPenyedia[index].aNamaBadanUsaha),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_mergr_penyedia,
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
                title: 'Tidak ada data penyedia',
                message: 'Tap + untuk menambah penyedia',
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
        if (selectedValue == PrintOpt.PrintKualifikasi) {
          // genDocxPersonel(context, a);
        } else if (selectedValue == PrintOpt.PrintPernyataan) {
          genDocxPernyataan(context, a);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Doc Kualifikasi'),
          value: PrintOpt.PrintKualifikasi,
        ),
        PopupMenuItem(
          child: Text('Doc Pernyataan'),
          value: PrintOpt.PrintPernyataan,
        ),
      ],
      icon: Icon(Icons.more_vert),
    );
  }

  void genDocxPernyataan(BuildContext context, String q1) async {
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

    // // **** data3
    // List<Map<String, dynamic>> data3 = [];
    // final qSnap3 = await Firestore.instance
    //     .collection('mergrPersonel')
    //     .where('aNamaBadanUsaha', isEqualTo: q1)
    //     .getDocuments();
    // for (DocumentSnapshot ds in qSnap3.documents) {
    //   data3.add(ds.data);
    //   print(data3);
    // }
    // print('data3.length >> ${data3.length}');
    // print(data3);

    // start mergr doc
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result == null) {
      print('no file selected');
      return;
    }

    File file = File(result.files.single.path);
    // print(file.absolute);
    final docx = await DocxTemplate.fromBytes(await file.readAsBytes());
    try {
      Content c = Content();

      c
            ..add(TextContent('cNama', data2['cNama']))
            ..add(TextContent('cJabatan', data2['cJabatan']))
            ..add(TextContent('aNamaBadanUsaha', data1['aNamaBadanUsaha']))
            ..add(TextContent('aAlamatPusat', data2['aAlamatPusat']))
            ..add(TextContent('aTelpPusat', data2['aTelpPusat']))
            ..add(TextContent('aEmailPusat', data2['aEmailPusat']))
            ..add(TextContent('xxTempat', data1['xx1Tempat']))
            ..add(TextContent('xxWaktu', data1['xx1Waktu']))
            ..add(TextContent('aNamaBadanUsaha', data1['aNamaBadanUsaha']))
            ..add(TextContent('cNama', data2['cNama']))
            ..add(TextContent('cJabatan', data2['cJabatan']))
            ..add(TextContent('xx1NamaPaket', data1['xx1NamaPaket']))
            ..add(TextContent(
                'xx1InstansiPemberiTugas', data1['xx1InstansiPemberiTugas']))

          //
          ;

      final d = await docx.generate(c);

      final Directory extDir = await getExternalStorageDirectory();
      final String dirPath = extDir.path.toString().substring(0, 20);
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath';
      final of = new File('$filePath' +
          'Pictures/generated Mergr Pernyataan ${data1['aNamaBadanUsaha']}.docx');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await of.writeAsBytes(d);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Mergr Pernyataan ${data1['aNamaBadanUsaha']} selesai dibuat'),
        duration: Duration(seconds: 3),
      ));
    } catch (err) {
      print(err);
    }
  }
}
