import 'dart:io';

import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/member.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewMember extends StatelessWidget {
  ViewMember(this.memberId, {super.key});

  final int memberId;

  final DateFormat dateformatter = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        final Member member = state.user.members.entries
            .singleWhere((element) => element.key == memberId.toString())
            .value;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Member Profile",
              style: TextStyle(letterSpacing: 0.1),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: member.profilePic.isNotEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(
                                      "${state.localPath}/${member.profilePic}",
                                    ),
                                  ),
                                )
                              : const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(avatar),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Name'),
                    ),
                    controller: TextEditingController(text: member.name),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Mobile'),
                    ),
                    controller: TextEditingController(text: member.mobileNo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("D.O.B."),
                    ),
                    controller: TextEditingController(text: member.dob),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Relation"),
                    ),
                    controller: TextEditingController(text: member.relation),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Gender"),
                    ),
                    controller: TextEditingController(text: member.gender),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Blood Group"),
                    ),
                    controller: TextEditingController(text: member.bloodGroup),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Marital Status"),
                    ),
                    controller:
                        TextEditingController(text: member.maritalStatus),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Education'),
                    ),
                    controller: TextEditingController(text: member.education),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Occupation'),
                    ),
                    controller: TextEditingController(text: member.occupation),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    canRequestFocus: false,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Office Contact'),
                    ),
                    controller:
                        TextEditingController(text: member.officeContact),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    canRequestFocus: false,
                    readOnly: true,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text('Office Address'),
                    ),
                    controller:
                        TextEditingController(text: member.officeAddress),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
