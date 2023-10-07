import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifemate/ui/User/user_home_page.dart';
import 'package:lifemate/ui/User/user_login_page.dart';

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({Key? key});

  @override
  State<UserSplashScreen> createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    await Future.delayed(Duration(seconds: 3));

    if (user != null) {
      // User is logged in, navigate to the home screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserHomepage(),
        ),
      );
    } else {
      // User is not logged in, navigate to the login screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserLoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Image(
              image: AssetImage("assets/images/donateBlood.png"),
              width: 300,
              height: 300,
            ),
            SizedBox(
              height: 200,
            ),
            SpinKitFadingCircle(
              color: Colors.red,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}