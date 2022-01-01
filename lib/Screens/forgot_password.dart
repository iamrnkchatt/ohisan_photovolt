import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/otp_screen.dart';
import 'package:ohishan/constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneNumberController = TextEditingController();
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
                        child: Image(image: AssetImage('assets/logo_blue.png'), width: width * 0.4, height: width * 0.4),
                      ),
                    ),
                    SizedBox(height: width * 0.15),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneNumberController,
                          maxLength: 10,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                              label: const Text("Mobile number"),
                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                              hintText: "Mobile number",
                              hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                        ),
                        SizedBox(height: width * 0.2),
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
                                  child: Text("Submit", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black))),
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
    String number = phoneNumberController.text.trim().toString().replaceAll("+", "").replaceAll("91", "");
    if (number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your mobile number.")));
    } else if (number.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid mobile number.")));
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: number, fName: "", companyName: "", address: "", email: "", password: "", gstNum: "", userType: "")));
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
