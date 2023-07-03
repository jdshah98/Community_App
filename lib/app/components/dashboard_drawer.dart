import 'dart:io';

import 'package:community_app/app/model/user.dart';
import 'package:community_app/app/screens/auth/login.dart';
import 'package:community_app/app/screens/features/address_book.dart';
import 'package:community_app/app/screens/features/committee.dart';
import 'package:community_app/app/screens/features/events.dart';
import 'package:community_app/app/screens/features/jobs.dart';
import 'package:community_app/app/screens/features/matrimony.dart';
import 'package:community_app/app/screens/features/message_list.dart';
import 'package:community_app/app/screens/features/profile/profile.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer(this.user, this.path, {super.key});
  const DashboardDrawer.nullDrawer({super.key, this.user, this.path});

  final User? user;
  final String? path;

  @override
  Widget build(BuildContext context) {
    const double dashboardItemIconSize = 32;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 225,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 90,
                    height: 90,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: path != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File("$path/${user!.members![0].profilePic}"),
                              ),
                            )
                          : null,
                    ),
                  ),
                  Text(
                    user != null ? user!.members![0].name! : "",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    softWrap: true,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.person,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Profile',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(user, path),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.chat,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Messages',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessageListScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.menu_book,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Address Book',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddressBook(),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.event,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Events',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.work,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Jobs',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JobScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Matrimony',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MatrimonyScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.groups,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Commitee',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Committee(),
                ),
              );
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.contact_support,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Help',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.logout,
                    color: Colors.deepPurpleAccent,
                    size: dashboardItemIconSize,
                  ),
                ),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            onTap: () {
              SharedPref.clearSharedPref();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
