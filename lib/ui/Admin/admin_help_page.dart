import 'package:flutter/material.dart';

class AdminContactUsPage extends StatelessWidget {
  const AdminContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 400),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height / 18),
              const Padding(
                padding: EdgeInsets.only(left: 45),
                child: Text(
                  'Get in touch!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 10,
                  ),
                  const Icon(
                    Icons.call,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: size.width / 50,
                  ),
                  const Text('+91 9087654321'),
                ],
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 10,
                  ),
                  const Icon(
                    Icons.mail,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: size.width / 50,
                  ),
                  const Text('abcdef@gmail.com'),
                ],
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 10,
                  ),
                  const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: size.width / 50,
                  ),
                  const Text('FuturaLabs, Kochi, Kerala'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
