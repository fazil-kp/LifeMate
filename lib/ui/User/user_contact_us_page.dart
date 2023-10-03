

import 'package:flutter/material.dart';
import 'package:lifemate/ui/User/user_home_page.dart';

class UserContactUsPage extends StatelessWidget {
  const UserContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserHomepage()));
        // },
        //     icon: const Icon(Icons.arrow_back, color: Colors.black,)
        // ),
        title: const Text('Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height/10),
          const Padding(
            padding: EdgeInsets.only(left: 45),
            child: Text('Get in touch!', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            ),
          ),
          SizedBox(height: size.height/10,),
          Row(
            children: [
              SizedBox(width: size.width/10,),
              const Icon(Icons.call, color: Colors.redAccent,),
              SizedBox(width: size.width/50,),
              const Text('+91 9087654321'),
            ],
          ),
          SizedBox(height: size.height/30,),
          Row(
            children: [
              SizedBox(width: size.width/10,),
              const Icon(Icons.mail, color: Colors.redAccent,),
              SizedBox(width: size.width/50,),
              const Text('abcdef@gmail.com'),
            ],
          ),
          SizedBox(height: size.height/30,),
          Row(
            children: [
              SizedBox(width: size.width/10,),
              const Icon(Icons.location_on, color: Colors.redAccent,),
              SizedBox(width: size.width/50,),
              const Text('FuturaLabs, Kochi, Kerala'),
            ],
          ),
        ],
      ),
    );
  }
}