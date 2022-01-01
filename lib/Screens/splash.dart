import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/login.dart';
import 'package:ohishan/Screens/nav_screen.dart';
import 'package:ohishan/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getUrlData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blue,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
            child: null,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: width * 0.1, horizontal: width * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.all(width * 0.02),
                    height: width * 0.3,
                    width: width * 0.3,
                    child: const Image(image: AssetImage('assets/logo_blue.png')),
                  ),
                ),
                SizedBox(height: width * 0.6),
                SizedBox(
                  height: width * 0.12,
                  width: width,
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orange)),
                      onPressed: () {
                        getData();
                      },
                      child: Text("Get Started", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? number = prefs.getString(numberStr);
    String? name = prefs.getString(nameStr);
    if (number != null && name != null && number.isNotEmpty) {
      Constant.mobileNumber = number;
      Constant.userName = name;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  void getUrlData() async{
    await Firebase.initializeApp();
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("BaseUrls");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          Map<String, dynamic> urlsDetail  = jsonDecode(jsonEncode(event.snapshot.value));
          Constant.catImageBasePath=urlsDetail['image_path'];
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
