import 'dart:io';

import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/member.dart';
import 'package:community_app/app/screens/auth/login.dart';
import 'package:community_app/app/screens/features/address_book.dart';
import 'package:community_app/app/screens/features/committee.dart';
import 'package:community_app/app/screens/features/events.dart';
import 'package:community_app/app/screens/features/message_list.dart';
import 'package:community_app/app/screens/features/profile/profile.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer(this.loaded, {super.key});

  final bool loaded;

  @override
  Widget build(BuildContext context) {
    const double dashboardItemIconSize = 32;

    return Consumer<AppState>(
      builder: (context, state, child) {
        final Member mainMember = state.user.members.entries
            .singleWhere((element) => element.key == "1")
            .value;
        return Drawer(
          width: MediaQuery.of(context).size.width * 0.8,
          child: loaded
              ? ListView(
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
                                image: mainMember.profilePic.isNotEmpty
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(
                                            "${state.localPath}/${mainMember.profilePic}",
                                          ),
                                        ),
                                      )
                                    : const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(avatar),
                                      ),
                              ),
                            ),
                            Text(
                              mainMember.name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
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
                            builder: (context) => const Profile(),
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
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
