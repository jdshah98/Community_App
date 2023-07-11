import 'dart:io';

import 'package:community_app/app/constants/arrays.dart';
import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/member.dart';
import 'package:community_app/app/repository/storage.dart';
import 'package:community_app/app/repository/user.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show extension;
import 'package:provider/provider.dart';

class AddMember extends StatefulWidget {
  const AddMember(this.memberId, {super.key});

  final int memberId;

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
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

  final ImagePicker _picker = ImagePicker();
  final DateFormat dateformatter = DateFormat("dd-MM-yyyy");

  FileImage? profileImage;

  late String localPath;
  late String contactNo;
  late Member member;

  Future<String?> _openImagePicker(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );
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
            "member_${member.memberId}${extension(croppedFile.path)}";

        File inputFile = File(croppedFile.path);
        await Directory("$localPath/temp").create();
        await inputFile.copy("$localPath/temp/$imageName");

        setState(() {
          member.profilePic = imageName;
        });
        return "temp/$imageName";
      } else {
        debugPrint("Cancelled Crop");
        return null;
      }
    } else {
      debugPrint("Cancelled Image");
      return null;
    }
  }

  Future<String?> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Text(
                  "Profile photo",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      String? imageName =
                          await _openImagePicker(ImageSource.camera);
                      if (mounted) {
                        Navigator.pop(context, imageName);
                      }
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
                    onTap: () async {
                      String? imageName =
                          await _openImagePicker(ImageSource.gallery);
                      if (mounted) {
                        Navigator.pop(context, imageName);
                      }
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
    localPath = Provider.of<AppState>(context, listen: false).localPath;
    contactNo = Provider.of<AppState>(context, listen: false).user.contactNo;
    member = Member.empty(widget.memberId);
    _dateController.text = dateformatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
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
                          image: profileImage != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: profileImage!,
                                )
                              : const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(avatar),
                                ),
                        ),
                      ),
                      FloatingActionButton.small(
                        shape: const CircleBorder(),
                        onPressed: () {
                          _showModalBottomSheet(context).then((value) {
                            if (value != null) {
                              if (profileImage != null) {
                                profileImage!.evict().then((success) {
                                  setState(() {
                                    profileImage =
                                        FileImage(File("$localPath/$value"));
                                  });
                                });
                              } else {
                                setState(() {
                                  profileImage =
                                      FileImage(File("$localPath/$value"));
                                });
                              }
                            }
                          });
                        },
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
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        _dateController.text = dateformatter.format(value);
                      }
                    }),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("D.O.B."),
                    ),
                    controller: _dateController,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    onChanged: (value) => member.dob = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                        controller: _relationController,
                        onSelected: (value) => member.relation = value ?? "",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                        controller: _genderController,
                        onSelected: (value) => member.gender = value ?? "",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                        controller: _bloodGroupController,
                        onSelected: (value) => member.bloodGroup = value ?? "",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                        controller: _maritalStatusController,
                        onSelected: (value) =>
                            member.maritalStatus = value ?? "",
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _addMember(context),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      child: Text("Submit"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _addMember(BuildContext context) async {
    member.name = _nameController.value.text;
    member.mobileNo = _mobileController.value.text;
    member.dob = _dateController.value.text;
    member.relation = _relationController.value.text;
    member.gender = _genderController.value.text;
    member.bloodGroup = _bloodGroupController.value.text;
    member.maritalStatus = _maritalStatusController.value.text;
    member.education = _educationController.value.text;
    member.occupation = _occupationController.value.text;
    member.officeContact = _officeContactController.value.text;
    member.officeAddress = _officeAddressController.value.text;

    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Updating...')
              ],
            ),
          ),
        );
      },
    );

    if (profileImage != null) {
      await CloudStorage.upload(
        "profile_pic/user_$contactNo/${member.profilePic}",
        profileImage!.file.path,
      );

      await profileImage!.file.copy("$localPath/${member.profilePic}");
    }

    if (!mounted) {
      return;
    }

    Provider.of<AppState>(context, listen: false)
        .addMember(widget.memberId, member);

    var user = Provider.of<AppState>(context, listen: false).user;

    await UserRepository.updateUser(contactNo, user.toMap());

    await SharedPref.setLoggedUser(user);

    if (!mounted) {
      return;
    }

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Member Added Successfully"),
      duration: Duration(seconds: 1),
    ));

    Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
  }
}
