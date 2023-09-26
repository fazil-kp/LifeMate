import 'package:flutter/material.dart';
class UserSignUpPage extends StatelessWidget {
  const UserSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {

    List images = ["google.png","facebook.png"];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.3,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/LoginPageImage.png"),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: h*0.16,),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Your email id",
                        prefixIcon: Icon(Icons.email_outlined),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Your Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(),
                  //     ),
                  //     Text(
                  //       "Forgot your Password ?",
                  //       style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: w * 0.5,
              height: h * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.redAccent,
              ),
              child: Center(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: w * 0.15),
            RichText(
              text: TextSpan(
                text: "Sign up using on the following methods",
                style: TextStyle(color: Colors.grey[500], fontSize:16),

              ),
            ),
            Wrap(
              children: List<Widget>.generate(2,(index){
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/"+images[index]),


                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),

    );
  }
}
