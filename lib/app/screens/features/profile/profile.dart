import 'dart:io';

import 'package:community_app/app/components/profile_bottom_sheet.dart';
import 'package:community_app/app/constants/arrays.dart';
import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/user.dart';
import 'package:community_app/app/repository/user.dart';
import 'package:community_app/app/screens/features/profile/add_member.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _nativePlaceController = TextEditingController();
  final TextEditingController _casteTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var user = Provider.of<AppState>(context, listen: false).user;
    _addressController.text = user.address;
    _areaController.text = user.area;
    _nativePlaceController.text = user.nativePlace;
    _casteTypeController.text = user.casteType;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(letterSpacing: 0.1),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(),
                      label: Text('Residential Address'),
                      hintText: 'Enter Address',
                    ),
                    minLines: 1,
                    maxLines: 4,
                    controller: _addressController,
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
                        dropdownMenuEntries: areaList.map((e) {
                          return DropdownMenuEntry(value: e, label: e);
                        }).toList(),
                        label: const Text("Select Area"),
                        errorText: _areaError,
                        enableFilter: true,
                        enableSearch: true,
                        requestFocusOnTap: true,
                        controller: _areaController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Native Place"),
                      hintText: "Enter Native Place",
                    ),
                    controller: _nativePlaceController,
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
                          DropdownMenuEntry(value: 'Dasa', label: 'Dasa'),
                          DropdownMenuEntry(value: 'Visa', label: 'Visa'),
                        ],
                        label: const Text("Select Dasa/Visa"),
                        controller: _casteTypeController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 32, 48),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onPressed: () => updateUserProfile(state.user),
                    child: const Text("UPDATE", style: TextStyle(fontSize: 16)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.deepPurpleAccent,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Family Members",
                                        style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddMember(
                                              state.user.members.length + 1,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(Icons.add,
                                            color: Colors.white),
                                        label: const Text(
                                          "Member",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] +
                              state.user.members
                                  .map(
                                    (key, member) => MapEntry<String, Widget>(
                                        key,
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            debugPrint(member.profilePic);
                                            showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                              builder: (context) =>
                                                  ProfileBottomSheet(
                                                member.memberId,
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    shape: BoxShape.circle,
                                                    image: member.profilePic
                                                            .isNotEmpty
                                                        ? DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: FileImage(File(
                                                                "${state.localPath}/${member.profilePic}")),
                                                          )
                                                        : const DecorationImage(
                                                            image: AssetImage(
                                                                avatar),
                                                          ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            140,
                                                  ),
                                                  child: Text(
                                                    member.name.toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  )
                                  .values
                                  .toList(),
                        ),
                      ),
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

  String? get _areaError {
    final area = _areaController.value.text;

    if (area.isEmpty) {
      return "Area is Required!!";
    }

    if (!areaList.contains(area)) {
      return "Please Select Valid Area!!";
    }

    return null;
  }

  updateUserProfile(User user) async {
    final String address = _addressController.value.text;
    final String area = _areaController.value.text;
    final String nativePlace = _nativePlaceController.value.text;
    final String casteType = _casteTypeController.value.text;

    if (_areaError != null) {
      return;
    }

    debugPrint(address);
    debugPrint(area);
    debugPrint(nativePlace);
    debugPrint(casteType);

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

    await UserRepository.updateUser(user.contactNo, {
      'Address': address,
      'Area': area,
      'Native_Place': nativePlace,
      'Caste_Type': casteType,
    });

    user.address = address;
    user.area = area;
    user.nativePlace = nativePlace;
    user.casteType = casteType;

    await SharedPref.setLoggedUser(user);

    if (!mounted) {
      return;
    }

    Provider.of<AppState>(context, listen: false).setUser(user);

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Updated Successfully"),
      duration: Duration(seconds: 1),
    ));
  }
}
