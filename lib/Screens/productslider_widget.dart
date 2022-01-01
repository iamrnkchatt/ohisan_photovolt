import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsliderWidget extends StatefulWidget {
  Map<String, dynamic> newsDetail;

  ProductsliderWidget(this.newsDetail);

  @override
  State<ProductsliderWidget> createState() => _ProductsliderWidgetState();
}

class _ProductsliderWidgetState extends State<ProductsliderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      margin: const EdgeInsets.all(2.0),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(
              "https://vedastechnocratspvtltd.com/ohisan/public/backend/image/slider/${widget.newsDetail['image']}"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
