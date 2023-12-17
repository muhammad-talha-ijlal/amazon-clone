import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/order.dart';
import 'package:amazonclone/services/home_services.dart';
import 'package:amazonclone/widgets/order.dart';
import 'package:flutter/material.dart';

class orderAll extends StatefulWidget {
  const orderAll({
    super.key,
  });

  @override
  State<orderAll> createState() => _orderAllState();
}

class _orderAllState extends State<orderAll> {
  List<Order> orderList = [];
  home_back_services serv = home_back_services();
  bool isLoading = true;

  void fetchcatproducts() async {
    orderList = await serv.fetchMyOrders(
      context: context,
    );
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
          preferredSize: const Size.fromHeight(40),
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
                      gradient: GlobalVariables.appBarGradient),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My Orders",
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
                    child: isLoading
                        ? Container(
                            height: 180,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                          )
                        : orderList.isEmpty
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
                            : GridView.builder(
                                physics:
                                    NeverScrollableScrollPhysics(), // otherwise it will not scroll
                                scrollDirection: Axis.vertical,
                                itemCount: orderList.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  // how many products in rows side thing
                                  crossAxisCount: 2, mainAxisExtent: 300,
                                ),
                                itemBuilder: (context, index) {
                                  Order order = orderList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OrderProduct(
                                        src: order.products[0].images[0],
                                        name: order.products[0].name,
                                        status: order.status == 0
                                            ? "Ordered"
                                            : order.status == 1
                                                ? "Dispatched"
                                                : order.status == 2
                                                    ? "Out For Delivery"
                                                    : "Delivered",
                                        order: order),
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
