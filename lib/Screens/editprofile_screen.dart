import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/login.dart';
import 'package:ohishan/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final bool shoeAppBar;

  const EditProfileScreen({Key? key, required this.shoeAppBar}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, dynamic> userDetail = {};
  TextEditingController fullNameController = TextEditingController(),
      companyNameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      passwordController = TextEditingController(),
      gstController = TextEditingController(),
      addressController = TextEditingController();

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(Constant.mobileNumber);
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) async {
      try {
        userDetail = jsonDecode(jsonEncode(event.snapshot.value));
        fullNameController.text = userDetail.containsKey("full_name") ? userDetail['full_name'] : "";
        companyNameController.text = userDetail.containsKey("company_name") ? userDetail['company_name'] : "";
        emailController.text = userDetail.containsKey("email") ? userDetail['email'] : "";
        phoneNumberController.text = userDetail.containsKey("phone_number") ? userDetail['phone_number'] : "";
        gstController.text = userDetail.containsKey("gst_number") ? userDetail['gst_number'] : "";
        addressController.text = userDetail.containsKey("address") ? userDetail['address'] : "";
        setState(() {});
      } catch (e) {
        print(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Constant.mobileNumber.isNotEmpty
        ? GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: widget.shoeAppBar
                  ? AppBar(
                      backgroundColor: Colors.white,
                      title: Text("Edit Profile", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black)),
                      iconTheme: const IconThemeData(color: grey),
                      leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.orange), onPressed: () => Navigator.of(context).pop()),
                    )
                  : null,
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg.png"), fit: BoxFit.cover)), child: null),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: width * 0.04),
                          Form(
                              child: Column(
                            children: [
                              SizedBox(height: width * 0.04),
                              Text("Edit Profile Information", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.06, color: Colors.black)),
                              SizedBox(height: width * 0.04),
                              SizedBox(height: width * 0.04),
                              TextFormField(
                                controller: fullNameController,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                                    label: const Text("Full Name"),
                                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                                    hintText: "Full Name",
                                    hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                              ),
                              SizedBox(height: width * 0.04),
                              TextFormField(
                                controller: companyNameController,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                                    label: const Text("Company Name"),
                                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                                    hintText: "Company Name",
                                    hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                              ),
                              SizedBox(height: width * 0.04),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
                                    label: const Text("Email"),
                                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                                    hintText: "Email Address",
                                    hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                              ),
                              SizedBox(height: width * 0.04),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: phoneNumberController,
                                enabled: false,
                                readOnly: true,
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.phone_android_outlined, color: Colors.black),
                                    label: const Text("Phone/Whatsapp"),
                                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                                    hintText: "Mobile Number",
                                    hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                              ),
                              SizedBox(height: width * 0.04),
                              TextFormField(
                                controller: gstController,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.business_center, color: Colors.black),
                                    label: const Text("GST"),
                                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                                    hintText: "GST Number",
                                    hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                              ),
                              SizedBox(height: width * 0.04),
                              TextFormField(
                                controller: addressController,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.map_outlined, color: Colors.black),
                                    label: const Text("Address"),
                                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                                    hintText: "Full Address",
                                    hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                              ),
                              SizedBox(height: width * 0.04),
                              SizedBox(height: width * 0.08),
                              Container(
                                height: width * 0.12,
                                width: width,
                                child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orange)),
                                    onPressed: () {
                                      saveData();
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
          )
        : Center(
            child: Container(
              height: width * 0.12,
              margin: EdgeInsets.symmetric(horizontal: 24),
              width: width,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orange)),
                  onPressed: () async {
                    Constant.mobileNumber = "";
                    Constant.userName = "";
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false);
                  },
                  child: Text("Log In", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black))),
            ),
          );
  }

  void saveData() async {
    if (fullNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your full name.")));
    } else if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your email.")));
    } else if (addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your address.")));
    } else {
      DatabaseReference dataRef = FirebaseDatabase.instance.reference().child("Users").child(Constant.mobileNumber);

      Map<String, String> users = {
        "full_name": fullNameController.text,
        "company_name": companyNameController.text,
        "email": emailController.text,
        "phone_number": Constant.mobileNumber,
        "address": addressController.text,
        "gst_number": gstController.text,
        "password": userDetail['password'],
        "user_type": userDetail['user_type'],
      };
      dataRef.set(users);
      Constant.userName = fullNameController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(nameStr, Constant.userName);
      if (widget.shoeAppBar) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated.")));
      }
    }
  }
}
