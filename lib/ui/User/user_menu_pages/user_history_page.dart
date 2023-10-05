import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';
// Import the intl package for date formatting

class UserHistoryPage extends StatefulWidget {
  @override
  _UserHistoryPageState createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  final usersRef = FirebaseFirestore.instance.collection('userRegister');

  // Function to delete a document by its ID
  void deleteDocument(String documentId) {
    usersRef.doc(documentId).delete().then((_) {
      // After deleting the document, refresh the UI
      setState(() {});
    }).catchError((error) {
      print('Error deleting document: $error');
    });
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
          'My History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: usersRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                final documentId = documents[index].id;

                // Format the date to show only the date (without time)
                final date =
                    DateFormat('yyyy-MM-dd').format(data['date'].toDate());

                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Card(
                    color: Colors.red[100],
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Patient Name: ${data['patientName']}',
                            style: TextStyle(fontFamily: Bold),
                          ),
                          subtitle: Text(
                            'Date: $date',
                            style: TextStyle(fontFamily: Medium),
                          ),
                          // Use the formatted date here
                          leading: Text(
                            '${data['bloodGroup']}',
                            style: TextStyle(
                                fontFamily: Bold,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Confirm the delete action with a dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text(
                                        'Are you sure you want to delete this entry?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteDocument(
                                              documentId); // Delete the document
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
