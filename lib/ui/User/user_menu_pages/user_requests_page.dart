// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../user_reusable_widget/constant_fonts.dart';

class UserRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request accepting',
          style: TextStyle(
              fontFamily: Bold,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: AdminDonarList(),
    );
  }
}

class AdminDonarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('adminDonar').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child:
                  CircularProgressIndicator()); // Loading indicator while data is being fetched
        }
        var donarDocs = snapshot.data!.docs;

        // Function to delete the document from Firestore
        Future<void> _deleteDonar(String documentId) async {
          await FirebaseFirestore.instance
              .collection('adminDonar')
              .doc(documentId) // Use the document ID to delete
              .delete();
        }

        return ListView.builder(
          itemCount: donarDocs.length,
          itemBuilder: (context, index) {
            var donarData = donarDocs[index].data() as Map<String, dynamic>;
            var documentId = donarDocs[index].id;

            return Card(
              color: Colors.red[100],
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(
                  'Donor Name: ${donarData['donarName']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number: ${donarData['phoneNumber']}'),
                    Text('Location: ${donarData['location']}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Show a confirmation dialog before deleting
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text(
                              'Are you sure you want to delete this donor?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                _deleteDonar(documentId);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
