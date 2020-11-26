import 'package:flutter/material.dart';
import 'package:stockmon/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Barang Masuk'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.stokBarangMasuk);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Stok Barang'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.stokBarangAktif);
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
