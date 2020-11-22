import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:mergers/models/user_model.dart';
import 'package:mergers/providers/auth_provider.dart';
import 'package:mergers/routes.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

import 'package:mergers/models/penyedia_model.dart';
import 'package:mergers/ui/penyedia/empty_content.dart';

import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mergers/ui/drawer/app_drawer.dart';

class PenyediaScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void genDocxKualifikasi(PenyediaModel a) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result == null) {
      print('no file selected');
    }
    File file = File(result.files.single.path);
    print(file.absolute);
    final docx = await DocxTemplate.fromBytes(await file.readAsBytes());
    try {
      Content c = Content();
      c
            //** pakta integritas */
            ..add(TextContent('cNama', a.cNama))
            ..add(TextContent('cJabatan', a.cJabatan))
            ..add(TextContent('aNamaBadanUsaha', a.aNamaBadanUsaha))
            ..add(TextContent('aNamaBadanUsaha', a.aNamaBadanUsaha))
            ..add(TextContent('cNama', a.cNama))
            ..add(TextContent('cJabatan', a.cJabatan))
            //** formulir */
            ..add(TextContent('cNama', a.cNama))
            ..add(TextContent('cNomor', a.cNomor))
            ..add(TextContent('cJabatan', a.cJabatan))
            ..add(TextContent('aNamaBadanUsaha', a.aNamaBadanUsaha))
            ..add(TextContent('aAlamatPusat', a.aAlamatPusat))
            ..add(TextContent('aTelpPusat', a.aTelpPusat))
            ..add(TextContent('aFaxPusat', a.aFaxPusat))
            ..add(TextContent('aEmailPusat', a.aEmailPusat))
            ..add(TextContent('bNomor', a.bNomor))
            ..add(TextContent('bTanggal', a.bTanggal))
            ..add(TextContent('bNamaNotaris', a.bNamaNotaris))
            //** data isian */
            ..add(TextContent('aNamaBadanUsaha', a.aNamaBadanUsaha))
            ..add(TextContent('aAlamatPusat', a.aAlamatPusat))
            ..add(TextContent('aTelpPusat', a.aTelpPusat))
            ..add(TextContent('aFaxPusat', a.aFaxPusat))
            ..add(TextContent('aEmailPusat', a.aEmailPusat))
            ..add(TextContent('bNomor', a.bNomor))
            ..add(TextContent('bTanggal', a.bTanggal))
            ..add(TextContent('bNamaNotaris', a.bNamaNotaris))
            ..add(TextContent('bNomorPengesahan', a.bNomorPengesahan))
            ..add(TextContent('cNama', a.cNama))
            ..add(TextContent('cNomor', a.cNomor))
            ..add(TextContent('cJabatan', a.cJabatan))
            ..add(TextContent('dNomor', a.dNomor))
            ..add(TextContent('dTanggal', a.dTanggal))
            ..add(TextContent('dMasa', a.dMasa))
            ..add(TextContent('dInstansi', a.dInstansi))
            ..add(TextContent('eNomor', a.eNomor))
            ..add(TextContent('eTanggal', a.eTanggal))
            ..add(TextContent('eMasa', a.eMasa))
            ..add(TextContent('eInstansi', a.eInstansi))
            ..add(TextContent('eKualifikasi', a.eKualifikasi))
            ..add(TextContent('eKlasifikasi', a.eKlasifikasi))
            ..add(TextContent('eSubKlasifikasi', a.eSubKlasifikasi))
            ..add(TextContent('fNomor', a.fNomor))
            ..add(TextContent('fTanggal', a.fTanggal))
            ..add(TextContent('fMasa', a.fMasa))
            ..add(TextContent('fInstansi', a.fInstansi))
            ..add(TextContent('g1Nama', a.g1Nama))
            ..add(TextContent('g1Identitas', a.g1Identitas))
            ..add(TextContent('g1Alamat', a.g1Alamat))
            ..add(TextContent('g1Persentase', a.g1Persentase))
            ..add(TextContent('g2Npwp', a.g2Npwp))
            ..add(TextContent('g2Nomor', a.g2Nomor))
            ..add(TextContent('g2Tanggal', a.g2Tanggal))
          // ..add(TextContent("aTtd", "Remark for last doc"))
          ;

      final d = await docx.generate(c);

      final Directory extDir = await getExternalStorageDirectory();
      final String dirPath = extDir.path.toString().substring(0, 20);
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath';
      final of = new File('$filePath' +
          'Pictures/generated Docx Kualifikasi ${a.aNamaBadanUsaha}.docx');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await of.writeAsBytes(d);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Docx Kualifikasi ${a.aNamaBadanUsaha} selesai dibuat'),
        duration: Duration(seconds: 3),
      ));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Master Penyedia'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_penyedia,
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
        stream: firestoreDatabase.penyediasStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PenyediaModel> penyedias = snapshot.data;
            if (penyedias.isNotEmpty) {
              return ListView.separated(
                itemCount: penyedias.length,
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
                    key: Key(penyedias[index].id),
                    // onDismissed: (direction) {
                    //   firestoreDatabase.deleteTodo(penyedias[index]);

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
                      // leading: Checkbox(
                      //     value: penyedias[index].aNamaBadanUsaha,
                      //     onChanged: (value) {
                      //       TodoModel todo = TodoModel(
                      //           id: penyedias[index].id,
                      //           task: penyedias[index].task,
                      //           extraNote: penyedias[index].extraNote,
                      //           complete: value);
                      //       firestoreDatabase.setTodo(todo);
                      //     }),
                      title: Text(penyedias[index].aNamaBadanUsaha),
                      // trailing: IconButton(
                      //     icon: Icon(Icons.print),
                      //     onPressed: () {
                      //       genDocxKualifikasi(penyedias[index]);
                      //     }),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_penyedia,
                            arguments: penyedias[index]);
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
                title: AppLocalizations.of(context)
                    .translate("penyediasEmptyTopMsgDefaultTxt"),
                message: AppLocalizations.of(context)
                    .translate("penyediasEmptyBottomDefaultMsgTxt"),
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: AppLocalizations.of(context)
                  .translate("penyediasErrorTopMsgTxt"),
              message: AppLocalizations.of(context)
                  .translate("penyediasErrorBottomMsgTxt"),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
