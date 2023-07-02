import 'dart:io';

import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/model/member.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewMember extends StatefulWidget {
  const ViewMember(this.path, this.member, {super.key});

  final String path;
  final Member member;

  @override
  State<ViewMember> createState() => _ViewMemberState();
}

class _ViewMemberState extends State<ViewMember> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _officeContactController =
      TextEditingController();
  final TextEditingController _officeAddressController =
      TextEditingController();

  final DateFormat dateformatter = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.member.name ?? "";
    _mobileController.text = widget.member.mobileNo ?? "";
    _dateController.text =
        widget.member.dob ?? dateformatter.format(DateTime.now());
    debugPrint(widget.member.relation);
    _relationController.text = widget.member.relation ?? "";
    _genderController.text = widget.member.gender ?? "";
    _bloodGroupController.text = widget.member.bloodGroup ?? "";
    _maritalStatusController.text = widget.member.maritalStatus ?? "";
    _educationController.text = widget.member.education ?? "";
    _occupationController.text = widget.member.occupation ?? "";
    _officeContactController.text = widget.member.officeContact ?? "";
    _officeAddressController.text = widget.member.officeAddress ?? "";
  }

  @override
  Widget build(BuildContext context) {
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
                      image: widget.member.profilePic != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(
                                  "${widget.path}/${widget.member.profilePic}")),
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
                  hintText: 'Enter Name',
                ),
                controller: _nameController,
                onChanged: (value) => widget.member.name = value,
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
                  hintText: 'Enter Mobile',
                ),
                controller: _mobileController,
                onChanged: (value) => widget.member.mobileNo = value,
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
                controller: _dateController,
                onTap: null,
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
                controller: _relationController,
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
                controller: _genderController,
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
                controller: _bloodGroupController,
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
                controller: _maritalStatusController,
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
                  hintText: 'Enter Education',
                ),
                onChanged: (value) => widget.member.education = value,
                controller: _educationController,
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
                  hintText: 'Enter Occupation',
                ),
                onChanged: (value) => widget.member.occupation = value,
                controller: _occupationController,
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
                  hintText: 'Enter Office Contact',
                ),
                onChanged: (value) => widget.member.officeContact = value,
                controller: _officeContactController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextField(
                canRequestFocus: false,
                readOnly: true,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  label: Text('Office Address'),
                  hintText: 'Enter Office Address',
                ),
                onChanged: (value) => widget.member.officeAddress = value,
                controller: _officeAddressController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
