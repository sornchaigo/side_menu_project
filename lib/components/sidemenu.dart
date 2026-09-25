import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/home.dart';
import '../screens/contact.dart';
import '../screens/profile.dart';
import '../screens/about.dart';
import '../screens/settings.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('AccountName'),
            accountEmail: Text('email@example.com'),
            currentAccountPicture: CircleAvatar(
              // backgroundImage: NetworkImage('https://www.ninenik.com/images/ninenik_page_logo.jpg'),
              backgroundImage: AssetImage('images/images.jpg'),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.house),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.info),
            title: Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, About.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.user),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, Profile.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.addressCard),
            title: Text('Contact Us'),
            onTap: () {
              Navigator.pushNamed(context, Contact.routeName);
            },
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: FaIcon(FontAwesomeIcons.gear),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, Settings.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
