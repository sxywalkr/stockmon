import 'package:flutter/material.dart';
import 'package:stockmon/models/user_model.dart';
import 'package:stockmon/providers/auth_provider.dart';
import 'package:stockmon/routes.dart';
import 'package:stockmon/services/firestore_database.dart';
import 'package:stockmon/ui/drawer/app_drawer.dart';
import 'package:provider/provider.dart';

import 'package:stockmon/models/app_user_model.dart';
import 'package:stockmon/ui/appUser/empty_content.dart';

enum UserRole {
  UserAdmin,
  UserGudang,
  UserPegawai,
}

class AppUsersScreen extends StatelessWidget {
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
              return Text('List App User');
            }),
        actions: <Widget>[],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_appUser,
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
        stream: firestoreDatabase.appUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AppUserModel> appUsers = snapshot.data;
            if (appUsers.isNotEmpty) {
              return ListView.separated(
                itemCount: appUsers.length,
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
                    key: Key(appUsers[index].appUserUid),
                    onDismissed: (direction) {
                      firestoreDatabase.deleteAppUser(appUsers[index]);

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).appBarTheme.color,
                        content: Text(
                          'Hapus ' + appUsers[index].appUserEmail,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Batal',
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            firestoreDatabase.setAppUser(appUsers[index]);
                          },
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(appUsers[index].appUserEmail),
                      subtitle: Text(appUsers[index].appRole),
                      trailing: _setUserRole(context, appUsers[index]),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_appUser,
                            arguments: appUsers[index]);
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
                title: 'Data App User belum ada',
                message: 'Tap + untuk menambah data',
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: 'Error. Data App User',
              message: 'Error..',
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _setUserRole(BuildContext context, AppUserModel aa) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    return PopupMenuButton(
      onSelected: (UserRole selectedValue) {
        if (selectedValue == UserRole.UserAdmin) {
          firestoreDatabase.setAppUser(AppUserModel(
            appUserUid: aa.appUserUid,
            appRole: 'App Admin',
            appFcmId: aa.appFcmId,
            appUserEmail: aa.appUserEmail,
          ));
        } else if (selectedValue == UserRole.UserGudang) {
          firestoreDatabase.setAppUser(AppUserModel(
            appUserUid: aa.appUserUid,
            appRole: 'App Gudang',
            appFcmId: aa.appFcmId,
            appUserEmail: aa.appUserEmail,
          ));
        } else if (selectedValue == UserRole.UserPegawai) {
          firestoreDatabase.setAppUser(AppUserModel(
            appUserUid: aa.appUserUid,
            appRole: 'App Pegawai',
            appFcmId: aa.appFcmId,
            appUserEmail: aa.appUserEmail,
          ));
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('User Admin'),
          value: UserRole.UserAdmin,
        ),
        PopupMenuItem(
          child: Text('User Gudang'),
          value: UserRole.UserGudang,
        ),
        PopupMenuItem(
          child: Text('User Pegawai'),
          value: UserRole.UserPegawai,
        ),
      ],
      icon: Icon(Icons.more_vert),
    );
  }
}
