import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/model/Product.dart';
import 'package:amazonclone/widgets/SeacrhResultProduct.dart';
import 'package:amazonclone/pages/ProductPage.dart';
import 'package:amazonclone/services/HomeService.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({super.key, required this.searchquery});
  static const String routeName = '/search-screen';
  final String searchquery;

  @override
  State<Explore> createState() => _exploreState();
}

class _exploreState extends State<Explore> {
  late List<Product> productList;
  bool isLoading = true;

// function to fetch the searched products
  fetchedProdcuts() async {
    HomeService sev = HomeService();
    productList = await sev.fetchSearchProducts(
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
                  const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
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
                          color: GlobalVariables.SelectedNavBarColor,
                        ),
                      ),
                    )
                  : productList.isEmpty
                      ? Opacity(
                          opacity: 0.4,
                          child: Container(
                            height: 650,
                            child: Center(
                                child: Image.asset(
                              "images/amazon.png",
                              width: 270,
                              color: Colors.black,
                              fit: BoxFit.fitWidth,
                            )),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProductDetailScreen.routeName,
                                    arguments: productList[index]);
                              },
                              child: SeacrhResultProduct(
                                  product: productList[index]),
                            );
                          }),
            ),
          ],
        ));
  }
}
