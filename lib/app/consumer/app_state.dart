import 'package:community_app/app/model/member.dart';
import 'package:community_app/app/model/user.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  User _user;
  String _localPath;

  AppState()
      : _user = User.empty(),
        _localPath = "";

  User get user => _user;

  String get localPath => _localPath;

  get memberCount => _user.members.length;

  void addMember(int memberId, Member member) {
    _user.members[memberId.toString()] = member;
    notifyListeners();
  }

  void removeMember(int memberId) {
    _user.members.removeWhere((key, value) => key == memberId.toString());
    notifyListeners();
  }

  void updateMember(int memberId, Member member) {
    _user.members[memberId.toString()] = member;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setLocalPath(String localPath) {
    _localPath = localPath;
  }
}
