import 'package:flutter/material.dart';
import 'package:mergers/ui/auth/register_screen.dart';
import 'package:mergers/ui/auth/sign_in_screen.dart';
import 'package:mergers/ui/setting/setting_screen.dart';
import 'package:mergers/ui/splash/splash_screen.dart';
import 'package:mergers/ui/todo/create_edit_todo_screen.dart';
import 'package:mergers/ui/todo/todos_screen.dart';

import 'package:mergers/ui/home2/home2_screen.dart';
import 'package:mergers/ui/penyedia/penyedia_screen.dart';
import 'package:mergers/ui/penyedia/create_edit_penyedia_screen.dart';
import 'package:mergers/ui/personel/personel_screen.dart';
import 'package:mergers/ui/personel/create_edit_personel_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String setting = '/setting';
  static const String create_edit_todo = '/create_edit_todo';

  static const String home2 = '/home2';
  static const String penyedia = '/penyedia';
  static const String create_edit_penyedia = '/create_edit_penyedia';
  static const String personel = '/personel';
  static const String create_edit_personel = '/create_edit_personel';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => SignInScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => TodosScreen(),
    setting: (BuildContext context) => SettingScreen(),
    create_edit_todo: (BuildContext context) => CreateEditTodoScreen(),
    home2: (BuildContext context) => Home2Screen(),
    penyedia: (BuildContext context) => PenyediaScreen(),
    create_edit_penyedia: (BuildContext context) => CreateEditPenyediaScreen(),
    personel: (BuildContext context) => PersonelScreen(),
    create_edit_personel: (BuildContext context) => CreateEditPersonelScreen(),
  };
}
