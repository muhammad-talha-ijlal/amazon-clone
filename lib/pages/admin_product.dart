import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/services/product_details_services.dart';
import 'package:amazonclone/widgets/stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class adminProductShow extends StatefulWidget {
  const adminProductShow({super.key, required this.product});
  final Product product;

  @override
  State<adminProductShow> createState() => _adminProductShowState();
}

class _adminProductShowState extends State<adminProductShow> {
  // avg rating for the show at top
  //  my rating to show the at bottom
  double avgRating = 0;
  double myrating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalrating = 0;

    for (var i = 0; i < widget.product.rating!.length; i++) {
      totalrating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myrating = widget.product.rating![i].rating;
      }
    }

    if (totalrating != 0) {
      avgRating = totalrating / widget.product.rating!.length;
    }
  }

  int curr_page = 0;

  void addTocart() {
    ProductDetailsServices pred = ProductDetailsServices();
    pred.addCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsServices prd_serv = ProductDetailsServices();
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          ),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            toolbarHeight: 50,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 22,
              ),
            ),
            flexibleSpace: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.only(top: 5),
                  height: 50,
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.appBarGradient),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 8, left: 34),
                        child: Image.asset(
                          "images/amazon_in.png",
                          width: 120,
                          height: 45,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.product.id!,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: rating_app(rating: avgRating),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: GlobalVariables.selectedNavBarColor
                              .withOpacity(0.8)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 5, left: 14, right: 14),
                    child: CarouselSlider(
                        items: widget.product.images.map((e) {
                          return Builder(
                            builder: (BuildContext context) => Image.network(
                              e,
                              fit: BoxFit.contain,
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                        }).toList(), // return list of widgets
                        options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              curr_page = index;
                              setState(() {});
                            },
                            viewportFraction: 1, // fraction of veiport occupied
                            height: 300)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          widget.product.images.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: curr_page != index
                                      ? GlobalVariables.unselectedNavBarColor
                                          .withOpacity(0.5)
                                      : GlobalVariables.selectedNavBarColor,
                                ),
                              )),
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 8, right: 8, bottom: 0),
                    child: RichText(
                        text: TextSpan(
                            text: "Deal Price: ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: "\$${widget.product.price}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.red))
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 8),
                    child: widget.product.quantity == 0.0
                        ? Text(
                            "Out Of Stock",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.red.withOpacity(0.9),
                                fontWeight: FontWeight.w500),
                          )
                        : const Text(
                            "In Stock",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      style: TextStyle(
                          fontSize: 14,
                          color: GlobalVariables.unselectedNavBarColor
                              .withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
