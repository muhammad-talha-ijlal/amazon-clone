import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/main.dart';
import 'package:amazonclone/model/order.dart';
import 'package:amazonclone/pages/auth_screen.dart';
import 'package:amazonclone/pages/myorder.dart';
import 'package:amazonclone/pages/searched_product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/services/home_services.dart';
import 'package:amazonclone/services/services_auth.dart';
import 'package:amazonclone/widgets/order.dart';
import 'package:amazonclone/widgets/searched_product.dart';
import 'package:amazonclone/widgets/top_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

// order contains data of a particular checkout where prouducts have multiple elements as similar for quantity but in order horizontal direction we only show first name of the child

class _AccountScreenState extends State<AccountScreen> {
  home_back_services hm = home_back_services();
  auth_service sv = auth_service();
  // temporary list
  List<Order> orderlist = [];

  void getMyOrder() async {
    orderlist = await hm.fetchMyOrders(context: context);
    setState(() {
      print(orderlist.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          flexibleSpace: Container(
            // flexible space is used to give gradient color
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(5, 8, 3, 2),
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          "images/amazon_in.png",
                          width: 120,
                          height: 45,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: RichText(
                        text: TextSpan(
                            text: 'Hello, ',
                            style: const TextStyle(
                                fontSize: 22, color: Colors.black),
                            children: [
                          TextSpan(
                              text: user.name,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600))
                        ])),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TopButton(
                        name: "Your Orders",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => orderAll()));
                        }),
                    TopButton(
                        name: "Turn Seller",
                        onTap: () async {
                          await sv.turnSeller(context: context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        })
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TopButton(
                        name: "Log out",
                        onTap: () {
                          sv.logout(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, AuthScreen.routeName, (route) => false);
                        }),
                    TopButton(
                        name: "Your Wishlist",
                        onTap: () {
                          Navigator.pushNamed(context, SearchedScreen.routeName,
                              arguments: "");
                        })
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "Your Orders",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => orderAll()));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          "See all",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: GlobalVariables.selectedNavBarColor),
                        ),
                      ),
                    ),
                  ],
                ),

                // list view builder to display our products orders
                Container(
                  height: 300,
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                  child: ListView.builder(
                      itemCount: orderlist.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return OrderProduct(
                            order: orderlist[index],
                            src: orderlist[index].products[0].images[0],
                            name: orderlist[index].products[0].name,
                            status: orderlist[index].status == 0
                                ? "Ordered"
                                : orderlist[index].status == 1
                                    ? "Dispatched"
                                    : orderlist[index].status == 2
                                        ? "Out For Delivery"
                                        : "Delivered");
                      })),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
