import 'package:flutter/material.dart';
import 'package:stockmon/ui/auth/register_screen.dart';
import 'package:stockmon/ui/auth/sign_in_screen.dart';
import 'package:stockmon/ui/setting/setting_screen.dart';
import 'package:stockmon/ui/splash/splash_screen.dart';
import 'package:stockmon/ui/todo/create_edit_todo_screen.dart';
import 'package:stockmon/ui/todo/todos_screen.dart';

import 'package:stockmon/ui/home2/home2_screen.dart';
import 'package:stockmon/ui/stokBarangMasuk/stokBarangMasuks_screen.dart';
import 'package:stockmon/ui/stokBarangMasuk/create_edit_stokBarangMasuk_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String setting = '/setting';
  static const String create_edit_todo = '/create_edit_todo';

  static const String home2 = '/home2';

  static const String stokBarangMasuk = '/stokBarangMasuk';
  static const String create_edit_stokBarangMasuk =
      '/create_edit_stokBarangMasuk';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => SignInScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => TodosScreen(),
    setting: (BuildContext context) => SettingScreen(),
    create_edit_todo: (BuildContext context) => CreateEditTodoScreen(),
    home2: (BuildContext context) => Home2Screen(),
    stokBarangMasuk: (BuildContext context) => StokBarangMasuksScreen(),
    create_edit_stokBarangMasuk: (BuildContext context) =>
        CreateEditStokBarangMasukScreen(),
  };
}
