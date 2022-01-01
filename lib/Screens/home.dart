import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/place_order.dart';
import 'package:ohishan/Screens/product_detail.dart';
import 'package:ohishan/Screens/products.dart';
import 'package:ohishan/Screens/productslider_widget.dart';
import 'package:ohishan/Screens/report_screen.dart';
import 'package:ohishan/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  Map<String, dynamic> categoryList = {};
  Map<String, dynamic> productList = {};
  Map<String, dynamic> flashProductList = {};
  Map<String, dynamic> weeklyBestProductList = {};
  Map<String, dynamic> userDetail = {};
  Map<String, dynamic> liveNews = {};
  String dealershipUrl = "";
  @override
  void initState() {
    getData();
    DatabaseReference refUser = FirebaseDatabase.instance
        .ref("dealership")
        .child("-MrX_ykqJie-re6kG4jc");
    Stream<DatabaseEvent> streamUser = refUser.onValue;
    streamUser.listen((DatabaseEvent event) async {
      try {
        userDetail = jsonDecode(jsonEncode(event.snapshot.value));
        dealershipUrl = userDetail['url'];
        print(dealershipUrl);

        setState(() {});
      } catch (e) {
        print(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: width * 0.04),
            if (liveNews.isNotEmpty)
              CarouselSlider(
                items: [
                  for (int i = 0; i < liveNews.length; i++)
                    ProductsliderWidget(liveNews[liveNews.keys.elementAt(i)]),
                  // Container(
                  //   width: width,
                  //   margin: const EdgeInsets.all(2.0),
                  //   padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     image: const DecorationImage(
                  //       image: AssetImage("assets/slide1.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                ],
                options: CarouselOptions(
                  height: height * 0.197,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                  viewportFraction: 1,
                ),
              ),
            SizedBox(height: width * 0.04),
            Text(
              "Product Categories",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: width * 0.045),
            ),
            SizedBox(height: width * 0.04),
            categoryList.isNotEmpty
                ? Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < categoryList.length; i++)
                        CategoryCard(
                            width: width, categoryList: categoryList, pos: i),
                    ],
                  )
                : SizedBox(
                    height: 70,
                    width: width,
                    child: const Center(child: CircularProgressIndicator())),
            SizedBox(height: width * 0.04),
            Container(
              // padding: EdgeInsets.only(right: width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.only(right: width * 0.02),
                      height: width * 0.35,
                      child: InkWell(
                        child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/icon-place-order-314x314.png')),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Place Order",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.030,
                                        color: Colors.black)),
                              ],
                            )),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlaceOrder()));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.only(right: width * 0.02),
                      height: width * 0.35,
                      child: InkWell(
                        child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/icon-quality-assurance-314x314.png')),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Quality Assurance",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.030,
                                        color: Colors.black)),
                              ],
                            )),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReportsScreen()));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.only(right: width * 0.02),
                      height: width * 0.35,
                      child: InkWell(
                        child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/icon-contact-dealership-314x314.png')),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Dealership Enquiry",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.030,
                                        color: Colors.black)),
                              ],
                            )),
                        onTap: () async {
                          String url = dealershipUrl;

                          if (await canLaunch(dealershipUrl)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch dealershipUrl}';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Flash Sale",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                // Text("2d 21h 10m 05s", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.red)),
              ],
            ),
            SizedBox(height: width * 0.04),
            if (flashProductList.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < flashProductList.length; i++)
                      TopProductContainer(
                          width: width * 0.8,
                          pos: i,
                          productList: flashProductList),
                  ],
                ),
              ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Top Products",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                // Text("View All", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: grey)),
              ],
            ),
            SizedBox(height: width * 0.04),
            if (productList.isNotEmpty)
              Wrap(
                children: [
                  for (int i = 0; i < min(4, productList.length); i++)
                    TopProductContainer(
                        width: width, pos: i, productList: productList),
                ],
              ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Weekly Best Sellers",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                // Text("View All", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: grey)),
              ],
            ),
            if (weeklyBestProductList.isNotEmpty)
              Column(
                children: [
                  for (int i = 0; i < weeklyBestProductList.length; i++)
                    BestSellerContainer(
                        width: width,
                        pos: i,
                        weeklyBestProductList: weeklyBestProductList),
                ],
              ),
            SizedBox(height: width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Featured Products",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                // Text("View All", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: grey)),
              ],
            ),
            SizedBox(height: width * 0.04),
            Wrap(children: [
              for (int i = 0; i < min(4, flashProductList.length); i++)
                TopProductContainer(
                    width: width, pos: i, productList: flashProductList),
            ]),
            SizedBox(height: width * 0.04),

            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Collections", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                InkWell(
                  child: Text("View All", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: grey)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Products(selectedCatId: "", categoryList: categoryList)));
                  },
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CollectionContainer(width: width),
                  CollectionContainer(width: width),
                  CollectionContainer(width: width),
                  CollectionContainer(width: width),
                ],
              ),
            ),
            SizedBox(height: width * 0.1),*/
          ],
        ),
      ),
    ));
  }

  void getData() {
    //get category
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("category");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          categoryList = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }

    //get products
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("product");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          productList = jsonDecode(jsonEncode(event.snapshot.value));
          weeklyBestProductList.clear();
          flashProductList.clear();
          for (int i = 0; i < productList.length; i++) {
            if (productList[productList.keys.elementAt(i)]['status'] == "1") {
              flashProductList.addAll({
                productList.keys.elementAt(i):
                    productList[productList.keys.elementAt(i)]
              });
            } else if (productList[productList.keys.elementAt(i)]['status'] ==
                "2") {
              weeklyBestProductList.addAll({
                productList.keys.elementAt(i):
                    productList[productList.keys.elementAt(i)]
              });
            }
          }
          setState(() {});
        } on Exception catch (e) {
          setState(() {});
        }
      });
    } catch (e) {}

    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("slider");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          liveNews = jsonDecode(jsonEncode(event.snapshot.value));
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

class CollectionContainer extends StatelessWidget {
  const CollectionContainer({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: width * 0.5,
        width: width * 0.45,
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
              image: AssetImage("assets/image-114.jpg"), fit: BoxFit.cover),
        ),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mens",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045),
              ),
              Text(
                "4 Items",
                style: GoogleFonts.roboto(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Products(
                selectedCatId: "", categoryList: {}, isSHowAppbar: true)));
      },
    );
  }
}

class BestSellerContainer extends StatelessWidget {
  const BestSellerContainer(
      {Key? key,
      required this.width,
      required this.weeklyBestProductList,
      required this.pos})
      : super(key: key);
  final Map<String, dynamic> weeklyBestProductList;
  final int pos;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.42,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: width * 0.02),
      child: InkWell(
        child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: width * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: FadeInImage(
                        image: NetworkImage(Constant.catImageBasePath +
                            weeklyBestProductList[weeklyBestProductList.keys
                                .elementAt(pos)]['image']),
                        placeholder: const AssetImage("assets/logo_blue.png"),
                        // placeholderFit: BoxFit.contain,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/logo_blue.png",
                              height: 70, width: 70, fit: BoxFit.contain);
                        },
                        height: 70,
                        width: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.7),
                          child: Text(
                            weeklyBestProductList[weeklyBestProductList.keys
                                .elementAt(pos)]['product_name'],
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.045,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            weeklyBestProductList[weeklyBestProductList.keys
                                .elementAt(pos)]['shortdescription'],
                            style: GoogleFonts.roboto(
                                fontSize: width * 0.025, color: Colors.grey),
                          ),
                        ),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(orange)),
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_ios_outlined),
                            label: Text("Get A Quote",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.04,
                                    color: Colors.white)))
                      ],
                    ),
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                    productId: weeklyBestProductList.keys.elementAt(pos),
                  )));
        },
      ),
    );
  }
}

class TopProductContainer extends StatelessWidget {
  const TopProductContainer(
      {Key? key,
      required this.width,
      required this.pos,
      required this.productList})
      : super(key: key);
  final Map<String, dynamic> productList;
  final int pos;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.52,
      width: width * 0.45,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: InkWell(
        child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: FadeInImage(
                        image: NetworkImage(Constant.catImageBasePath +
                            productList[productList.keys.elementAt(pos)]
                                ['image']),
                        placeholder: const AssetImage("assets/logo_blue.png"),
                        // placeholderFit: BoxFit.contain,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/logo_blue.png",
                              height: 70, width: 70, fit: BoxFit.contain);
                        },
                        height: 70,
                        width: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          productList[productList.keys.elementAt(pos)]
                              ['product_name'],
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                              color: Colors.black),
                          maxLines: 2,
                        ),
                        Text(
                          productList[productList.keys.elementAt(pos)]
                              ['shortdescription'],
                          style: GoogleFonts.roboto(
                              fontSize: width * 0.03, color: Colors.blue),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                    productId: productList.keys.elementAt(pos),
                  )));
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      required this.width,
      required this.categoryList,
      required this.pos})
      : super(key: key);
  final Map<String, dynamic> categoryList;
  final int pos;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(right: width * 0.02),
      height: width * 0.3,
      width: width * 0.3,
      child: InkWell(
        child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child: categoryList[categoryList.keys.elementAt(pos)]['image']
                          .isNotEmpty
                      ? FadeInImage(
                          image: NetworkImage(Constant.catImageBasePath +
                              categoryList[categoryList.keys.elementAt(pos)]
                                  ['image']),
                          placeholder: const AssetImage("assets/logo_blue.png"),
                          // placeholderFit: BoxFit.contain,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/logo_blue.png",
                                height: 70, width: 70, fit: BoxFit.contain);
                          },
                          height: 70,
                          width: 70,
                          fit: BoxFit.contain,
                        )
                      : const Icon(Icons.lightbulb_outline,
                          color: orange, size: 20),
                ),
                SizedBox(height: width * 0.02),
                Text(categoryList[categoryList.keys.elementAt(pos)]['name'],
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.030,
                        color: grey)),
              ],
            )),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Products(
                  selectedCatId: categoryList.keys.elementAt(pos),
                  categoryList: categoryList,
                  isSHowAppbar: true)));
        },
      ),
    );
  }
}

/*class SaleTile extends StatelessWidget {
  const SaleTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.52,
      width: width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: InkWell(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/image-043.jpg",
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Ohisan Platinum",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.04, color: Colors.black),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$36",
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.05, color: blue),
                          ),
                          Text(
                            "\$42",
                            style: GoogleFonts.roboto(textStyle: const TextStyle(decoration: TextDecoration.lineThrough), fontWeight: FontWeight.bold, fontSize: width * 0.03, color: grey),
                          ),
                        ],
                      ),
                      LinearPercentIndicator(
                        width: width * 0.25,
                        lineHeight: width * 0.02,
                        percent: 0.2,
                        progressColor: Colors.red,
                        center: Text(
                          "22% Sold",
                          style: TextStyle(fontSize: width * 0.02),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail()));
        },
      ),
    );
  }
}*/

/*class FeaturedProductContainer extends StatelessWidget {
  const FeaturedProductContainer({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: width * 0.52,
      width: width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: InkWell(
        child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/image-089.jpg"))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Spacer(),
                            Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Solar Panel",
                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$13",
                                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.05, color: blue),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      "\$20",
                                      style: GoogleFonts.roboto(textStyle: const TextStyle(decoration: TextDecoration.lineThrough), fontWeight: FontWeight.bold, fontSize: width * 0.03, color: grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: width * 0.02),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail()));
        },
      ),
    ));
  }
}*/
