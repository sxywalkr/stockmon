import 'package:flutter/material.dart';
// import 'package:stockmon/app_localizations.dart';
// import 'package:stockmon/models/stok_brg_Keluar_model.dart';
import 'package:stockmon/models/user_model.dart';
import 'package:stockmon/providers/auth_provider.dart';
import 'package:stockmon/routes.dart';
import 'package:stockmon/services/firestore_database.dart';
import 'package:stockmon/ui/drawer/app_drawer.dart';
import 'package:stockmon/ui/todo/empty_content.dart';
import 'package:provider/provider.dart';
import 'package:stockmon/models/stok_brg_keluar_model.dart';

class StokBarangKeluarsScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    // final firestoreDatabase =
    //     Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder(
            stream: authProvider.user,
            builder: (context, snapshot) {
              final UserModel user = snapshot.data;
              return Text('Daftar Pesanan Barang');
            }),
        actions: <Widget>[],
      ),
      drawer: AppDrawer(),
      floatingActionButton: StreamBuilder(
          stream: authProvider.user,
          builder: (context, snapshot) {
            final UserModel user = snapshot.data;
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.create_edit_stokBarangKeluar,
                  arguments: {'userUid': user.uid, 'status': 'permintaan'},
                );
              },
            );
          }),
      body: WillPopScope(
          onWillPop: () async => false, child: _buildBodySection(context)),
    );
  }

  Widget _buildBodySection(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
// final appAccessLevelProvider = Provider.of<AppAccessLevelProvider>(context);
    return StreamBuilder(
        stream: firestoreDatabase.stokBarangKeluarModelQbyUserIdStream(
            query1: firestoreDatabase.appxUserUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<StokBarangKeluarModel> stokBarangKeluars = snapshot.data;
            if (stokBarangKeluars.isNotEmpty) {
              return ListView.separated(
                itemCount: stokBarangKeluars.length,
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
                    key: Key(stokBarangKeluars[index].id),
                    // onDismissed: (direction) {
                    //   firestoreDatabase
                    //       .deletestokBarangKeluar(stokBarangKeluars[index]);

                    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
                    //     backgroundColor: Theme.of(context).appBarTheme.color,
                    //     content: Text(
                    //       'Hapus ' + stokBarangKeluars[index].namaBarang,
                    //       style:
                    //           TextStyle(color: Theme.of(context).canvasColor),
                    //     ),
                    //     duration: Duration(seconds: 3),
                    //     action: SnackBarAction(
                    //       label: 'Batal',
                    //       textColor: Theme.of(context).canvasColor,
                    //       onPressed: () {
                    //         firestoreDatabase
                    //             .setStokBarangKeluar(stokBarangKeluars[index]);
                    //       },
                    //     ),
                    //   ));
                    // },
                    child: ListTile(
                      title: Text(stokBarangKeluars[index].namaBarang),
                      subtitle: Text(
                          'Jumlah: ${stokBarangKeluars[index].jumlah}, status : ${stokBarangKeluars[index].orderStatus}'),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_stokBarangKeluar,
                            arguments: stokBarangKeluars[index]);
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
                title: 'Data Stok Barang Keluar belum ada',
                message: 'Tap + untuk menambah data',
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: 'Error. Data Stok Barang Keluar',
              message: 'Error..',
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
