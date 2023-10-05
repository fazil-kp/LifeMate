import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';

class UserWantBloodPage extends StatelessWidget {
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
          'Need Blood',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: UserList(),
    );
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('userProfile').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final users = snapshot.data!.docs;

        // Create a map to group users by their blood groups
        Map<String, List<Map<String, dynamic>>> groupedUsers = {};

        // Group users by blood group
        for (var user in users) {
          final userData = user.data() as Map<String, dynamic>;
          final bloodGroupValue = userData['bloodGroup'] ?? '';

          if (!groupedUsers.containsKey(bloodGroupValue)) {
            groupedUsers[bloodGroupValue] = [];
          }

          groupedUsers[bloodGroupValue]!.add(userData);
        }

        return ListView.builder(
          itemCount: groupedUsers.length,
          itemBuilder: (context, index) {
            final bloodGroup = groupedUsers.keys.elementAt(index);
            final usersInGroup = groupedUsers[bloodGroup]!;

            // Display the blood group and the users in this group
            return Card( // Use Card for each blood group section
              margin: EdgeInsets.all(10.0),
              elevation: 5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Blood Group: $bloodGroup',
                      style: TextStyle(
                        fontFamily: Bold,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Customize text color
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: usersInGroup.length,
                    itemBuilder: (context, index) {
                      final userData = usersInGroup[index];
                      final name = userData['name'] ?? '';
                      final phoneNumber = userData['phoneNumber'] ?? '';

                      return ListTile(
                        leading: CircleAvatar( // Add a circular avatar
                          backgroundColor: Colors.red, // Customize avatar background color
                          child: Text(
                            bloodGroup,
                            style: TextStyle(
                              fontFamily: Bold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Customize text color
                            ),
                          ),
                        ),
                        title: Text(
                          'Name: $name',
                          style: TextStyle(
                            fontFamily: Bold,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text('Phone Number: $phoneNumber'),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
