import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';

class AdminMyAccountPage extends StatefulWidget {
  @override
  State<AdminMyAccountPage> createState() => _AdminMyAccountPageState();
}

class _AdminMyAccountPageState extends State<AdminMyAccountPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('adminProfile')
        .orderBy('lastUpdatedTime', descending: true)
        .limit(1)
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'My Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
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

          // Format the date of birth
          final dateOfBirthTimestamp = userData['dateOfBirth'] as Timestamp?;
          String formattedDateOfBirth = 'N/A';

          if (dateOfBirthTimestamp != null) {
            final dateOfBirth = dateOfBirthTimestamp.toDate();
            formattedDateOfBirth = DateFormat('dd/MM/yyyy').format(dateOfBirth);
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontFamily: Bold),),
                    subtitle: Text(userData['name'] ?? 'N/A',style: TextStyle(fontFamily: Medium,fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontFamily: Bold)),
                    subtitle: Text(userData['phoneNumber'] ?? 'N/A',style: TextStyle(fontFamily: Medium,fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Date of Birth',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontFamily: Bold)),
                    subtitle: Text(formattedDateOfBirth,style: TextStyle(fontFamily: Medium,fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Blood Group',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontFamily: Bold)),
                    subtitle: Text(userData['bloodGroup'] ?? 'N/A',style: TextStyle(fontFamily: Medium,fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontFamily: Bold)),
                    subtitle: Text(userData['address'] ?? 'N/A',style: TextStyle(fontFamily: Medium,fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: ListTile(
                      title: Text('Gender',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,fontFamily: Bold)),
                      subtitle: Text(userData['gender'] ?? 'N/A',style: TextStyle(fontFamily: Medium,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
