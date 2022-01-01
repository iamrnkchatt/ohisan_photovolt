import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/change_password.dart';
import 'package:ohishan/Screens/home.dart';
import 'package:ohishan/Screens/nav_screen.dart';
import 'package:ohishan/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String fName,
      companyName,
      email,
      phoneNumber,
      password,
      address,
      userType,
      gstNum;

  const OtpScreen(
      {Key? key,
      required this.fName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.address,
      required this.userType,
      required this.companyName,
      required this.gstNum})
      : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _controllerOtp;
  FirebaseAuth? _auth;
  String varId = "";

  void loginUser(String phone, BuildContext context) async {
    try {
      _auth = FirebaseAuth.instance;
      _auth!.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          saveUserData();
        },
        verificationFailed: (error) {
          print(error.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          varId = verificationId;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP sent on your mobile.")));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loginUser(widget.phoneNumber, context);
    _controllerOtp = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        //backgroundColor: blue,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/bg.png"),
                          fit: BoxFit.cover)),
                  child: null),
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
                            image: const AssetImage('assets/logo_blue.png'),
                            width: width * 0.4,
                            height: width * 0.4),
                      ),
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerOtp,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.04,
                              color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  Icons.mobile_friendly_sharp,
                                  color: Colors.black),
                              label: const Text("OTP"),
                              labelStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04,
                                  color: Colors.black),
                              hintText: "One Time Password",
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04,
                                  color: Colors.black26),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300))),
                        ),
                        SizedBox(height: width * 0.08),
                        Container(
                          height: width * 0.12,
                          width: width,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(orange)),
                              onPressed: () async {
                                try {
                                  final code = _controllerOtp.text.trim();
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: varId, smsCode: code);
                                  UserCredential result = await _auth!
                                      .signInWithCredential(credential);
                                  User? user = result.user;
                                  if (user != null) {
                                    saveUserData();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Invalid otp.")));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Invalid otp.")));
                                }
                              },
                              child: Text("Submit",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.045,
                                      color: Colors.black))),
                        ),
                      ],
                    )),
                    SizedBox(height: width * 0.04),
                    /*GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.white),
                      ),
                    ),*/
                    SizedBox(height: width * 0.04),
                    GestureDetector(
                      onTap: () {
                        loginUser(widget.phoneNumber, context);
                      },
                      child: Text.rich(
                          TextSpan(
                              text: "Didn't received any OTP? ",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.045,
                                  color: Colors.grey),
                              children: [
                                TextSpan(
                                    text: "Resend Now",
                                    style: GoogleFonts.roboto(color: blue))
                              ]),
                          textAlign: TextAlign.center),
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

  Future<void> saveUserData() async {
    if (widget.fName.isNotEmpty) {
      DatabaseReference dataRef = FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(widget.phoneNumber);
      Map<String, String> users = {
        "full_name": widget.fName,
        "company_name": widget.companyName,
        "email": widget.email,
        "phone_number": widget.phoneNumber,
        "password": widget.password,
        "address": widget.address,
        "user_type": widget.userType,
        "gst_number": widget.gstNum,
        "status": "0",
      };
      dataRef.set(users);
      Constant.mobileNumber = widget.phoneNumber;
      Constant.userName = widget.fName;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(numberStr, Constant.mobileNumber);
      prefs.setString(nameStr, Constant.userName);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NavScreen()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ChangePassword(phoneNumber: widget.phoneNumber)));
    }
  }
}
