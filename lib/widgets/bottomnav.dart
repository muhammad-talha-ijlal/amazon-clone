import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/pages/Account.dart';
import 'package:amazonclone/pages/Cart.dart';
import 'package:amazonclone/pages/Explore.dart';
import 'package:amazonclone/pages/HomePage.dart';
import 'package:amazonclone/pages/OrderPage.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart'; // ussed to show number in the icons

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static const String routename = '/actual-home';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottom_width = 42;
  double selectedborder = 3;
  double font_size = 12;

  List<Widget> pages = [
    const HomePage(),
    const AccountScreen(),
    const Explore(searchquery: ""),
    const CartScreen(),
    OrderScreen()
  ];

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartlen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // fixed width of the bottom nav bar height
        elevation: 0,
        currentIndex: _page,
        selectedFontSize: 0,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,

        iconSize: 24,
        onTap: updatepage,
        items: [
          // home
          BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: bottom_width,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _page == 0
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor,
                                width: selectedborder))),
                    child: const Icon(Icons.home_outlined),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('Home',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.black)),
                  )
                ],
              ),
              label: ''),
          // profile
          BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: bottom_width,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _page == 1
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor,
                                width: selectedborder))),
                    child: const Icon(Icons.person_outline),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('You',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.black)),
                  )
                ],
              ),
              label: ''),

          // more
          BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: bottom_width,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _page == 2
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor,
                                width: selectedborder))),
                    child: const Icon(Icons.layers_outlined),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('More',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 2
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.black)),
                  )
                ],
              ),
              label: ''),
          // cart
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Container(
                      width: bottom_width,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: _page == 3
                                      ? GlobalVariables.selectedNavBarColor
                                      : GlobalVariables.backgroundColor,
                                  width: selectedborder))),
                      child: badges.Badge(
                        badgeContent: Text(
                          userCartlen.toString(),
                          style: TextStyle(
                              color: _page == 3
                                  ? GlobalVariables.selectedNavBarColor
                                  : Colors.black),
                        ),
                        child: const Icon(Icons.shopping_cart_outlined),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('Cart',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 3
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.black)),
                  )
                ],
              ),
              label: ''),

// others options
          BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: bottom_width,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _page == 4
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor,
                                width: selectedborder))),
                    child: const Icon(Icons.more_horiz),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('Menu',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 4
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.black)),
                  )
                ],
              ),
              label: ''),
        ],
      ),
    );
  }
}
