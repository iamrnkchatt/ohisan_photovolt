import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/forgot_password.dart';
import 'package:ohishan/Screens/login.dart';
import 'package:ohishan/Screens/nav_screen.dart';
import 'package:ohishan/Screens/sign_up.dart';
import 'package:ohishan/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  final String phoneNumber;

  const ChangePassword({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
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
                        SizedBox(height: width * 0.15),
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
                        TextFormField(
                          obscureText: true,
                          controller: cPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock, color: Colors.black),
                              label: const Text("Confirm Password"),
                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                              hintText: "Confirm Password",
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
                                  child: Text("Update Password", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black))),
                        ),
                      ],
                    )),
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
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your password.")));
    } else if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password should have minimum 6 characters.")));
    } else if (passwordController.text != cPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password and confirm password dose not match.")));
    } else {
      DatabaseReference dataRef = FirebaseDatabase.instance.reference().child("Users").child(widget.phoneNumber);
      Map<String, String> users = {"password": passwordController.text};
      dataRef.update(users);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your password has been changed.")));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (Route<dynamic> route) => false);
    }
  }
}
