import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/constant.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, required this.isShowAppbar, required this.productName}) : super(key: key);
  final bool isShowAppbar;
  final String productName;

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Map<String, dynamic> contactDetail = {};
  TextEditingController fullNameController = TextEditingController(), companyNameController = TextEditingController(), emailController = TextEditingController(), phoneNumberController = TextEditingController(), addressController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: widget.isShowAppbar
          ? AppBar(
              backgroundColor: Colors.white,
              title: Text("Contact Us", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black)),
              iconTheme: IconThemeData(color: grey),
              leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.orange), onPressed: () => Navigator.of(context).pop()),
            )
          : null,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: width * 0.04),
            Text(
              "Contact Us Now",
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.06, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Please fill Up the form and we will get back to you shortly",
                style: GoogleFonts.roboto(fontWeight: FontWeight.normal, fontSize: width * 0.04, color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: fullNameController,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
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
                      keyboardType: TextInputType.text,
                      controller: companyNameController,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
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
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.phone_android_outlined,
                            color: Colors.black,
                          ),
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
                      keyboardType: TextInputType.text,
                      controller: addressController,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.map_outlined,
                            color: Colors.black,
                          ),
                          label: const Text("Address"),
                          labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                          hintText: "Full Address",
                          hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                    ),
                    SizedBox(height: width * 0.08),
                    Container(
                      height: width * 0.12,
                      width: width,
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orange)),
                          onPressed: () {
                            saveData();
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: width * 0.04),
            Text(
              "Connect with us",
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.06, color: Colors.black),
            ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.2, child: const Icon(Icons.email, size: 40, color: orange)),
                Text.rich(
                    TextSpan(text: "Email Address\n", style: GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: width * 0.055, color: blue), children: [
                      TextSpan(text: contactDetail.isNotEmpty ? contactDetail[contactDetail.keys.elementAt(0)]['email'] : "Loading", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w400, fontSize: width * 0.045)),
                    ]),
                    textAlign: TextAlign.left),
              ],
            ),
            SizedBox(height: width * 0.04),
            Row(
              children: [
                SizedBox(width: width * 0.2, child: const Icon(Icons.phone, size: 40, color: orange)),
                Text.rich(
                    TextSpan(text: "Phone Number\n", style: GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: width * 0.055, color: blue), children: [
                      TextSpan(
                        text: contactDetail.isNotEmpty ? contactDetail[contactDetail.keys.elementAt(0)]['phone'] : "Loading",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.045,
                        ),
                      )
                    ]),
                    textAlign: TextAlign.left),
              ],
            ),
            SizedBox(height: width * 0.04),
            Row(
              children: [
                SizedBox(width: width * 0.2, child: const Icon(Icons.map, size: 40, color: orange)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: width * 0.055, color: blue),
                      ),
                      Text(
                        contactDetail.isNotEmpty ? contactDetail[contactDetail.keys.elementAt(0)]['address'] : "Loading",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.045,
                        ),
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
                /*Text.rich(
                    TextSpan(
                        text: "Address\n",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w800,
                            fontSize: width * 0.055,
                            color: blue),
                        children: [
                          TextSpan(
                            text: contactDetail.isNotEmpty
                                ? contactDetail[contactDetail.keys.elementAt(0)]
                                    ['address']
                                : "Loading",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.045,
                            ),
                          )
                        ]),
                    textAlign: TextAlign.left,
                    maxLines: 4),*/
              ],
            ),
            SizedBox(height: width * 0.1),
          ],
        ),
      )),
    );
  }

  void saveData() {
    if (fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your full name.")));
    } else if (companyNameController.text.isEmpty) {
      const snackBar = SnackBar(content: Text("Please enter company name."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (emailController.text.isEmpty) {
      const snackBar = SnackBar(content: Text("Please enter your email address."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (phoneNumberController.text.isEmpty) {
      const snackBar = SnackBar(content: Text("Please enter your phone number."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (addressController.text.isEmpty) {
      const snackBar = SnackBar(content: Text("Please enter your full address."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String fName = fullNameController.text;
      String compName = companyNameController.text;
      String email = emailController.text;
      String phoneNo = phoneNumberController.text;
      String address = addressController.text;
      DatabaseReference dataRef = FirebaseDatabase.instance.reference().child(widget.productName.isNotEmpty ? "quotes" : "bussinesslead");

      Map<String, String> contacts = {
        "name": fName,
        "contact": compName,
        "email": email,
        "phone": phoneNo,
        "address": address,
        "status": "pending",
      };
      if (widget.productName.isNotEmpty) {
        contacts.addAll({"product_name": widget.productName});
      }
      dataRef.push().set(contacts);
      fullNameController.clear();
      companyNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      addressController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your request submitted successfully.")));
      FocusScope.of(context).requestFocus(FocusNode()); //remove focus
    }
  }

  void getData() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("contact");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          contactDetail = jsonDecode(jsonEncode(event.snapshot.value));
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
