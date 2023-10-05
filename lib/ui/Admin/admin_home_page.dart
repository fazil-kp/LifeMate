
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemate/ui/User/user_home_page.dart';
import 'package:lifemate/ui/User/user_menu_pages/demo_page.dart';
import 'package:lifemate/user_reusable_widget/constant_fonts.dart';

import '../../user_reusable_widget/admin_alert_window.dart';
import '../../user_reusable_widget/user_alert_window.dart';
import 'admin_help_page.dart';
import 'admin_history_page.dart';
import 'admin_manage_request_page.dart';
import 'admin_manage_user_page.dart';
import 'admin_my_account_page.dart';
import 'admin_profile_page.dart';


class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        // Exit the app when back button is pressed on the Home screen
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: Drawer(
          width: size.width / 1.5,
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(50))),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),

              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const AdminHomePage())),
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
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminMyAccountPage())),
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
                        builder: (context) =>
                        AdminContactUsPage())),
                leading: Icon(
                  Icons.help,
                  color: Colors.black,
                  size: size.height / 24,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: Bold,
                      fontSize: size.height / 48),
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHistoryPage())),
                leading: Icon(
                  Icons.history,
                  color: Colors.black,
                  size: size.height / 24,
                ),
                title: Text(
                  'History',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: Bold,
                      fontSize: size.height / 48),
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  UserHomepage())),
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
        appBar:  AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'LifeMate',
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  UserHomepage()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [Text('Menu',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

                SizedBox(height: 18,),

                //Time table button
                CustomButtonInHome(navigationInButton: AdminProfilePage(userData: {},), iconInButton: Icons.man_rounded, textInButton: 'Admin Profile'),
                SizedBox(height: 18,),

                //Faculties Button
                CustomButtonInHome(navigationInButton: AdminManageRequestPage (), iconInButton: Icons.downloading, textInButton: 'Manage Request'),
                SizedBox(height: 18,),

                //Study Materials Button
                CustomButtonInHome(navigationInButton: AdminManageUser(), iconInButton: Icons.person_search, textInButton: 'Manage User'),
                SizedBox(height: 18,),

                CustomButtonInHome(navigationInButton: AdminHistoryPage(), iconInButton: Icons.history, textInButton: 'History'),
                SizedBox(height: 18,),

                //Fees Button
                CustomButtonInHome(navigationInButton: AdminMyAccountPage(), iconInButton: Icons.account_box_rounded, textInButton: 'Admin Account'),
                SizedBox(height: 18,),



                // //Q&A Button
                // CustomButtonInHome(navigationInButton:  AlertWindow(i: 0, alertHead: "Coming Soon...!", alertText: "Stay Updated we are launching soon......."), iconInButton: Icons.question_answer_rounded, textInButton: "Q&A"),
                // SizedBox(height: 18,),
                //
                // //Attendance button
                // CustomButtonInHome(navigationInButton: AdminHomePage(), iconInButton: Icons.fact_check_rounded, textInButton: 'hhhh'),
                // SizedBox(height: 18,),
                //
                // //Assessment Button
                // CustomButtonInHome(navigationInButton: AdminHomePage(), iconInButton: Icons.assessment_rounded, textInButton: 'hhhh'),
                // SizedBox(height: 18,),
                //
                // //Assignment Button
                // CustomButtonInHome(navigationInButton: AdminHomePage(), iconInButton: Icons.assignment, textInButton: 'hhhh'),
                // SizedBox(height: 18,),

                //My Account
                // CustomButtonInHome(navigationInButton:AdminAlertWindow(i: 0, alertHead: 'My Account', alertText: 'Contact at ` mspp.f2a@gmail.com ` for account related queries.\n if you phase any issue with your account, contact at +9874563210.\n\n You will have full control over your account in the future. \n\n\nThank you for using Edeft'),
                //     iconInButton: Icons.account_box_rounded, textInButton: 'My Account'),
                // SizedBox(height: 18,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonInHome extends StatelessWidget {
  const CustomButtonInHome({
    super.key, required this.navigationInButton, required this.iconInButton, required this.textInButton,
  });

  final Widget navigationInButton;
  final IconData iconInButton;
  final String textInButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigationInButton));
    },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white60,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ), child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 15,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(iconInButton,size: 70,),
              Text(textInButton,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: Bold),)
            ],
          ),
        ),
      ),
    );
  }
}
