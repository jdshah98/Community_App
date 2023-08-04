import 'dart:async';

import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/exceptions/data_not_found.dart';
import 'package:community_app/app/model/user.dart';
import 'package:community_app/app/repository/storage.dart';
import 'package:community_app/app/repository/user.dart';
import 'package:community_app/app/repository/utils.dart';
import 'package:community_app/app/screens/auth/forgot_password.dart';
import 'package:community_app/app/screens/features/dashboard.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contactController =
      TextEditingController(text: null);
  final TextEditingController _passwordController =
      TextEditingController(text: null);

  final FocusNode _contactNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  String localPath = "";

  bool isContactChanged = false;
  bool isPasswordChanged = false;
  bool showPassword = false;
  bool isLoginDisabled = false;

  fetchLocalPath() async {
    localPath = (await getApplicationDocumentsDirectory()).path;
  }

  @override
  void initState() {
    super.initState();
    fetchLocalPath();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: screenHeight * 0.3,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 32),
              child: Image(
                image: const AssetImage(roundedLogo),
                width: screenHeight * 0.25,
                height: screenHeight * 0.25,
              ),
            ),
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  ),
                  child: const Text('FORGOT PASSWORD?'),
                ),
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
                onPressed: isLoginDisabled ? null : login,
                child: const Text('LOGIN', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
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

  showSnackbar(final String data) {
    final SnackBar snackBar = SnackBar(
      content: Text(data),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  login() async {
    final String contact = _contactController.value.text;
    final String password = _passwordController.value.text;

    if (!isContactChanged || _contactError != null) {
      FocusScope.of(context).requestFocus(_contactNode);
      return;
    }

    if (!isPasswordChanged || _passwordError != null) {
      FocusScope.of(context).requestFocus(_passwordNode);
      return;
    }

    setState(() => isLoginDisabled = true);
    final isConnected = await Utils.isInternetConnected();
    if (isConnected) {
      try {
        final User user = await UserRepository.getUser(contact);
        if (user.password == password) {
          SharedPref.setLoggedUser(user);
          SharedPref.setString(SharedPref.loggedInContact, user.contactNo);
          SharedPref.setLoggedIn();
          SharedPref.setString(SharedPref.localPath, localPath);

          user.members.forEach((key, value) {
            if (value.profilePic.isNotEmpty) {
              CloudStorage.fetchAndSaveToLocal(
                "profile_pic/user_${user.contactNo}/${value.profilePic}",
                "$localPath/${value.profilePic}",
              );
            }
          });

          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          }
        } else {
          // Invalid Password
          if (context.mounted) {
            showSnackbar("Invalid Password!!");
            Future.delayed(
              const Duration(seconds: 2),
              () {
                setState(() => isLoginDisabled = false);
                FocusScope.of(context).requestFocus(_passwordNode);
              },
            );
          }
        }
      } on DataNotFound {
        // Member not Found Exception
        showSnackbar("You are not member!!");
        Future.delayed(
          const Duration(seconds: 2),
          () => setState(() => isLoginDisabled = false),
        );
      } catch (e) {
        debugPrint("Login Exception: ");
        debugPrint(e.toString());
        showSnackbar("Server Error!!");
        Future.delayed(
          const Duration(seconds: 2),
          () => setState(() => isLoginDisabled = false),
        );
      }
    } else {
      showSnackbar("Please Check Your Internet!!");
      Future.delayed(
        const Duration(seconds: 2),
        () => setState(() => isLoginDisabled = false),
      );
    }
  }
}
