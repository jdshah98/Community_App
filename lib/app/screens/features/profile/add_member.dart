import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/constants/arrays.dart';
import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/model/member.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class AddMember extends StatefulWidget {
  const AddMember(this.contactNo, this.path, this.memberId, {super.key});

  final String? contactNo;
  final String? path;
  final int memberId;

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");
  final Reference storageRef = FirebaseStorage.instance.ref("profile_pic");
  final ImagePicker _picker = ImagePicker();
  final DateFormat dateformatter = DateFormat("dd-MM-yyyy");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _officeContactController =
      TextEditingController();
  final TextEditingController _officeAddressController =
      TextEditingController();

  late Member member;

  void _openImagePicker(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: source, preferredCameraDevice: CameraDevice.front);
    if (pickedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color.fromARGB(255, 74, 67, 94),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        final String imageName =
            "member_${widget.memberId}${extension(croppedFile.path)}";
        final imageRef =
            storageRef.child("user_${widget.contactNo}/$imageName");
        File inputFile = File(croppedFile.path);
        await imageRef.putFile(inputFile);
        // final downloadUrl = await imageRef.getDownloadURL();
        // debugPrint("Url: $downloadUrl");
        inputFile.copy("${widget.path}/$imageName");

        setState(() {
          member.profilePic = imageName;
        });
      } else {
        debugPrint("Cancelled Crop");
      }
    } else {
      debugPrint("Cancelled Image");
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile photo",
                      style: TextStyle(
                          fontSize: 18, color: Colors.deepPurpleAccent),
                    ),
                    InkWell(
                      onTap: () {},
                      splashColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _openImagePicker(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    splashColor: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 36,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        const Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _openImagePicker(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    splashColor: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            size: 36,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    member = Member(memberId: widget.memberId);
    _dateController.text = dateformatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Member",
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
                      image: member.profilePic != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                  File("${widget.path}/${member.profilePic}")),
                            )
                          : const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(avatar),
                            ),
                    ),
                  ),
                  FloatingActionButton.small(
                    shape: const CircleBorder(),
                    onPressed: () => _showModalBottomSheet(context),
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Name'),
                  hintText: 'Enter Name',
                ),
                onChanged: (value) => member.name = value,
                controller: _nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Mobile'),
                  hintText: 'Enter Mobile',
                ),
                onChanged: (value) => member.mobileNo = value,
                controller: _mobileController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then(
                    (value) =>
                        _dateController.text = dateformatter.format(value!),
                  );
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("D.O.B."),
                ),
                controller: _dateController,
                readOnly: true,
                keyboardType: TextInputType.none,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width - 32,
                      menuHeight: 300,
                      dropdownMenuEntries: relationList.map((e) {
                        return DropdownMenuEntry(value: e, label: e);
                      }).toList(),
                      label: const Text("Select Relation"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width - 32,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 'MALE', label: 'MALE'),
                        DropdownMenuEntry(value: 'FEMALE', label: 'FEMALE'),
                      ],
                      label: const Text("Select Gender"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width - 32,
                      menuHeight: 300,
                      dropdownMenuEntries: bloodGroupList.map((e) {
                        return DropdownMenuEntry(value: e, label: e);
                      }).toList(),
                      label: const Text("Select Blood Group"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width - 32,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                            value: 'Unmarried', label: 'Unmarried'),
                        DropdownMenuEntry(value: 'Married', label: 'Married'),
                      ],
                      label: const Text("Select Marital Status"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Education'),
                  hintText: 'Enter Education',
                ),
                onChanged: (value) => member.education = value,
                controller: _educationController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Occupation'),
                  hintText: 'Enter Occupation',
                ),
                onChanged: (value) => member.occupation = value,
                controller: _occupationController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Office Contact'),
                  hintText: 'Enter Office Contact',
                ),
                onChanged: (value) => member.officeContact = value,
                controller: _officeContactController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Office Address'),
                  hintText: 'Enter Office Address',
                ),
                onChanged: (value) => member.officeAddress = value,
                controller: _officeAddressController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
