import 'package:community_app/app/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _contactController =
      TextEditingController(text: null);
  final TextEditingController _passwordController =
      TextEditingController(text: null);
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: null);

  List<SimCard> _simCardList = <SimCard>[];
  bool showPassword = false;
  bool isResetDisabled = false;

  getMobileNumber() async {
    bool isPermissionGranted = await MobileNumber.hasPhonePermission;
    if (!isPermissionGranted) {
      await MobileNumber.requestPhonePermission;
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

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        getMobileNumber();
      }
    });
    getMobileNumber();
  }

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? get _contactError {
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

  resetPassword() async {
    setState(() => isResetDisabled = true);

    if (_contactError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_contactError!),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      Future.delayed(
        const Duration(seconds: 2),
        () => setState(() => isResetDisabled = false),
      );
      return;
    }
    if (_passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_passwordError!),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      Future.delayed(
        const Duration(seconds: 2),
        () => setState(() => isResetDisabled = false),
      );
      return;
    }

    if (_confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_confirmPasswordError!),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
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
        await UserRepository.updatePassword(contactNo, password);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your Password Changed!!"),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(
            const Duration(seconds: 2),
            () => Navigator.pop(context),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You are not authorized to Change Password!!"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        Future.delayed(
          const Duration(seconds: 2),
          () => setState(() => isResetDisabled = false),
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
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  border: const OutlineInputBorder(),
                  labelText: 'Contact No',
                  hintText: 'Enter Contact No',
                  errorText: _contactError,
                ),
                onChanged: (value) => setState(() => {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !showPassword,
                controller: _passwordController,
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
                onChanged: (value) => setState(() => {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
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
