import 'package:flutter/material.dart';
import 'package:stockmon/routes.dart';
import 'package:provider/provider.dart';
import 'package:stockmon/providers/app_access_level_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appAccessLevelProvider =
        Provider.of<AppAccessLevelProvider>(context, listen: false);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('StockMon'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.home2);
              },
            ),
            if (appAccessLevelProvider.appxUserRole == 'App Gudang' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              Divider(),
            if (appAccessLevelProvider.appxUserRole == 'App Gudang' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Barang Masuk'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.stokBarangMasuk);
                },
              ),
            if (appAccessLevelProvider.appxUserRole == 'App Gudang' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              Divider(),
            if (appAccessLevelProvider.appxUserRole == 'App Gudang' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Stok Barang'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.stokBarangAktif);
                },
              ),
            if (appAccessLevelProvider.appxUserRole == 'App Pegawai' ||
                appAccessLevelProvider.appxUserRole == 'App Gudang' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              Divider(),
            if (appAccessLevelProvider.appxUserRole == 'App Pegawai' ||
                appAccessLevelProvider.appxUserRole == 'App Gudang' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Barang Keluar'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.stokBarangKeluar);
                },
              ),
            if (appAccessLevelProvider.appxUserRole == 'App Admin' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              Divider(),
            if (appAccessLevelProvider.appxUserRole == 'App Admin' ||
                appAccessLevelProvider.appxUserRole == 'App Debug')
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Manage App User'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Routes.appUser);
                },
              ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.setting);
              },
            ),
          ],
        ),
      ),
    );
  }
}
