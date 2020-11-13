import 'package:flutter/material.dart';
import 'package:mergers/app_localizations.dart';

import 'package:mergers/routes.dart';
import 'package:mergers/services/firestore_database.dart';
import 'package:provider/provider.dart';

import 'package:mergers/models/peralatan_model.dart';
import 'package:mergers/ui/peralatan/empty_content.dart';

import 'package:mergers/ui/drawer/app_drawer.dart';

class PeralatanScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Master Peralatan'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_peralatan,
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
        stream: firestoreDatabase.peralatansStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PeralatanModel> peralatan = snapshot.data;
            if (peralatan.isNotEmpty) {
              return ListView.separated(
                itemCount: peralatan.length,
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
                    key: Key(peralatan[index].id),
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
                      title: Text(peralatan[index].xJenis),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.create_edit_peralatan,
                            arguments: peralatan[index]);
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
                title: 'Tidak ada data peralatan',
                message: 'Tap + untuk menambah peralatan',
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
