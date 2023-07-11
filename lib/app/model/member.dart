class Member {
  int memberId;
  String name;
  String mobileNo;
  String dob;
  String profilePic;
  String relation;
  String gender;
  String bloodGroup;
  String maritalStatus;
  String education;
  String occupation;
  String officeContact;
  String officeAddress;
  bool isMainMember;

  Member.empty(this.memberId)
      : name = "",
        mobileNo = "",
        dob = "",
        profilePic = "",
        relation = "",
        gender = "",
        bloodGroup = "",
        maritalStatus = "",
        education = "",
        occupation = "",
        officeContact = "",
        officeAddress = "",
        isMainMember = false;

  Member({
    required this.memberId,
    required this.name,
    required this.mobileNo,
    required this.dob,
    required this.profilePic,
    required this.relation,
    required this.gender,
    required this.bloodGroup,
    required this.maritalStatus,
    required this.education,
    required this.occupation,
    required this.officeContact,
    required this.officeAddress,
    required this.isMainMember,
  });

  Map<String, dynamic> toMap() {
    return {
      'Member_Id': memberId,
      'Name': name,
      'Mobile_No': mobileNo,
      'DOB': dob,
      'Profile_Pic': profilePic,
      'Relation': relation,
      'Gender': gender,
      'Blood_Group': bloodGroup,
      'Marital_Status': maritalStatus,
      'Education': education,
      'Occupation': occupation,
      'Office_Contact': officeContact,
      'Office_Address': officeAddress,
      'Is_Main_Member': isMainMember,
    };
  }

  Member.fromMap(Map<String, dynamic> map)
      : memberId = map["Member_Id"],
        name = map["Name"],
        mobileNo = map["Mobile_No"],
        dob = map["DOB"],
        profilePic = map["Profile_Pic"],
        relation = map["Relation"],
        gender = map["Gender"],
        bloodGroup = map["Blood_Group"],
        maritalStatus = map["Marital_Status"],
        education = map["Education"],
        occupation = map["Occupation"],
        officeContact = map["Office_Contact"],
        officeAddress = map['Office_Address'],
        isMainMember = map['Is_Main_Member'];

  @override
  String toString() {
    return 'Member{Id: $memberId, Name: $name, Mobile_No: $mobileNo, profilePic: $profilePic}';
  }
}
