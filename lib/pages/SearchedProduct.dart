import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/model/Product.dart';
import 'package:amazonclone/widgets/SeacrhResultProduct.dart';
import 'package:amazonclone/pages/Address.dart';
import 'package:amazonclone/pages/ProductPage.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:amazonclone/services/HomeService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedScreen extends StatefulWidget {
  const SearchedScreen({super.key, required this.searchquery});
  static const String routeName = '/search-screen';
  final String searchquery;

  @override
  State<SearchedScreen> createState() => _SearchedScreenState();
}

class _SearchedScreenState extends State<SearchedScreen> {
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

  void search_again(String search) async {
    HomeService sev = HomeService();
    productList =
        await sev.fetchSearchProducts(context: context, query: search);

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
          preferredSize: const Size.fromHeight(0),
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
                                isLoading = true;

                                setState(() {});
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
            // fixing this particular widget
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(),
            ),
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

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AddressScreen.routeName, arguments: false);
      },
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ], stops: [
            0.5,
            1.0
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.black,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Delivery to ${user.name}- ${user.address}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  top: 2,
                ),
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.black,
                  size: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
