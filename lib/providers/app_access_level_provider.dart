import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockmon/models/app_user_model.dart';

class AppAccessLevelProvider extends ChangeNotifier {
  final dbReference = Firestore.instance;
  final String _appUserUid;
  String _appUserRole;
  List<AppUserModel> _items = [];

  AppAccessLevelProvider(BuildContext context, this._appUserUid, this._items);

  List<AppUserModel> get items {
    return [..._items];
  }

  String get appxUserUid {
    return _appUserUid;
  }

  String get appxUserRole {
    return _appUserRole;
  }

  Future<void> getRole() async {
    Map<String, dynamic> data1 = {};
    final qSnap1 = await dbReference
        .collection("appUsers")
        .where('appUserUid', isEqualTo: _appUserUid)
        .getDocuments();
    for (DocumentSnapshot ds in qSnap1.documents) {
      data1 = ds.data;
    }
    print('login role >> $_appUserUid ${data1['appRole']}');
    _appUserRole = data1['appRole'];
    notifyListeners();
  }
}
