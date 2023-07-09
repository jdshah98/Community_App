import 'dart:async';

import 'package:community_app/app/repository/user.dart';
import 'package:community_app/app/repository/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with WidgetsBindingObserver {
  final TextEditingController _contactController =
      TextEditingController(text: null);
  final TextEditingController _passwordController =
      TextEditingController(text: null);
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: null);

  final FocusNode _contactNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  List<SimCard> _simCardList = <SimCard>[];
  bool showPassword = false;
  bool isResetDisabled = false;
  bool isContactChanged = false;
  bool isPasswordChanged = false;
  bool isDialogVisible = false;

  getMobileNumber() async {
    bool isPermissionGranted = await MobileNumber.hasPhonePermission;
    if (!isPermissionGranted) {
      checkPermission();
      return;
    }
    try {
      _simCardList = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;

    setState(() {});
  }

  checkPermission() {
    Permission.phone.request().then(
      (status) {
        if (status.isPermanentlyDenied) {
          setState(() => isDialogVisible = true);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text(
                    "Phone Permission is Required!! Open App Settings"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                    onPressed: () {
                      openAppSettings().then((value) {
                        Navigator.pop(context);
                        setState(() => isDialogVisible = false);
                      });
                    },
                    child: const Text("Continue"),
                  ),
                ],
              );
            },
          );
        } else if (status.isGranted) {
          setState(() => isDialogVisible = false);
          getMobileNumber();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getMobileNumber();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    debugPrint("Hello: $state");
    if (state == AppLifecycleState.resumed) {
      if (!isDialogVisible) {
        checkPermission();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? get _contactError {
    if (!isContactChanged) {
      return null;
    }

    final text = _contactController.value.text;

    if (text.isEmpty) {
      return 'Contact No is Required!!';
    }
    if (text.length != 10) {
      return 'Contact No must be 10 digits long!!';
    }

    return null;
  }

  String? get _passwordError {
    if (!isPasswordChanged) {
      return null;
    }

    final text = _passwordController.value.text;

    if (text.isEmpty) {
      return 'Password is Required!!';
    }
    if (text.length < 4 || text.length > 12) {
      return 'Password should be atleast 4 and atmost 12 characters!!';
    }

    return null;
  }

  String? get _confirmPasswordError {
    final password = _passwordController.value.text;
    final text = _confirmPasswordController.value.text;

    if (password != text) {
      return 'Passwords Not Match!!';
    }

    return null;
  }

  showSnackbar(final String data, final Color? color) {
    final SnackBar snackBar = SnackBar(
      content: Text(data),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  resetPassword() async {
    if (!isContactChanged || _contactError != null) {
      FocusScope.of(context).requestFocus(_contactNode);
      return;
    }

    if (!isPasswordChanged || _passwordError != null) {
      FocusScope.of(context).requestFocus(_passwordNode);
      return;
    }

    if (_confirmPasswordError != null) {
      FocusScope.of(context).requestFocus(_confirmPasswordNode);
      return;
    }

    setState(() => isResetDisabled = true);

    if (_simCardList.isEmpty) {
      showSnackbar(
          "No Sim Detected!! You're not authorized to change password!!",
          Colors.red);
      Future.delayed(
        const Duration(seconds: 2),
        () => setState(() => isResetDisabled = false),
      );
      return;
    }

    String contactNo = _contactController.value.text;
    String password = _passwordController.value.text;

    for (SimCard simcard in _simCardList) {
      if (simcard.number!.endsWith(contactNo)) {
        final isConnected = await Utils.isInternetConnected();
        if (isConnected) {
          await UserRepository.updateUser(contactNo, {'Password': password});
          if (context.mounted) {
            showSnackbar("Your Password Changed!!", Colors.green);
            Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.pop(context),
            );
          }
        } else {
          showSnackbar("Please Check Your Internet!!", Colors.red);
          Future.delayed(
            const Duration(seconds: 2),
            () => setState(() => isResetDisabled = false),
          );
        }
      } else {
        showSnackbar(
            "You're not authorized to Change Password!! Contact no with Sim Card not Found",
            Colors.red);
        Future.delayed(
          const Duration(seconds: 2),
          () {
            setState(() => isResetDisabled = false);
            FocusScope.of(context).requestFocus(_contactNode);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _contactController,
                focusNode: _contactNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  border: const OutlineInputBorder(),
                  labelText: 'Contact No',
                  hintText: 'Enter Contact No',
                  errorText: _contactError,
                ),
                onChanged: (value) => setState(() => isContactChanged = true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !showPassword,
                controller: _passwordController,
                focusNode: _passwordNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  errorText: _passwordError,
                ),
                onChanged: (value) => setState(() => isPasswordChanged = true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  border: const OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  hintText: 'Retype Password',
                  errorText: _confirmPasswordError,
                ),
                onChanged: (value) => setState(() => {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width - 32, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                onPressed: isResetDisabled ? null : resetPassword,
                child: const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
