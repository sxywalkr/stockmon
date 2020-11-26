// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:stockmon/ui/splash/splash_screen.dart';
// import 'package:stockmon/models/app_user_model.dart';
// import 'package:stockmon/services/firestore_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:stockmon/models/user_model.dart';
// import 'package:stockmon/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final firebaseMessaging = FirebaseMessaging();
  // String _fcmToken = '';

  @override
  void initState() {
    super.initState();
    // _getFcmToken();
  }

  // void _getFcmToken() {
  //   firebaseMessaging.getToken().then((token) {
  //     // debugPrint('getToken: $token');
  //     setState(() {
  //       _fcmToken = token;
  //     });
  //   });
  // }

  // Future<String> getUser(Stream<UserModel> stream) async {
  //   var sum = '';
  //   await for (var value in stream) {
  //     sum = value.email;
  //     print(value.email);
  //   }

  //   return sum;
  // }

  // void _cekRole() async {
  //   final authProvider = Provider.of<AuthProvider>(context);
  //   // print(authProvider.userUid);

  //   // FirebaseUser user = authProvider.user

  //   // FirebaseAuth aa = FirebaseAuth.instance;

  //   // final firestoreDatabase =
  //   //     Provider.of<FirestoreDatabase>(context, listen: false);
  //   // print('first >> ${authProvider.status}');
  //   // String aa = await getUser(authProvider.user);
  //   // print(aa);
  //   if (authProvider.status == Status.Authenticated) {
  //     // authProvider.user.forEach((element) => print(element));
  //   }

  //   // firestoreDatabase.setAppUser(AppUserModel(
  //   //   id: authProvider.user,
  //   //   appRole: 'Unregister',
  //   //   email: _emailController.text,
  //   //   appFcmId: _fcmToken,
  //   // ));
  // }

  @override
  Widget build(BuildContext context) {
    // _cekRole();
    // getUser();
    return SplashScreen();
  }
}
