import 'package:community_app/app/model/member.dart';

class User {
  String contactNo;
  String password;
  bool isAdmin;
  String address;
  String area;
  String nativePlace;
  String casteType;
  List<Member> members;

  User.empty()
      : contactNo = "",
        password = "",
        isAdmin = false,
        address = "",
        area = "",
        nativePlace = "",
        casteType = "",
        members = List.empty();

  User(
    this.contactNo,
    this.password,
    this.isAdmin,
    this.address,
    this.area,
    this.nativePlace,
    this.casteType,
    this.members,
  );

  Map<String, dynamic> toMap() {
    return {
      'Contact_No': contactNo,
      'Password': password,
      'Is_Admin': isAdmin,
      'Address': address,
      'Area': area,
      'Native_Place': nativePlace,
      'Caste_Type': casteType,
      'Members': members.map((member) => member.toMap()).toList(),
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
        members = List<Member>.from(
          (map["Members"] as List<dynamic>).map(
            (memberMap) => Member.fromMap(memberMap as Map<String, dynamic>),
          ),
        );

  @override
  String toString() {
    return 'User{contact_no: $contactNo, password: $password, is_admin: $isAdmin, members: $members}';
  }
}
