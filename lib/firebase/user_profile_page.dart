// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserProfileModel {
//   late String name = '';
//   late String phoneNumber = '';
//   String? bloodGroupValue; // Change to nullable
//   late DateTime? dateOfBirth = null;
//   late String address = '';
//   late String gender = 'Male';
//
//   UserProfileModel(
//       {required this.name,
//       required this.phoneNumber,
//       required this.bloodGroupValue,
//       required this.dateOfBirth,
//       required this.address,
//       required this.gender});
//
// // receiving data from server
//
//   factory UserProfileModel.fromMap(map) {
//     return UserProfileModel(
//         name: map['name'],
//         phoneNumber: map['phoneNumber'],
//         bloodGroupValue: map['bloodGroupValue'],
//         dateOfBirth: map['dateOfBirth'],
//         address: map['address'],
//         gender: map['gender']);
//   }
//
//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'uid': uid,
//   //     'userName': userName,
//   //     'email': email,
//   //     'password': password,
//   //   };
//   // }
//   void saveProfileToFirebase() {
//     FirebaseFirestore.instance.collection('userProfile').add({
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'bloodGroup': bloodGroupValue,
//       'dateOfBirth': dateOfBirth,
//       'address': address,
//       'gender': gender,
//     });
//   }
// }
