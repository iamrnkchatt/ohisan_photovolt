import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/constant.dart';
import 'package:ohishan/model/category_model.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  TextEditingController fullNameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      quntController = TextEditingController(),
      disController = TextEditingController(),
      dateofPurchaseController = TextEditingController(),
      invoiceNoController = TextEditingController();

  String catData =
      "{\"category\":[{\"name\":\"LEDBulb\",\"subcat\":[\"5Watt\",\"7Watt\",\"9Watt\",\"12Watt\",\"15Watt\",\"18Watt\",\"25Watt\"]},{\"name\":\"InverterBulb\",\"subcat\":[\"9Watt\",\"12watt\"]},{\"name\":\"T5Batten(Tubelight)\",\"subcat\":[\"1ft5Watt\",\"2ft10Watt\",\"4ft20Watt\",\"4ft22Watt\",\"4ft24Watt\"]},{\"name\":\"ConcealedLight/CellingLight\",\"subcat\":[\"6Watt\",\"9Watt\",\"12Watt\"]},{\"name\":\"FloodLight\",\"subcat\":[\"30Watt\",\"50Watt\",\"80Watt\",\"100Watt\",\"150Watt\",\"200Watt\"]},{\"name\":\"StreetLight\",\"subcat\":[\"24Watt\",\"30Watt\",\"50Watt\",\"60Watt\",\"80Watt\",\"100Watt\"]}]}";
  late CategoryModel categoryModel;
  late Category selectedCat;
  String selectedSubCat = "";

  @override
  void initState() {
    categoryModel = CategoryModel.fromJson(jsonDecode(catData));
    selectedCat = categoryModel.category.first;
    selectedSubCat = selectedCat.subcat.first;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Report Quality issue",
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.045,
              color: Colors.black),
        ),
        iconTheme: IconThemeData(color: grey),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(height: width * 0.04),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Please fill Up the form and we will get back to you shortly",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: width * 0.04,
                        color: Colors.black),
                  ),
                ),
                DropdownButton<Category>(
                  isExpanded: true,
                  value: selectedCat,
                  items: categoryModel.category
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name,
                              style: GoogleFonts.roboto(
                                  color: Colors.black, fontSize: 18))))
                      .toList(),
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  onChanged: (value) => setState(() {
                    selectedCat = value!;
                    selectedSubCat = selectedCat.subcat.first;
                  }),
                ),
                SizedBox(height: width * 0.04),
                if (selectedCat.subcat.isNotEmpty)
                  DropdownButton<String>(
                    value: selectedSubCat,
                    isExpanded: true,
                    items: selectedCat.subcat
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: GoogleFonts.roboto(
                                    color: Colors.black, fontSize: 18))))
                        .toList(),
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.04,
                        color: Colors.black),
                    onChanged: (value) => setState(() {
                      selectedSubCat = value!;
                    }),
                  ),
                if (selectedCat.subcat.isNotEmpty)
                  SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fullNameController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person_outline, color: Colors.black),
                      label: const Text("Full Name"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Full Name",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: Colors.black),
                      label: const Text("Email"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Email Address",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android_outlined,
                          color: Colors.black),
                      label: const Text("Phone/Whatsapp"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Mobile Number",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: quntController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.format_list_numbered,
                          color: Colors.black),
                      label: const Text("Quantity"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Quantity",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: disController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.drive_file_rename_outline,
                          color: Colors.black),
                      label: const Text("Description"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Description",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: dateofPurchaseController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person_outline, color: Colors.black),
                      label: const Text("Date of Purchase"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Date of Purchase(dd/mm/yyyy)",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: invoiceNoController,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: Colors.black),
                      label: const Text("Invoice No"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Invoice No",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black26),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.08),
                Container(
                  height: width * 0.12,
                  width: width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(orange)),
                      onPressed: () {
                        saveData();
                      },
                      child: Text("Submit",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.045,
                              color: Colors.black))),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void saveData() {
    if (fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your full name.")));
    } else if (emailController.text.isEmpty) {
      const snackBar =
          SnackBar(content: Text("Please enter your email address."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (phoneNumberController.text.isEmpty) {
      const snackBar =
          SnackBar(content: Text("Please enter your phone number."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (quntController.text.isEmpty) {
      const snackBar =
          SnackBar(content: Text("Please enter product quantity."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (disController.text.isEmpty) {
      const snackBar =
          SnackBar(content: Text("Please enter product description."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (invoiceNoController.text.isEmpty) {
      const snackBar = SnackBar(content: Text("Please enter Invoice Number."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (dateofPurchaseController.text.isEmpty) {
      const snackBar =
          SnackBar(content: Text("Please enter Date of Purchase."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String fName = fullNameController.text;
      String email = emailController.text;
      String phoneNo = phoneNumberController.text;
      String quantity = quntController.text;
      String description = disController.text;
      String invoiceNo = invoiceNoController.text;

      String dateofPurchase = dateofPurchaseController.text;
      DatabaseReference dataRef =
          FirebaseDatabase.instance.reference().child("reports");

      Map<String, String> contacts = {
        "invoice_no": invoiceNo,
        "date_of_purchase": dateofPurchase,
        "product_category": selectedCat.name,
        "product_subcategory": selectedSubCat,
        "name": fName,
        "email": email,
        "phone": phoneNo,
        "quantity": quantity,
        "description": description,
        "status": "pending",
      };
      dataRef.push().set(contacts);
      fullNameController.clear();
      quntController.clear();
      emailController.clear();
      phoneNumberController.clear();
      disController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your report submitted successfully.")));
      FocusScope.of(context).requestFocus(new FocusNode());
      Navigator.of(context).pop();
    }
  }
}
