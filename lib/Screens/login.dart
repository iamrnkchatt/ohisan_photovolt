import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/forgot_password.dart';
import 'package:ohishan/Screens/nav_screen.dart';
import 'package:ohishan/Screens/sign_up.dart';
import 'package:ohishan/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNumberController = TextEditingController(), passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(width: width, height: height, decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg.png"), fit: BoxFit.cover)), child: null),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: width * 0.15),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(width * 0.02),
                        height: width * 0.3,
                        width: width * 0.3,
                        child: Image(
                          image: AssetImage('assets/logo_blue.png'),
                          width: width * 0.4,
                          height: width * 0.4,
                        ),
                      ),
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneNumberController,
                          maxLength: 10,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                              label: const Text("Mobile number"),
                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                              hintText: "Mobile number",
                              hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                        ),
                        SizedBox(height: width * 0.04),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock, color: Colors.black),
                              label: const Text("Password"),
                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                              hintText: "password",
                              hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                        ),
                        SizedBox(height: width * 0.08),
                        Container(
                          height: width * 0.12,
                          width: width,
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orange)),
                                  onPressed: () {
                                    checkUser();
                                  },
                                  child: Text("Log In", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black))),
                        ),
                      ],
                    )),
                    SizedBox(height: width * 0.1),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: width * 0.04),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp()));
                      },
                      child: Text.rich(TextSpan(text: "Don't have an account? ", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.045, color: Colors.grey), children: [TextSpan(text: "Register Now", style: GoogleFonts.roboto(color: blue))]), textAlign: TextAlign.center),
                    ),
                    SizedBox(height: width * 0.08),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavScreen()));
                      },
                      child: Text(
                        "VIEW AS GUEST",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUser() {
    String number = phoneNumberController.text.trim().toString().replaceAll("+", "").replaceAll("91", "");
    if (number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your mobile number.")));
    } else if (number.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid mobile number.")));
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your password.")));
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        number = "+91" + number;
        DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(number);
        Stream<DatabaseEvent> stream = ref.onValue;
        stream.listen((DatabaseEvent event) async {
          try {
            Map<String, dynamic> userDetail = jsonDecode(jsonEncode(event.snapshot.value));
            if (userDetail.isNotEmpty) {
              if (userDetail['password'] == passwordController.text) {
                Constant.mobileNumber = number;
                Constant.userName = userDetail['full_name'];
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(numberStr, Constant.mobileNumber);
                prefs.setString(nameStr, Constant.userName);
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavScreen()), (Route<dynamic> route) => false);
              } else {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid password.")));
              }
            } else {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid mobile number.")));
            }
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid mobile number.")));
          }
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check your internet connection.")));
      }
    }
  }
}
