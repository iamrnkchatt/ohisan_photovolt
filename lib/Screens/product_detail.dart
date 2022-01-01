import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/contact_screen.dart';
import 'package:ohishan/Screens/products.dart';
import 'package:ohishan/Screens/report_screen.dart';
import 'package:ohishan/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Map<String, dynamic> productDetails = {};
  Map<String, dynamic> relatedProductList = {};

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("product").child(widget.productId);
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          productDetails = jsonDecode(jsonEncode(event.snapshot.value));
          getRelatedProduct();
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void getRelatedProduct() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("product");
      Stream<DatabaseEvent> stream = ref
          .orderByChild('category')
          .equalTo(productDetails['category'])
          .onValue;
      stream.listen((DatabaseEvent event) {
        try {
          relatedProductList = jsonDecode(jsonEncode(event.snapshot.value));
          setState(() {});
        } on Exception catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Product Details",
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
      body: productDetails.isNotEmpty
          ? SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width * 0.04),
                    CarouselSlider(
                      items: [
                        Container(
                          width: width,
                          margin: const EdgeInsets.all(2.0),
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${Constant.catImageBasePath}${productDetails['image']}"),
                                fit: BoxFit.contain), //BoxFit.cover
                          ),
                          child: null,
                        ),
                      ],
                      options: CarouselOptions(
                        height: height * 0.3,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1200),
                        viewportFraction: 1,
                      ),
                    ),
                    SizedBox(height: width * 0.04),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Card(
                          elevation: 5,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  productDetails['product_name'],
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.06,
                                      color: Colors.black),
                                  maxLines: 2,
                                ),
                                SizedBox(height: width * 0.02),
                                Text(
                                  productDetails['shortdescription'],
                                  style: GoogleFonts.roboto(
                                      fontSize: width * 0.04,
                                      color: Colors.grey),
                                  maxLines: 3,
                                ),
                                SizedBox(height: width * 0.02),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: width * 0.04),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(orange)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ContactScreen(
                                                isShowAppbar: true,
                                                productName: productDetails[
                                                    'product_name'])));
                                  },
                                  child: Text("Get a Quote",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: width * 0.04)),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.amber)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReportsScreen()));
                                  },
                                  child: Text(
                                    "Report Quality issue",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: width * 0.04),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: width * 0.04),
                    SpecificationContainer(
                        width: width, productDetails: productDetails),
                    SizedBox(height: width * 0.04),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Related Products",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.045),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Products(
                                      selectedCatId: productDetails['category'],
                                      categoryList: {},
                                      isSHowAppbar: true)));
                            },
                            child: Text("View All",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.045,
                                    color: grey)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: width * 0.04),
                    if (relatedProductList.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < relatedProductList.length; i++)
                              TopProductContainer(
                                  width: width * 0.8,
                                  pos: i,
                                  productList: relatedProductList),
                          ],
                        ),
                      ),
                    SizedBox(height: width * 0.04),
                    /*Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Ratings and Reviews",
                                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: width * 0.045, color: Colors.black),
                                ),
                                RatingTile(width: width),
                                const Divider(thickness: 2),
                                RatingTile(width: width),
                                const Divider(thickness: 2),
                                RatingTile(width: width),
                                const Divider(thickness: 2),
                                RatingTile(width: width),
                                const Divider(thickness: 2),
                                RatingTile(width: width),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: width * 0.04),
                    SubmitReview(width: width),
                    SizedBox(height: width * 0.08),*/
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class SubmitReview extends StatelessWidget {
  const SubmitReview({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.65,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Submit A Review",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.045,
                      color: Colors.black),
                ),
                SizedBox(height: width * 0.02),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: orange,
                      size: width * 0.1,
                    ),
                    Icon(
                      Icons.star_border,
                      color: orange,
                      size: width * 0.1,
                    ),
                    Icon(
                      Icons.star_border,
                      color: orange,
                      size: width * 0.1,
                    ),
                    Icon(
                      Icons.star_border,
                      color: orange,
                      size: width * 0.1,
                    ),
                    Icon(
                      Icons.star_border,
                      color: orange,
                      size: width * 0.1,
                    )
                  ],
                ),
                SizedBox(height: width * 0.04),
                TextFormField(
                  minLines: 2,
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      label: const Text("Write Your Review"),
                      labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      hintText: "Write your Review",
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300))),
                ),
                SizedBox(height: width * 0.04),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(orange)),
                    onPressed: () {},
                    child: Text(
                      "Review",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.04,
                          color: Colors.white),
                    ))
              ],
            ),
          )),
    );
  }
}

class RatingTile extends StatelessWidget {
  const RatingTile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: width * 0.04,
          ),
          Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: width * 0.04,
          ),
          Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: width * 0.04,
          ),
          Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: width * 0.04,
          ),
          Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: width * 0.04,
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Very good product.",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: width * 0.04,
                color: grey),
          ),
          Text(
            "Designed world 26 Dec 2021",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: width * 0.03,
                color: grey),
          )
        ],
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
                          maxLines: 3,
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

class SpecificationContainer extends StatelessWidget {
  const SpecificationContainer(
      {Key? key, required this.width, required this.productDetails})
      : super(key: key);
  final Map<String, dynamic> productDetails;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Specifications",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: width * 0.045),
                ),
                SizedBox(height: width * 0.02),
                Html(data: productDetails['longdescription']),
                SizedBox(height: width * 0.02),
                Html(
                  data: productDetails['addition_information'],
                ),
              ],
            ),
          )),
    );
  }
}

class SaleContainer extends StatelessWidget {
  const SaleContainer({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.2,
      // width: width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.flash_on,
                          color: grey,
                          size: width * 0.04,
                        ),
                        Text(
                          "Flash Sale",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: grey,
                              fontSize: width * 0.04),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(height: width * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "2d 21h 10m 05s",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.045,
                          color: Colors.red),
                    ),
                    LinearPercentIndicator(
                      width: width * 0.3,
                      lineHeight: width * 0.03,
                      percent: 0.2,
                      progressColor: Colors.red,
                      center: Text(
                        "22% Sold",
                        style: TextStyle(fontSize: width * 0.03),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class ColorContainer extends StatelessWidget {
  const ColorContainer({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.2,
      // width: width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: grey,
                          fontSize: width * 0.04),
                    ),
                    Text(
                      "Size",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: grey,
                          fontSize: width * 0.04),
                    ),
                  ],
                )),
                SizedBox(height: width * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.pink),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            color: orange),
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        "S",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: grey,
                            fontSize: width * 0.04),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade300),
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        "M",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: grey,
                            fontSize: width * 0.04),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade300),
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        "L",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: grey,
                            fontSize: width * 0.04),
                      ),
                    ])
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
