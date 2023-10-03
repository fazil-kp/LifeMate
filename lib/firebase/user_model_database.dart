class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? password;

  UserModel(
      {required this.uid,
      required this.userName,
      required this.email,
      required this.password});

  // receiving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        userName: map['userName'],
        email: map['email'],
        password: map['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}
