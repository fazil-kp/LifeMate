import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifemate/ui/User/user_menu_pages/demo_page.dart';
import 'package:lifemate/ui/User/user_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertWindow extends StatefulWidget {
  const AlertWindow(
      {Key? key,
      required this.i,
      required this.alertHead,
      required this.alertText})
      : super(key: key);

  final int i;
  final String alertHead;
  final String alertText;

  @override
  State<AlertWindow> createState() => _AlertWindowState();
}

class _AlertWindowState extends State<AlertWindow> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          widget.alertHead,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          widget.alertText,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: <Widget>[
          if (widget.i == 1)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          TextButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserLoginPage()));
              }).catchError((e) {
                Fluttertoast.showToast(msg: e!.message);
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0XFF00b2ff),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(14),
                child: widget.i == 0
                    ? const Text(
                        "okay",
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text("Log Out",
                        style: TextStyle(color: Colors.white))),
          ),
        ]);
  }
}
