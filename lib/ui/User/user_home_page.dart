import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifemate/ui/User/user_login_page.dart';


class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Log Out");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserLoginPage()));
            });
          },
          child: Text("LOG OUT"),
        ),
      ),
    );
  }
}
