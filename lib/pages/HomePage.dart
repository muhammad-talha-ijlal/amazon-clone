import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/pages/Address.dart';
import 'package:amazonclone/pages/SearchedProduct.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:amazonclone/widgets/CustomScroll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _home_actual_pageState();
}

class _home_actual_pageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void navigateTosearchScreen(String query) {
      Navigator.pushNamed(context, SearchedScreen.routeName, arguments: query);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 60, // Set the height of the search bar
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 10, 6, 12),
                    width: 300,
                    height: 60,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 1,
                      child: TextFormField(
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted:
                            navigateTosearchScreen, // on submission this widget get submitted
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
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(),
          ),
          // scrollable part of the image
          const SliverToBoxAdapter(
            child: CustomScroll(),
          ),
        ],
      ),
    );
  }
}

// fixing this particular widget
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
