import 'package:community_app/app/model/member.dart';

class User {
  String contactNo;
  String password;
  bool isAdmin;
  String address;
  String area;
  String nativePlace;
  String casteType;
  Map<String, Member> members;

  User.empty()
      : contactNo = "",
        password = "",
        isAdmin = false,
        address = "",
        area = "",
        nativePlace = "",
        casteType = "",
        members = <String, Member>{};

  User({
    required this.contactNo,
    required this.password,
    required this.isAdmin,
    required this.address,
    required this.area,
    required this.nativePlace,
    required this.casteType,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return {
      'Contact_No': contactNo,
      'Password': password,
      'Is_Admin': isAdmin,
      'Address': address,
      'Area': area,
      'Native_Place': nativePlace,
      'Caste_Type': casteType,
      'Members': members.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : contactNo = map["Contact_No"],
        password = map["Password"],
        isAdmin = map["Is_Admin"],
        address = map["Address"],
        area = map["Area"],
        nativePlace = map["Native_Place"],
        casteType = map["Caste_Type"],
        members = (map["Members"] as Map<String, dynamic>).map((key, value) =>
            MapEntry(key, Member.fromMap(value as Map<String, dynamic>)));

  @override
  String toString() {
    return 'User{contact_no: $contactNo, password: $password, is_admin: $isAdmin, members: $members}';
  }
}
