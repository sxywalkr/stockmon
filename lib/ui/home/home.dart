// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stockmon/ui/splash/splash_screen.dart';
import 'package:stockmon/providers/app_access_level_provider.dart';
// import 'package:stockmon/models/app_user_model.dart';
// import 'package:stockmon/services/firestore_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:stockmon/models/user_model.dart';
// import 'package:stockmon/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AppAccessLevelProvider>(context, listen: false).getRole();
    // _cekRole();
    // getUser();
    return SplashScreen();
  }
}
