// ignore_for_file: unnecessary_cast, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemate/ui/Admin/admin_login_page.dart';
import 'package:lifemate/ui/User/user_contact_us_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/user_requests_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/user_want_blood_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/user_history_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/user_myaccount_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/user_profile_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/user_register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user_reusable_widget/user_alert_window.dart';
import '../../user_reusable_widget/constant_fonts.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String name = ''; // Add these variables
  String bloodGroup = '';
  String phoneNumber = '';

  // Uint8List? _image;
  bool _isLoading = true;
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  String imageUrl = '';
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadUserData();
    });

    _loadData();
  }

  Future<void> _loadUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userRole', 'user');

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .orderBy('lastUpdatedTime', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          name = userData['name'] ?? '';
          bloodGroup = userData['bloodGroup'] ?? '';
          phoneNumber = userData['phoneNumber'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        // Exit the app when back button is pressed on the Home screen
        await SystemNavigator.pop();
        return true;
      },
      child: _isLoading
          ? Container(color: Colors.white, child: Center(child: CircularProgressIndicator()))
          : Scaffold(
              drawer: Drawer(
                width: size.width / 1.5,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50))),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      // width: size.width/,
                      height: size.height / 3,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/adminLogo.png"),
                              // fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          ),
                          child: Text(
                            'LifeMate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.pop(context),
                      leading: Icon(
                        Icons.home,
                        color: Colors.black,
                        size: size.height / 24,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Bold,
                            fontSize: size.height / 48),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserMyAccountPage())),
                      leading: Icon(
                        Icons.account_box_rounded,
                        color: Colors.black,
                        size: size.height / 24,
                      ),
                      title: Text(
                        'My Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Bold,
                            fontSize: size.height / 48),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserHistoryPage())),
                      leading: Icon(
                        Icons.history,
                        color: Colors.black,
                        size: size.height / 24,
                      ),
                      title: Text(
                        'Check History',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Bold,
                            fontSize: size.height / 48),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserContactUsPage())),
                      leading: Icon(
                        Icons.call,
                        color: Colors.black,
                        size: size.height / 24,
                      ),
                      title: Text(
                        'Contact Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Bold,
                            fontSize: size.height / 48),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminLoginPage())),
                      leading: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.black,
                        size: size.height / 24,
                      ),
                      title: Text(
                        'Admin Panel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Bold,
                            fontSize: size.height / 48),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AlertWindow(
                                  i: 1,
                                  alertHead: "Confirm Logout!",
                                  alertText:
                                      "Are you sure you want to Logout?"))),
                      leading: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: size.height / 24,
                      ),
                      title: Text(
                        'Log out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: Bold,
                            fontSize: size.height / 48),
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: Container(
                            height: size.height / 2.5,
                            width: size.width,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                          ),
                        ),

                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            height: size.height / 3.8,
                            width: size.width,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                          ),
                        ),

                        //App Bar
                        Positioned(
                          top: -5,
                          left: 0.0,
                          right: 0.0,
                          child: AppBar(
                            iconTheme: const IconThemeData(color: Colors.black),
                            title: const Text(
                              'LifeMate',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Bold,
                                  color: Colors.black),
                            ),
                            centerTitle: true,
                            backgroundColor: Colors.red,
                            elevation: 0,
                          ),
                        ),

                        Positioned(
                          top: 40.0,
                          right: 10.0,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AlertWindow(
                                          i: 1,
                                          alertHead: "Confirm Logout!",
                                          alertText:
                                              "Are you sure you want to Logout?")));
                            },
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),

                        //Student Details card
                        Positioned(
                          top: size.height / 7,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            color: Colors.white,
                            child: SizedBox(
                              width: size.width / 1.2,
                              height: size.height / 5,
                              child: Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width / 1.2,
                                    height: size.height / 24,
                                  ),
                                  Text(
                                    " $name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Bold,
                                      fontSize: size.height / 45,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 200,
                                  ),
                                  Text(
                                    "$bloodGroup",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Light,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 200,
                                  ),
                                  Text(
                                    "$phoneNumber",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Light),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: size.height / 10.5,
                          child: CircleAvatar(
                            radius: size.height / 17,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                "https://www.pngkey.com/png/full/202-2024792_user-profile-icon-png-download-fa-user-circle.png"),
                            // child: const CircularProgressIndicator(),
                          ),
                        ),
                        //Menu Text
                        Positioned(
                          top: size.height / 2.75,
                          left: size.width / 12,
                          child: Text(
                            'Menu',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Bold,
                                fontSize: size.height / 45),
                          ),
                        ),
                      ]),
                  //Menu Buttons
                  SizedBox(
                    width: double.infinity,
                    height: size.height / 2.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //First Row
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ButtonInMenu(
                                  navigationInButton: UserProfilePage(
                                    userData: {},
                                  ),
                                  iconInButton: Icons.man_rounded,
                                  textInButton: "Profile"),
                              ButtonInMenu(
                                  navigationInButton: UserRegisterPage(),
                                  iconInButton: Icons.fact_check_rounded,
                                  textInButton: "Register"),
                              ButtonInMenu(
                                  navigationInButton: UserHistoryPage(),
                                  iconInButton: Icons.history,
                                  textInButton: "History"),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Second Row
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ButtonInMenu(
                                  navigationInButton: UserMyAccountPage(),
                                  iconInButton: Icons.account_box_rounded,
                                  textInButton: "My Account"),
                              ButtonInMenu(
                                  navigationInButton: UserRequestPage(),
                                  iconInButton: Icons.downloading,
                                  textInButton: "Requests "),
                              ButtonInMenu(
                                  navigationInButton: UserWantBloodPage(),
                                  iconInButton: Icons.bloodtype_sharp,
                                  textInButton: " Want Blood "),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ButtonInMenu extends StatelessWidget {
  const ButtonInMenu({
    super.key,
    required this.navigationInButton,
    required this.iconInButton,
    required this.textInButton,
  });

  final Widget navigationInButton;
  final IconData iconInButton;
  final String textInButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => navigationInButton));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 5,
            children: [
              Icon(
                iconInButton,
                size: 80,
                color: Colors.red,
              ),
              Text(
                textInButton,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
