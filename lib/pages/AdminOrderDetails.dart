import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/model/Order.dart';
import 'package:amazonclone/pages/OrderDetail.dart';
import 'package:amazonclone/services/AdminService.dart';
import 'package:flutter/material.dart';

class AdminOrderDetails extends StatefulWidget {
  const AdminOrderDetails({super.key});

  @override
  State<AdminOrderDetails> createState() => _ordered_admin_screenState();
}

class _ordered_admin_screenState extends State<AdminOrderDetails> {
  List<Order>? orders = [];
  final AdminService serv = AdminService();
  bool isLoading = true;

  fetchOrders() async {
    orders = await serv.fetchorderedProdcuts(context);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          flexibleSpace: Container(
            // flexible space is used to give gradient color
            decoration:
                const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 6),
                        child: Image.asset(
                          "images/amazon.png",
                          width: 120,
                          height: 45,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: isLoading
                ? Container(
                    height: 300,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: GlobalVariables.SecondaryColor,
                      ),
                    ),
                  )
                : orders!.isEmpty
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
                    : GridView.builder(
                        physics:
                            NeverScrollableScrollPhysics(), // otherwise it will not scroll
                        scrollDirection: Axis.vertical,
                        itemCount: orders!.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // how many products in rows side thing
                          crossAxisCount: 2, mainAxisExtent: 320,
                        ),
                        itemBuilder: (context, index) {
                          Order order = orders![index];

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: GlobalVariables.SelectedNavBarColor
                                          .withOpacity(0.3),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        order.products[0].images[0],
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.50,
                                        height: 130,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      order.products[0].name,
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0, left: 10),
                                    child: Text(
                                      "\$${order.totalPrice.toInt()}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: GlobalVariables
                                              .SelectedNavBarColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0, left: 10),
                                    child: Text(
                                      order.status == 0
                                          ? "Ordered"
                                          : order.status == 1
                                              ? "Dispatched"
                                              : order.status == 2
                                                  ? "Out For Delivery"
                                                  : "Delivered",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: GlobalVariables
                                                  .UnselectedNavBarColor
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      decoration: const BoxDecoration(
                                          border: BorderDirectional(
                                              top: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1.5))),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, OrderDetails.routeName,
                                              arguments: order);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7, top: 3, left: 45),
                                          child: Text(
                                            "Order Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: GlobalVariables
                                                    .SelectedNavBarColor),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }),
          )
        ],
      ),
    );
  }
}
