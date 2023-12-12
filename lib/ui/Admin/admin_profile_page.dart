// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key, required this.userData}) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String name;
  late String phoneNumber;
  String? bloodGroupValue;
  DateTime? dateOfBirth; // Make dateOfBirth a DateTime type
  late String address;
  late String gender;
  bool isEditMode = false;
  String? updateStatus;
  DateTime? lastUpdatedTime;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    final userData = widget.userData;
    name = userData['name'] ?? '';
    phoneNumber = userData['phoneNumber'] ?? '';
    bloodGroupValue = userData['bloodGroup'];
    dateOfBirth = userData['dateOfBirth']?.toDate();
    address = userData['address'] ?? '';
    gender = userData['gender'] ?? 'Male';
    lastUpdatedTime = userData['lastUpdatedTime']?.toDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontFamily: Medium,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          name = value!;
                        },
                        initialValue: name,
                        enabled: isEditMode,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            fontFamily: Medium,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }

                          final sanitizedValue =
                              value.replaceAll(RegExp(r'[^0-9]'), '');

                          if (sanitizedValue.length != 10) {
                            return 'Invalid phone number. Please enter exactly 10 digits.';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          phoneNumber = value!;
                        },
                        initialValue: phoneNumber,
                        enabled: isEditMode,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.calendar_month),
                      title: Text(
                        dateOfBirth != null
                            ? '${dateOfBirth!.toLocal()}'.split(' ')[0]
                            : 'D-O-B',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: Medium,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        if (isEditMode) {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: dateOfBirth ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null &&
                              selectedDate != dateOfBirth) {
                            setState(() {
                              dateOfBirth = selectedDate;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IgnorePointer(
                        ignoring: !isEditMode,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 9,
                            ),
                            Icon(Icons.bloodtype_sharp),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Blood Group',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: Medium,
                                    color: Colors.black,
                                  ),
                                ),
                                value: bloodGroupValue,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Blood group is required';
                                  }
                                  return null;
                                },
                                items: <String>[
                                  'A+ve',
                                  'B+ve',
                                  'O+ve',
                                  'AB+ve',
                                  'A-ve',
                                  'B-ve',
                                  'O-ve',
                                  'AB-ve'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (isEditMode) {
                                    setState(() {
                                      bloodGroupValue = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: InputBorder.none,
                          labelText: 'Address',
                          labelStyle: TextStyle(
                            fontFamily: Medium,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          address = value!;
                        },
                        initialValue: address,
                        enabled: isEditMode,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 17,
                          ),
                          Text(
                            'Gender:',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: Medium,
                              color: Colors.black,
                            ),
                          ),
                          Radio<String>(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              if (isEditMode) {
                                setState(() {
                                  gender = value!;
                                });
                              }
                            },
                            toggleable: isEditMode,
                          ),
                          Text(
                            'Male',
                            style: TextStyle(fontFamily: Bold),
                          ),
                          Radio<String>(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              if (isEditMode) {
                                setState(() {
                                  gender = value!;
                                });
                              }
                            },
                            toggleable: isEditMode,
                          ),
                          Text(
                            'Female',
                            style: TextStyle(fontFamily: Bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isEditMode) {
                        if (_formKey.currentState!.validate()) {
                          if (dateOfBirth == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Date of Birth is required'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            _formKey.currentState!.save();
                            if (widget.userData.isEmpty) {
                              saveProfileToFirebase();
                            } else {
                              updateProfileInFirebase();
                            }
                          }
                        }
                      } else {
                        setState(() {
                          isEditMode = true;
                        });
                      }
                    },
                    child: Text(isEditMode ? 'Save Profile' : 'Edit Profile'),
                  ),
                  if (updateStatus != null && lastUpdatedTime != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            updateStatus!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Last Updated: ${lastUpdatedTime!.toLocal()}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveProfileToFirebase() async {
    final currentTime = DateTime.now();
    final userDataRef = FirebaseFirestore.instance.collection('adminProfile');
    final newDocRef = await userDataRef.add({
      'name': name,
      'phoneNumber': phoneNumber,
      'bloodGroup': bloodGroupValue,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'gender': gender,
      'lastUpdatedTime': currentTime,
    });

    setState(() {
      updateStatus = 'Admin Profile saved successfully!';
      lastUpdatedTime = currentTime;
    });

    showSnackBar('Admin Profile saved successfully!');
  }

  void updateProfileInFirebase() async {
    final currentTime = DateTime.now();
    final userDataRef = FirebaseFirestore.instance.collection('adminProfile');
    await userDataRef.doc(widget.userData['documentId']).update({
      'name': name,
      'phoneNumber': phoneNumber,
      'bloodGroup': bloodGroupValue,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'gender': gender,
      'lastUpdatedTime': currentTime,
    });

    setState(() {
      updateStatus = 'Admin Profile updated successfully!';
      lastUpdatedTime = currentTime;
    });

    showSnackBar('Admin Profile updated successfully!');
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
