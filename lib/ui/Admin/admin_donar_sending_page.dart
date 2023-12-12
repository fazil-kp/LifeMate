import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';

class AdminDonarSendingPage extends StatefulWidget {
  const AdminDonarSendingPage({Key? key});

  @override
  _AdminDonarSendingPageState createState() => _AdminDonarSendingPageState();
}

class _AdminDonarSendingPageState extends State<AdminDonarSendingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _donarNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  String _successMessage = '';

  void _sendData() async {
    if (_formKey.currentState!.validate()) {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Define the data to be saved
      Map<String, dynamic> data = {
        'donarName': _donarNameController.text,
        'phoneNumber': _phoneNumberController.text,
        'location': _locationController.text,
      };

      // Save data to Firestore collection
      await firestore.collection('adminDonar').add(data);

      // Clear the form after saving
      _donarNameController.clear();
      _phoneNumberController.clear();
      _locationController.clear();

      // Show a success message
      setState(() {
        _successMessage = 'Data sent successfully!';
      });
    }
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
          ),
        ),
        title: const Text(
          'Request Sending',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _donarNameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'Donor Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a donor name';
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
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (value.length != 10) {
                      return 'Phone number must be 10 digits';
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
                  controller: _locationController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      border: InputBorder.none,
                      labelText: 'Location'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: _sendData,
                child: Text(
                  'Send',
                  style: TextStyle(
                      fontFamily: Bold,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  _successMessage,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
