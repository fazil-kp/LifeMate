import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifemate/ui/User/user_reset_password.dart';
import 'package:lifemate/ui/User/user_home_page.dart';
import 'package:lifemate/ui/User/user_signup_page.dart';
import '../../user_reusable_widget/color_utils.dart';
import '../../user_reusable_widget/reusable_widgets.dart';


class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("FF0000"),
              hexStringToColor("9546C4"),
              hexStringToColor("FF0000"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/Splash.png"),
                  SizedBox(
                    height: 8,
                  ),
                  reusableTextField(
                    "Enter email",
                    Icons.email_outlined,
                    false,
                    _emailTextController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  forgetPassword(context),
                  firebaseButton(context, "LOG IN", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Fluttertoast.showToast(msg: "Login Successful ");
                      print("Log In successfully");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserHomePage()));
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e!.message);
                    });
                  }),
                  signUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserSignUpPage()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPassword()));
        },
        child: Text(
          "Forget Password ?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
