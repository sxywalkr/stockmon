// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stockmon/ui/splash/splash_screen.dart';
import 'package:stockmon/providers/app_access_level_provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _cekRole(BuildContext context) async {
    await Provider.of<AppAccessLevelProvider>(context, listen: false).getRole();
  }

  @override
  Widget build(BuildContext context) {
    _cekRole(context);
    // getUser();
    return SplashScreen();
  }
}
