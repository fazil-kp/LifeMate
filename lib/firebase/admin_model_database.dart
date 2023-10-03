class AdminModel {
  String? uid;
  String? userName;
  String? password;

  AdminModel(
      {required this.uid,
        required this.userName,
        required this.password});

  // receiving data from server

  factory AdminModel.fromMap(map) {
    return AdminModel(
        uid: map['uid'],
        userName: map['userName'],
        password: map['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'password': password,
    };
  }
}
