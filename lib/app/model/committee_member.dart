class CommitteeMember {
  final String name;
  final String designation;
  final String mobileNo;

  const CommitteeMember(this.name, this.designation, this.mobileNo);

  CommitteeMember.fromMap(Map<String, dynamic> map)
      : name = map["Name"],
        designation = map["Designation"],
        mobileNo = map["Mobile_No"];

  @override
  String toString() {
    return 'CommitteeMember{Name: $name, Designation: $designation, Mobile No: $mobileNo}';
  }
}
