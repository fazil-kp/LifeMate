import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifemate/ui/Admin/admin_login_page.dart';
import 'package:lifemate/ui/User/user_login_page.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminLoginPage()));
          },
          child: Text("LOG OUT"),
        ),
      ),
    );
  }
}
