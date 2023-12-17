import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/pages/admin_order_details.dart';
import 'package:amazonclone/pages/admin_screen.dart';
import 'package:amazonclone/pages/analytics.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class bottom_admin_bar extends StatefulWidget {
  const bottom_admin_bar({super.key});

  @override
  State<bottom_admin_bar> createState() => _bottom_admin_barState();
}

class _bottom_admin_barState extends State<bottom_admin_bar> {
  int _page = 0;
  double bottom_width = 42;
  double selectedborder = 3;
  double font_size = 12;

  List<Widget> pages = [
    const AdminScreen(),
    analytics(),
    ordered_admin_screen()
  ];

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          // analytics
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
                    child: const Icon(Icons.analytics_outlined),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('Business',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : Colors.black)),
                  )
                ],
              ),
              label: ''),

          // orders
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
                    child: const Icon(Icons.all_inbox_outlined),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text('Orders',
                        style: TextStyle(
                            fontSize: font_size,
                            color: _page == 2
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
