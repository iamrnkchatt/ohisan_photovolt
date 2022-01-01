import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/agent_option.dart';
import 'package:ohishan/Screens/contact_screen.dart';
import 'package:ohishan/Screens/editprofile_screen.dart';
import 'package:ohishan/Screens/home.dart';
import 'package:ohishan/Screens/login.dart';
import 'package:ohishan/Screens/products.dart';
import 'package:ohishan/Screens/report_screen.dart';
import 'package:ohishan/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _page = 0;
  final screens = [
    const Home(),
    const Products(selectedCatId: "", categoryList: {}, isSHowAppbar: false),
    EditProfileScreen(shoeAppBar: false),
    const ContactScreen(isShowAppbar: false, productName: ""),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Map<String, dynamic> categoryList = {};
  Map<String, dynamic> userDetail = {};
  String userStatus = "";
  @override
  void initState() {
    try {
      DatabaseReference refUser =
          FirebaseDatabase.instance.ref("Users").child(Constant.mobileNumber);
      Stream<DatabaseEvent> streamUser = refUser.onValue;
      streamUser.listen((DatabaseEvent event) async {
        try {
          userDetail = jsonDecode(jsonEncode(event.snapshot.value));
          userStatus = userDetail['status'];
          print(userStatus);

          setState(() {});
        } catch (e) {
          print(e);
        }
      });
      DatabaseReference ref = FirebaseDatabase.instance.ref("category");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          categoryList = jsonDecode(jsonEncode(event.snapshot.value));

          setState(() {});
          print("categoryList $categoryList['image']");
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //drawer: Drawer(),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  right: width * 0.04,
                  left: width * 0.04,
                  top: width * 0.15,
                  bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Container(
                      height: width * 0.15,
                      width: width * 0.15,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey, border: Border.all(color: Colors.black), image: const DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/person.jpeg"))),
                      child: null,
                    ),
                    SizedBox(width: width * 0.04),*/
                  Constant.mobileNumber.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Constant.userName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: width * 0.04)),
                            Text(Constant.mobileNumber,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: width * 0.04)),
                          ],
                        )
                      : Text("Hello guest",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: width * 0.04)),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            if (Constant.mobileNumber.isNotEmpty)
              DrawerTile(
                width: width,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) =>
                              const EditProfileScreen(shoeAppBar: true)))
                      .then((value) {
                    setState(() {});
                  });
                },
                text: "Edit Profile",
              ),
            for (int i = 0; i < categoryList.length; i++)
              DrawerTile(
                width: width,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Products(
                          selectedCatId: categoryList.keys.elementAt(i),
                          categoryList: categoryList,
                          isSHowAppbar: true)));
                },
                text: categoryList[categoryList.keys.elementAt(i)]['name'],
              ),
            DrawerTile(
              width: width,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactScreen(
                        isShowAppbar: true, productName: "")));
              },
              text: "Contact Us",
            ),
            DrawerTile(
              width: width,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ReportsScreen()));
              },
              text: "Report Quality issue",
            ),
            userStatus == "1"
                ? DrawerTile(
                    width: width,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BrowseHospital()));
                    },
                    text: "Nearby Electrical Stores",
                  )
                : SizedBox(width: 0.0),
            if (Constant.mobileNumber.isNotEmpty)
              DrawerTile(
                width: width,
                onTap: () async {
                  Constant.mobileNumber = "";
                  Constant.userName = "";
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
                },
                text: "Logout",
              ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        centerTitle: true,
        elevation: 2,
        title: _page == 1
            ? Text("Browse Products",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                    color: Colors.black))
            : Text("Ohisan",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                    color: Colors.black)),
      ),
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 75,
        backgroundColor: blue,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
        index: 0,
        items: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.house_fill, size: width * 0.07, color: blue),
              Text("Home",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.025,
                      color: blue)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.bag, size: width * 0.07, color: blue),
              Text("Products",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.025,
                      color: blue)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance, size: width * 0.07, color: blue),
              Text("Account",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.025,
                      color: blue)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.settings, size: width * 0.07, color: blue),
              Text("Contact",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: width * 0.025,
                      color: blue)),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key, required this.width, required this.onTap, required this.text})
      : super(key: key);

  final double width;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.1,
      child: ListTile(
        onTap: () => onTap(),
        leading: Text(text,
            style: GoogleFonts.ptSans(
                fontWeight: FontWeight.bold, fontSize: width * 0.04)),
        trailing: Text(">",
            style: GoogleFonts.ptSans(
                fontWeight: FontWeight.bold, fontSize: width * 0.04)),
      ),
    );
  }
}
