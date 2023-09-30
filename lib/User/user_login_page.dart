import 'package:flutter/material.dart';
import 'package:lifemate/User/user_signup_page.dart';
import 'package:lifemate/reusable_widget/color_utils.dart';

import '../reusable_widget/reusable_widgets.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
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
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/Splash.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                logInSignUpButton(context, true, (){}),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?",style: TextStyle(color: Colors.white70,),),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignUpPage()));
          },
        ),
        Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
