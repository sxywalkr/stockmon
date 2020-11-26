import 'package:flutter/material.dart';
import 'package:stockmon/app_localizations.dart';
import 'package:stockmon/models/stok_brg_masuk_model.dart';
import 'package:stockmon/models/user_model.dart';
import 'package:stockmon/providers/auth_provider.dart';
import 'package:stockmon/routes.dart';
import 'package:stockmon/services/firestore_database.dart';
import 'package:stockmon/ui/drawer/app_drawer.dart';
import 'package:stockmon/ui/todo/empty_content.dart';
import 'package:provider/provider.dart';
import 'package:stockmon/models/stok_brg_masuk_model.dart';

class StokBarangMasuksScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder(
            stream: authProvider.user,
            builder: (context, snapshot) {
              final UserModel user = snapshot.data;
              return Text('Barang Masuk');
            }),
        actions: <Widget>[],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_stokBarangMasuk,
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
        stream: firestoreDatabase.stokBarangMasuksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<StokBarangMasukModel> stokBarangMasuks = snapshot.data;
            if (stokBarangMasuks.isNotEmpty) {
              return ListView.separated(
                itemCount: stokBarangMasuks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        'Geser hapus',
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      )),
                    ),
                    key: Key(stokBarangMasuks[index].id),
                    onDismissed: (direction) {
                      firestoreDatabase
                          .deletestokBarangMasuk(stokBarangMasuks[index]);

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).appBarTheme.color,
                        content: Text(
                          'Hapus ' + stokBarangMasuks[index].namaBarang,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Batal',
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            firestoreDatabase
                                .setstokBarangMasuk(stokBarangMasuks[index]);
                          },
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(stokBarangMasuks[index].namaBarang),
                      subtitle: Text(
                          'Jumlah : ${stokBarangMasuks[index].jumlah.toString()}'),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_stokBarangMasuk,
                            arguments: stokBarangMasuks[index]);
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
                title: 'Data Stok Barang Masuk belum ada',
                message: 'Tap + untuk menambah data',
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: 'Error. Data Stok Barang Masuk',
              message: 'Error..',
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
