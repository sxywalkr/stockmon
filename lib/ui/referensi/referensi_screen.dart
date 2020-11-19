import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mergers/models/referensi_model.dart';
import 'package:mergers/routes.dart';
import 'package:mergers/services/firestore_database.dart';
// import 'package:mergers/services/firestore_service.dart';
import 'package:provider/provider.dart';

// import 'package:mergers/models/peralatan_model.dart';
// import 'package:mergers/models/rperalatan_detail_model.dart';
import 'package:mergers/ui/referensi/empty_content.dart';

import 'package:mergers/ui/drawer/app_drawer.dart';

class ReferensiScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Data Master Referensi'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_referensi,
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
        stream: firestoreDatabase.referensisStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ReferensiModel> referensi = snapshot.data;
            if (referensi.isNotEmpty) {
              return ListView.separated(
                itemCount: referensi.length,
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
                    key: Key(referensi[index].id),
                    child: ListTile(
                      title: Text(referensi[index].xxx1Nama),
                      // trailing: IconButton(
                      //     icon: Icon(Icons.print),
                      //     onPressed: () {
                      //       // genDocxPersonel(
                      //       //     context, referensi[index].aNamaBadanUsaha);
                      //     }),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_referensi,
                            arguments: referensi[index]);
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
                title: 'Tidak ada data referensi',
                message: 'Tap + untuk menambah referensi',
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
