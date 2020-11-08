import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:mergers/routes.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

import 'package:mergers/models/personel_model.dart';
import 'package:mergers/ui/penyedia/empty_content.dart';

import 'package:mergers/ui/drawer/app_drawer.dart';

class PersonelScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Master Personel'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_personel,
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
        stream: firestoreDatabase.personelsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PersonelModel> personel = snapshot.data;
            if (personel.isNotEmpty) {
              return ListView.separated(
                itemCount: personel.length,
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
                    key: Key(personel[index].id),
                    // onDismissed: (direction) {
                    //   firestoreDatabase.deleteTodo(personel[index]);

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
                      title: Text(personel[index].hNama),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_personel,
                            arguments: personel[index]);
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
                title: 'Tidak ada data personel',
                message: 'Tap + untuk menambah personel',
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: AppLocalizations.of(context)
                  .translate("personelErrorTopMsgTxt"),
              message: AppLocalizations.of(context)
                  .translate("personelErrorBottomMsgTxt"),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
