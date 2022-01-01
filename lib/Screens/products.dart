import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohishan/Screens/product_detail.dart';
import 'package:ohishan/constant.dart';

class Products extends StatefulWidget {
  final Map<String, dynamic> categoryList;
  final String selectedCatId;
  final bool isSHowAppbar;

  const Products(
      {Key? key,
      required this.categoryList,
      required this.selectedCatId,
      required this.isSHowAppbar})
      : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Map<String, dynamic> categoryList = {};
  Map<String, dynamic> productList = {};
  Map<String, dynamic> catProductList = {};
  String selectedCatId = "";

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: widget.isSHowAppbar
            ? AppBar(
                backgroundColor: Colors.white,
                title: Text("Products",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.045,
                        color: Colors.black)),
                iconTheme: const IconThemeData(color: grey),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.orange),
                    onPressed: () => Navigator.of(context).pop()),
              )
            : null,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: width * 0.02),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < categoryList.length; i++)
                        InkWell(
                          onTap: () {
                            try {
                              selectedCatId = categoryList.keys.elementAt(i);
                              catProductList.clear();
                              for (int i = 0; i < productList.length; i++) {
                                if (productList[productList.keys.elementAt(i)]
                                        ['category'] ==
                                    selectedCatId) {
                                  catProductList.addAll({
                                    productList.keys.elementAt(i): productList[
                                        productList.keys.elementAt(i)]
                                  });
                                }
                              }
                            } catch (e) {}
                            setState(() {});
                          },
                          child: Container(
                            height: width * 0.12,
                            padding: EdgeInsets.only(right: width * 0.02),
                            child: Card(
                              elevation: 2,
                              color: categoryList.keys.elementAt(i) ==
                                      selectedCatId
                                  ? orange
                                  : Colors.white,
                              shadowColor: blue,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      categoryList.keys.elementAt(i) ==
                                              selectedCatId
                                          ? Icon(Icons.lightbulb,
                                              color: Colors.white,
                                              size: width * 0.04)
                                          : Icon(Icons.light_mode,
                                              color: orange,
                                              size: width * 0.04),
                                      SizedBox(width: width * 0.01),
                                      Text(
                                          categoryList[categoryList.keys
                                              .elementAt(i)]['name'],
                                          style: GoogleFonts.ptSans(
                                              color: categoryList.keys
                                                          .elementAt(i) ==
                                                      selectedCatId
                                                  ? Colors.white
                                                  : blue,
                                              fontSize: width * 0.04,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.02),
                if (productList.isNotEmpty)
                  Wrap(
                    children: [
                      for (int i = 0; i < catProductList.length; i++)
                        TopProductContainer(
                            width: width, pos: i, productList: catProductList),
                    ],
                  ),
                SizedBox(height: width * 0.08),
              ],
            ),
          ),
        ));
  }

  getCategory() {
    if (widget.categoryList.isEmpty) {
      try {
        DatabaseReference ref = FirebaseDatabase.instance.ref("category");
        Stream<DatabaseEvent> stream = ref.onValue;
        stream.listen((DatabaseEvent event) {
          try {
            categoryList = jsonDecode(jsonEncode(event.snapshot.value));
            selectedCatId = widget.selectedCatId.isNotEmpty
                ? widget.selectedCatId
                : categoryList.keys.elementAt(0);
            getProducts();
          } on Exception catch (e) {
            print(e);
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      categoryList = widget.categoryList;
      selectedCatId = widget.selectedCatId.isNotEmpty
          ? widget.selectedCatId
          : categoryList.keys.elementAt(0);
      getProducts();
    }
  }

  getProducts() {
    //get products
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("product");
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        try {
          productList = jsonDecode(jsonEncode(event.snapshot.value));
          try {
            catProductList.clear();
            for (int i = 0; i < productList.length; i++) {
              if (productList[productList.keys.elementAt(i)]['category'] ==
                  selectedCatId) {
                catProductList.addAll({
                  productList.keys.elementAt(i):
                      productList[productList.keys.elementAt(i)]
                });
              }
            }
          } catch (e) {}
          setState(() {});
        } on Exception catch (e) {
          setState(() {});
        }
      });
    } catch (e) {}
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
              builder: (context) =>
                  ProductDetail(productId: productList.keys.elementAt(pos))));
        },
      ),
    );
  }
}
