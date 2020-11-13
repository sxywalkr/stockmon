import 'package:flutter/material.dart';
import 'package:mergers/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('userName'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          // userRole == 'App Admin' || userRole == 'user Upt'
          //     ? Divider()
          //     : SizedBox(height: 1),
          // userRole == 'App Admin' || userRole == 'user Upt'
          //     ? ListTile(
          //         leading: Icon(Icons.person_pin),
          //         title: Text('Domestik Keluar'),
          //         onTap: () {
          //           Navigator.of(context)
          //               .pushReplacementNamed(EcertsScreen.routeName);
          //         },
          //       )
          //     : SizedBox(height: 1),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.home2);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Data Master Penyedia'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.penyedia);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Data Master Personel'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.personel);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Data Master Pengalaman Kerja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.pengalaman);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Data Peralatan'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.peralatan);
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
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () {
          //     // Provider.of<Auth>(context, listen: false).logout();
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushReplacementNamed('/');
          //   },
          // ),
        ],
      ),
    );
  }
}
