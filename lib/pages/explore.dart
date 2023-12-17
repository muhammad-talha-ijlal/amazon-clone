import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/pages/productdetails.dart';
import 'package:amazonclone/services/home_services.dart';
import 'package:amazonclone/widgets/searched_product.dart';
import 'package:flutter/material.dart';

class explore extends StatefulWidget {
  const explore({super.key, required this.searchquery});
  static const String routeName = '/search-screen';
  final String searchquery;

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  late List<Product> product_list;
  bool isLoading = true;

// function to fetch the searched products
  fetchedProdcuts() async {
    home_back_services sev = home_back_services();
    product_list = await sev.fetchSearchProducts(
        context: context, query: widget.searchquery);

    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedProdcuts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
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
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: product_list.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductDetailScreen.routeName,
                                    arguments: product_list[index]);
                              },
                              child: search_result_prodcut(
                                  product: product_list[index]),
                            );
                          }),
            ),
          ],
        ));
  }
}
