class UserModel {
  String? uid;
  String? firstName;
  String? secondName;
  String? email;
  UserModel({
    this.uid,
    this.firstName,
    this.secondName,
    this.email,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName
    };
  }
}
