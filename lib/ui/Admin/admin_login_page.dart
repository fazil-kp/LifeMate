import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';

import '../../user_reusable_widget/reusable_widgets.dart';
import 'admin_home_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Admin Panel",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF0000),
              Color(0xFF9546C4),
              Color(0xFFFF0000),
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
            child: Column(
              children: <Widget>[
                // Your logoWidget here
                logoWidget("assets/images/adminLogo.png"),
                SizedBox(
                  height: 30,
                ),
                _reusableTextField(
                  "Enter Panel Code",
                  Icons.vpn_key, // Key icon for panel code
                  false,
                  _userNameTextController,
                ),
                SizedBox(
                  height: 30,
                ),
                _reusableTextField(
                  "Enter Password",
                  Icons.lock, // Lock icon for password
                  true,
                  _passwordTextController,
                ),
                SizedBox(
                  height: 20,
                ),
                firebaseButton(
                  context,
                  "LOG IN",
                      () => _signIn(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _reusableTextField(
      String labelText,
      IconData prefixIconData,
      bool obscureText,
      TextEditingController controller,
      ) {
    return TextField(
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: Medium,
          color: Colors.white.withOpacity(0.9),
        ),
        prefixIcon: Icon(prefixIconData,color: Colors.white.withOpacity(0.8)), // Prefix icon
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      controller: controller,
      obscureText: obscureText,
    );
  }

  Future<void> _signIn(BuildContext context) async {
    final panelCode = _userNameTextController.text.trim();
    final password = _passwordTextController.text.trim();

    if (panelCode.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Both Panel Code and Password are required",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    final adminRef = FirebaseFirestore.instance.collection('adminLogin');
    final querySnapshot = await adminRef
        .where('panelCode', isEqualTo: panelCode)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isEmpty) {
      Fluttertoast.showToast(
        msg: "Invalid credentials",
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    }
  }
}
