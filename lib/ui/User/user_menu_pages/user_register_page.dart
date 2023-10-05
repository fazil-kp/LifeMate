import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart'; // Import for TextInputFormatter

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final usersRef = FirebaseFirestore.instance.collection('userRegister');

  String documentId = '';
  String patientName = '';
  String bystanderName = '';
  String gender = 'Male';
  String phoneNumber = '';
  String bloodGroup = 'A+ve';
  String unit = '';
  String location = '';
  DateTime date = DateTime.now();
  String confirmationMessage = '';

  // Function to format date as "DD/MM/YYYY"
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Fill out the form to register for blood:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: Bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.accessibility_new),
                        border: InputBorder.none, labelText: 'Patient Name',labelStyle: TextStyle(fontFamily: Medium,color: Colors.black,fontSize: 16)),
                    onChanged: (value) {
                      setState(() {
                        patientName = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the patient name';
                      }
                      return null;
                    },
                    initialValue: patientName,
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                        border: InputBorder.none, labelText: 'Bystander Name',labelStyle: TextStyle(fontFamily: Medium,color: Colors.black,fontSize: 16)),
                    onChanged: (value) {
                      setState(() {
                        bystanderName = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the bystander name';
                      }
                      return null;
                    },
                    initialValue: bystanderName,
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
                  child: DropdownButtonFormField<String>(
                    value: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                    items: <String>['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_search_outlined),
                        border: InputBorder.none, labelText: 'Gender'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
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
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: InputBorder.none, labelText: 'Phone Number',labelStyle: TextStyle(fontFamily: Medium,color: Colors.black,fontSize: 16)),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]{0,10}$')),
                    ],
                    onChanged: (value) {
                      if (value.length <= 10) {
                        setState(() {
                          phoneNumber = value;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length != 10) {
                        return 'Please enter a 10-digit phone number';
                      }
                      return null;
                    },
                    initialValue: phoneNumber,
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
                  child: DropdownButtonFormField<String>(
                    value: bloodGroup,
                    onChanged: (value) {
                      setState(() {
                        bloodGroup = value!;
                      });
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
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.bloodtype_sharp),
                        border: InputBorder.none, labelText: 'Blood Group'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a blood group';
                      }
                      return null;
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
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_tree_sharp),
                        border: InputBorder.none, labelText: 'Units Required',labelStyle: TextStyle(fontFamily: Medium,color: Colors.black,fontSize: 16)),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        unit = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the required units';
                      }
                      return null;
                    },
                    initialValue: unit,
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
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        border: InputBorder.none, labelText: 'Location',labelStyle: TextStyle(fontFamily: Medium,color: Colors.black,fontSize: 16)),
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                    initialValue: location,
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
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(Icons.calendar_today),
                      ),
                      Text(
                        formatDate(date),
                        style: TextStyle(fontSize: 16,fontFamily: Bold,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (documentId.isEmpty) {
                          saveUserData();
                        } else {
                          updateUserData(documentId);
                        }
                      }
                    },
                    child:
                        Text(documentId.isEmpty ? 'Request' : 'Edit Request'),
                  ),
                ),
                Text(
                  confirmationMessage,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveUserData() {
    final userData = {
      'patientName': patientName,
      'bystanderName': bystanderName,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'bloodGroup': bloodGroup,
      'unit': unit,
      'location': location,
      'date': date,
    };

    usersRef.add(userData).then((DocumentReference document) {
      setState(() {
        documentId = document.id;
        patientName = '';
        bystanderName = '';
        gender = 'Male';
        phoneNumber = '';
        bloodGroup = 'A+ve';
        unit = '';
        location = '';
        date = DateTime.now();
        confirmationMessage = 'Request sent successfully';
      });
    });
  }

  void updateUserData(String documentId) {
    final userData = {
      'patientName': patientName,
      'bystanderName': bystanderName,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'bloodGroup': bloodGroup,
      'unit': unit,
      'location': location,
      'date': date,
    };

    usersRef.doc(documentId).update(userData).then((_) {
      setState(() {
        patientName = '';
        bystanderName = '';
        gender = 'Male';
        phoneNumber = '';
        bloodGroup = 'A+ve';
        unit = '';
        location = '';
        date = DateTime.now();
        confirmationMessage = 'Request updated successfully';
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != date)
      setState(() {
        date = pickedDate;
      });
  }
}
