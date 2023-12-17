import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/pages/searched_product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/services/product_details_services.dart';
import 'package:amazonclone/widgets/CustomButton.dart';
import 'package:amazonclone/widgets/RatingApp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  static const String routeName = '/product.details';
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late List<Product> product_list;
  bool isLoading = false;
  int curr_page = 0;
  void search_again(String search) async {
    Navigator.pushNamed(context, SearchedScreen.routeName, arguments: search);
  }

  // avg rating for the show at top
  //  my rating to show the at bottom
  double avgRating = 0;
  double myrating = 0;

  @override
  void initState() {
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
                  const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
            ),
          ),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            // disable the Sliver app bar back button
            backgroundColor: Colors.white,

            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 28,
              ),
            ), // used to the set the back button of the screen
            pinned: true,
            automaticallyImplyLeading: true,

            toolbarHeight: 50,
            flexibleSpace: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.only(top: 5),
                  height: 50,
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.AppBarGradient),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 6, 6, 8),
                        width: 300,
                        height: 50,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              search_again(value);
                            },
                            textInputAction: TextInputAction.search,
                            // on submission this widget get submitted
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Icon(
                                    Icons.qr_code_scanner,
                                    color: Colors.black54,
                                    size: 23,
                                  ),
                                ),
                              ),
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 23,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(top: 10),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                  color: GlobalVariables.SelectedNavBarColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              hintText: 'Search Amazon.com',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.black,
                          size: 25,
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
                        child: RatingApp(rating: avgRating),
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
                          color:
                              GlobalVariables.SelectedNavBarColor.withOpacity(
                                  0.8)),
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
                                      ? GlobalVariables.UnselectedNavBarColor
                                          .withOpacity(0.5)
                                      : GlobalVariables.SelectedNavBarColor,
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
                          color:
                              GlobalVariables.UnselectedNavBarColor.withOpacity(
                                  0.8),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: CustomButton(
                        text: 'Buy Now',
                        onTap: () {},
                        color: GlobalVariables.ButtonColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: CustomButton(
                        text: 'Add to Cart',
                        onTap: () {
                          addTocart();
                        },
                        color: const Color.fromARGB(223, 254, 180, 19)),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "Rate the Product",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  RatingBar.builder(
                      initialRating: myrating,
                      minRating: 1, // user can give min rating
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 0)
                              .copyWith(bottom: 15),
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: GlobalVariables.SecondaryColor,
                          ),
                      onRatingUpdate: (rating) {
                        prd_serv.rateProduct(
                            context: context,
                            product: widget.product,
                            rating: rating,
                            user: user.id);
                      })
                ],
              ),
            ),
          )
        ]));
  }
}
