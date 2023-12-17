import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/widgets/CustomButton.dart';
import 'package:amazonclone/widgets/CartProduct.dart';
import 'package:amazonclone/widgets/TotalCheckout.dart';
import 'package:amazonclone/pages/Address.dart';
import 'package:amazonclone/pages/SearchedProduct.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _cartpageState();
}

class _cartpageState extends State<CartScreen> {
  TextEditingController search = TextEditingController();
  void navigateTosearchScreen(String query) {
    Navigator.pushNamed(context, SearchedScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

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
        slivers: [
          SliverAppBar(
            // disable the Sliver app bar back button
            backgroundColor: Colors.white,

            // used to the set the back button of the screen
            pinned: true,
            automaticallyImplyLeading: false,

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
                        padding: const EdgeInsets.fromLTRB(20, 6, 6, 8),
                        width: 300,
                        height: 50,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              navigateTosearchScreen(value);
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
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: user.user.cart.isEmpty
                ? Opacity(
                    opacity: 0.4,
                    child: Container(
                      height: 450,
                      child: Center(
                          child: Image.asset(
                        "images/amazon.png",
                        width: 270,
                        color: Colors.black,
                        fit: BoxFit.fitWidth,
                      )),
                    ),
                  )
                : Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: user.user.cart.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return CartProduct(index: index);
                        }),
                  ),
          ),
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final user = context.watch<UserProvider>();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AddressScreen.routeName,
                  arguments: false);
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
                          'Delivery to ${user.user.name}- ${user.user.address}',
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
          ),
          const TotalCheckout(),
          user.user.cart.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                    text: 'Proceed to CheckOut ${user.user.cart.length} items',
                    onTap: () {
                      Navigator.pushNamed(context, AddressScreen.routeName,
                          arguments: true);
                    },
                    color: Colors.yellow[600],
                  ),
                )
              : Container(),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: Colors.black12.withOpacity(0.4),
            height: 1,
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 183;

  @override
  double get minExtent => 183;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
