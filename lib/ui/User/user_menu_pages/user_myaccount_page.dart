import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMyAccountPage extends StatefulWidget {
  @override
  State<UserMyAccountPage> createState() => _UserMyAccountPageState();
}

class _UserMyAccountPageState extends State<UserMyAccountPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('userProfile')
        .orderBy('lastUpdatedTime', descending: true) // Sort by lastUpdatedTime in descending order
        .limit(1) // Limit to the first document
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first;
    } else {
      throw Exception('No user data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _getUserData(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data available.'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${userData['name']}'),
                  Text('Phone Number: ${userData['phoneNumber']}'),
                  Text('Date of Birth: ${userData['dateOfBirth']}'),
                  Text('Blood Group: ${userData['bloodGroup']}'),
                  Text('Address: ${userData['address']}'),
                  Text('Gender: ${userData['gender']}'),
                  Text('Last Updated: ${userData['lastUpdatedTime']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
