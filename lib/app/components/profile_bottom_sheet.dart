import 'package:community_app/app/model/member.dart';
import 'package:community_app/app/screens/features/profile/edit_member.dart';
import 'package:community_app/app/screens/features/profile/view_member.dart';
import 'package:flutter/material.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet(this.contactNo, this.path, this.member, {super.key});

  final String contactNo;
  final String path;
  final Member member;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Action",
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 18,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ViewMember(path, member),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.visibility,
                      size: 26,
                    ),
                  ),
                  Text(
                    "View",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditMember(contactNo, path, member),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.edit,
                      size: 26,
                    ),
                  ),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.close,
                      size: 26,
                    ),
                  ),
                  Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
