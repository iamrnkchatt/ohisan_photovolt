import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/login.dart';
import 'package:ohishan/Screens/nav_screen.dart';
import 'package:ohishan/Screens/otp_screen.dart';
import 'package:ohishan/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _userTypeValue = "Select Type";

  TextEditingController fullNameController = TextEditingController(),
      companyNameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      passwordController = TextEditingController(),
      gstController = TextEditingController(),
      addressController = TextEditingController();
  List<String> _userType = <String>["Select Type", "Retailer", " Dealer"];

  @override
  void initState() {
    super.initState();
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
              Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg.png"), fit: BoxFit.cover)), child: null),
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
                          height: width * 0.4,
                        ),
                      ),
                    ),
                    Form(
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
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
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
                          obscureText: true,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              label: const Text("Password"),
                              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                              hintText: "password",
                              hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black26),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))),
                        ),
                        SizedBox(height: width * 0.04),
                        selectType(height, width),
                        SizedBox(height: width * 0.04),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: gstController,
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
                        SizedBox(height: width * 0.04),
                        SizedBox(height: width * 0.08),
                        Container(
                          height: width * 0.12,
                          width: width,
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orange)),
                              onPressed: () {
                                String number = phoneNumberController.text.trim().toString().replaceAll("+", "").replaceAll("91", "");
                                if (fullNameController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your full name.")));
                                } else if (emailController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your email.")));
                                } else if (number.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your phone number.")));
                                } else if (number.length < 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid phone number (without country code).")));
                                } else if (passwordController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter password.")));
                                } else if (passwordController.text.trim().length < 6) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password should have minimum 6 characters.")));
                                } else if (_userTypeValue.isEmpty || _userTypeValue == "Select Type") {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select user type.")));
                                } else if (addressController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter your address.")));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                            fName: fullNameController.text.toString(),
                                            companyName: companyNameController.text.toString(),
                                            address: addressController.text.toString(),
                                            email: emailController.text.toString(),
                                            password: passwordController.text.toString(),
                                            phoneNumber: "+91" + number,
                                            gstNum: gstController.text.toString(),
                                            userType: _userTypeValue,
                                          )));
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black),
                              )),
                        ),
                      ],
                    )),
                    SizedBox(height: width * 0.04),
                    SizedBox(height: width * 0.04),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                      },
                      child: Text.rich(TextSpan(text: "Already have an account? ", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.045, color: Colors.grey), children: [TextSpan(text: "Sign In", style: GoogleFonts.roboto(color: blue))]), textAlign: TextAlign.center),
                    ),
                    SizedBox(height: width * 0.08),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectType(height, width) {
    return Container(
      // margin: EdgeInsets.fromLTRB(width * 0.06, 0.0, width * 0.06, 0.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
      padding: EdgeInsets.fromLTRB(width * 0.025, height * 0.005, width * 0.017, height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                dropdownColor: Colors.grey[100],
                items: _userType.map((value) => DropdownMenuItem(child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), value: value)).toList(),
                onChanged: (selectedtype) {
                  setState(() {
                    _userTypeValue = selectedtype.toString();
                  });
                  FocusScope.of(context).requestFocus(FocusNode()); //remove focus
                },
                value: _userTypeValue,
                hint: Row(
                  children: [
                    const Icon(Icons.business),
                    Text("Select Type", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: height * 0.020)),
                  ],
                ),
                elevation: 0,
                isExpanded: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
