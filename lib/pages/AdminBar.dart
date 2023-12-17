import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/pages/AdminOrderDetails.dart';
import 'package:amazonclone/pages/Admin.dart';
import 'package:amazonclone/pages/Analytics.dart';
import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;

class AdminBar extends StatefulWidget {
  const AdminBar({super.key});

  @override
  State<AdminBar> createState() => _bottom_admin_barState();
}

class _bottom_admin_barState extends State<AdminBar> {
  int _page = 0;
  double bottom_width = 42;
  double selectedborder = 3;
  double font_size = 12;

  List<Widget> pages = [const AdminScreen(), Analytics(), AdminOrderDetails()];

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
        selectedItemColor: GlobalVariables.SelectedNavBarColor,
        unselectedItemColor: GlobalVariables.UnselectedNavBarColor,
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
                                    ? GlobalVariables.SelectedNavBarColor
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
                                ? GlobalVariables.SelectedNavBarColor
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
                                    ? GlobalVariables.SelectedNavBarColor
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
                                ? GlobalVariables.SelectedNavBarColor
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
                                    ? GlobalVariables.SelectedNavBarColor
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
                                ? GlobalVariables.SelectedNavBarColor
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
