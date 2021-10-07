import 'package:flutter/material.dart';
import 'package:user_preferences_app/src/pages/pages.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/menu-img.jpg"), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.pages,
              color: Colors.blue,
            ),
            title: Text("Pages"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(
              Icons.party_mode,
              color: Colors.blue,
            ),
            title: Text("Party mode"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, SettingsPage.routeName),
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.blue,
            ),
            title: Text("People"),
            onTap: () => Navigator.pushNamed(context, HomePage.routeName),
          ),
          ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              title: Text("Settings"),
              onTap: () => Navigator.pushNamed(context, SettingsPage.routeName))
        ],
      ),
    );
  }
}
