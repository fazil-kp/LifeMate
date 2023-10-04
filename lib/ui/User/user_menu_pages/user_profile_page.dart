import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.userData}) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String name;
  late String phoneNumber;
  String? bloodGroupValue;
  late DateTime? dateOfBirth;
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
        // ... (app bar code)
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    // Add phone number validation if needed
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                  initialValue: phoneNumber,
                  enabled: isEditMode,
                ),

                // Date of Birth Input
                ListTile(
                  title: Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    dateOfBirth != null
                        ? '${dateOfBirth!.toLocal()}'.split(' ')[0]
                        : 'Select Date',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () async {
                    if (isEditMode) {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: dateOfBirth ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null && selectedDate != dateOfBirth) {
                        setState(() {
                          dateOfBirth = selectedDate;
                        });
                      }
                    }
                  },
                ),

                // Dropdown for Blood Group
                IgnorePointer(
                  ignoring: !isEditMode,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Blood Group'),
                    value: bloodGroupValue,
                    items: <String>['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-']
                        .map<DropdownMenuItem<String>>((String value) {
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

                // Address Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
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

                // Gender Selection
                Row(
                  children: <Widget>[
                    Text('Gender:'),
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
                    Text('Male'),
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
                    Text('Female'),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    if (isEditMode) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (widget.userData.isEmpty) {
                          saveProfileToFirebase();
                        } else {
                          updateProfileInFirebase();
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
    );
  }

  void saveProfileToFirebase() async {
    final currentTime = DateTime.now();
    final userDataRef = FirebaseFirestore.instance.collection('userProfile');
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
      updateStatus = 'Profile saved successfully!';
      lastUpdatedTime = currentTime;
    });

    showSnackBar('Profile saved successfully!');
  }

  void updateProfileInFirebase() async {
    final currentTime = DateTime.now();
    final userDataRef = FirebaseFirestore.instance.collection('userProfile');
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
      updateStatus = 'Profile updated successfully!';
      lastUpdatedTime = currentTime;
    });

    showSnackBar('Profile updated successfully!');
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
