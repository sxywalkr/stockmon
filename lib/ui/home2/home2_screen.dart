// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockmon/providers/app_access_level_provider.dart';
// import 'package:stockmon/app_localizations.dart';

// import 'package:stockmon/models/user_model.dart';
import 'package:stockmon/providers/auth_provider.dart';
// import 'package:stockmon/routes.dart';
import 'package:stockmon/services/firestore_database.dart';
import 'package:provider/provider.dart';

// import 'package:stockmon/models/penyedia_model.dart';
// import 'package:stockmon/ui/home2/empty_content.dart';

// import 'package:docx_template/docx_template.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:stockmon/ui/drawer/app_drawer.dart';

class Home2Screen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: StreamBuilder(
            stream: authProvider.user,
            builder: (context, snapshot) {
              // final UserModel user = snapshot.data;
              return Text('Dashboard ');
            }),
        actions: <Widget>[
          // StreamBuilder(
          //     stream: firestoreDatabase.penyediasStream(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         List<PenyediaModel> penyedias = snapshot.data;
          //         return Visibility(
          //             visible: penyedias.isNotEmpty ? true : false,
          //             child: Text('--')); //TodosExtraActions());
          //       } else {
          //         return Container(
          //           width: 0,
          //           height: 0,
          //         );
          //       }
          //     }),
          // IconButton(
          //     icon: Icon(Icons.settings),
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(Routes.setting);
          //     }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context).pushNamed(
          //   Routes.create_edit_penyedia,
          // );
        },
      ),
      body: _home2(context),
      // WillPopScope(
      //     onWillPop: () async => false, child: _buildBodySection(context)),
    );
  }

  Widget _home2(BuildContext context) {
    final appAccessLevelProvider =
        Provider.of<AppAccessLevelProvider>(context, listen: false);
    return Column(
      children: [
        Center(
          child: Text(
            'StockMon',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Center(
          child: Text(
            '${appAccessLevelProvider.appxUserRole}',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
