import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/pages/productdetails.dart';
import 'package:amazonclone/services/home_services.dart';
import 'package:amazonclone/widgets/stars.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});
  final String category;
  static const String routeName = 'category-deals';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product> product_list = [];
  home_back_services serv = home_back_services();
  bool isLoading = true;

  void fetchcatproducts() async {
    product_list = await serv.fetchCategoryProducts(
        context: context, category: widget.category);
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcatproducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            flexibleSpace: Container(
              // flexible space is used to give gradient color
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverAppBar(
            // disable the Sliver app bar back button
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
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
                      gradient: GlobalVariables.appBarGradient),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.category,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
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
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Keep shopping for ${widget.category}',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: isLoading
                        ? Container(
                            height: 180,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                          )
                        : product_list.isEmpty
                            ? Opacity(
                                opacity: 0.4,
                                child: Container(
                                  height: 650,
                                  child: Center(
                                      child: Image.asset(
                                    "images/amazon_in.png",
                                    width: 270,
                                    color: Colors.black,
                                    fit: BoxFit.fitWidth,
                                  )),
                                ),
                              )
                            : GridView.builder(
                                physics:
                                    NeverScrollableScrollPhysics(), // otherwise it will not scroll
                                scrollDirection: Axis.vertical,
                                itemCount: product_list.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  // how many products in rows side thing
                                  crossAxisCount: 2, mainAxisExtent: 335,
                                ),
                                itemBuilder: (context, index) {
                                  double totalrating = 0;
                                  double avgRating = 0;
                                  for (var i = 0;
                                      i < product_list[index].rating!.length;
                                      i++) {
                                    totalrating +=
                                        product_list[index].rating![i].rating;
                                  }

                                  if (totalrating != 0) {
                                    avgRating = totalrating /
                                        product_list[index].rating!.length;
                                  }
                                  Product product = product_list[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 8),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: GlobalVariables
                                                  .selectedNavBarColor
                                                  .withOpacity(0.3),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                product.images[0],
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                height: 130,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              product.name,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child:
                                                rating_app(rating: avgRating),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0, left: 10),
                                            child: Text(
                                              "\$${product.price}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: GlobalVariables
                                                      .selectedNavBarColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, left: 10),
                                                child: product.quantity == 0.0
                                                    ? const Text(
                                                        "Out Of Stock",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : const Text(
                                                        "In Stock",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  ProductDetailScreen.routeName,
                                                  arguments:
                                                      product_list[index]);
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                decoration: const BoxDecoration(
                                                    border: BorderDirectional(
                                                        top: BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            width: 1.5))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 7,
                                                          top: 3,
                                                          left: 45),
                                                  child: Text(
                                                    "View Product",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: GlobalVariables
                                                            .selectedNavBarColor),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
