import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/const/snackbar.dart';
import 'package:amazonclone/model/order.dart';
import 'package:amazonclone/pages/searched_product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/services/admin_services.dart';
import 'package:amazonclone/widgets/button.dart';
import 'package:amazonclone/widgets/ordered_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class orderDetails extends StatefulWidget {
  static const String routeName = '/order-details';

  const orderDetails({super.key, required this.order});
  final Order order;

  @override
  State<orderDetails> createState() => _orderDetailsState();
}

class _orderDetailsState extends State<orderDetails> {
  int curr_step = 0;
  void navigateTosearchScreen(String query) {
    Navigator.pushNamed(context, SearchedScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.status <= 3) {
      curr_step = widget.order.status;
    } else {
      curr_step = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          user.type == "admin"
              ? SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  toolbarHeight: 50,
                  automaticallyImplyLeading: false,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  flexibleSpace: Column(
                    children: [
                      Container(
                        // padding: const EdgeInsets.only(top: 5),
                        height: 50,
                        decoration: const BoxDecoration(
                            gradient: GlobalVariables.appBarGradient),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 8, left: 44),
                              child: Image.asset(
                                "images/amazon_in.png",
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
                )
              : SliverAppBar(
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
                            gradient: GlobalVariables.appBarGradient),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 6, 6, 8),
                              width: 350,
                              height: 50,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 1,
                                child: TextFormField(
                                  onFieldSubmitted: navigateTosearchScreen,
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
                                    contentPadding:
                                        const EdgeInsets.only(top: 10),
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
                                        color:
                                            GlobalVariables.selectedNavBarColor,
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
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Order Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date:  ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Order Id:       ${widget.order.id}',
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Order Total:  \$${widget.order.totalPrice}',
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 10, top: 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.order.products.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: OrderedProducts(
                                product: widget.order.products[index],
                                quantity: widget.order.quantity[index]));
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Tracking",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Stepper(
                    physics: NeverScrollableScrollPhysics(),
                    controlsBuilder: (context, details) {
                      return user.type == "admin" && widget.order.status < 3
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: custom_btn(
                                  text: 'Done',
                                  onTap: () async {
                                    // update order
                                    adminServices serv = adminServices();
                                    bool check = await serv.updateOrder(
                                        context: context,
                                        order: widget.order,
                                        status: curr_step + 1);
                                    if (curr_step < 3 && check) {
                                      curr_step++;

                                      setState(() {
                                        snackbar(context, "Order Updated");
                                      });
                                    }
                                  }),
                            )
                          : Container();
                    },
                    currentStep: curr_step,
                    steps: [
                      Step(
                          title: const Text(
                            "Ordered",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: user.type == "admin"
                                ? Container()
                                : Text(
                                    'We got Your order',
                                    style: TextStyle(
                                        color: GlobalVariables
                                            .selectedNavBarColor
                                            .withOpacity(0.8),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                          isActive: curr_step >= 0,
                          state: curr_step >= 0
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: const Text(
                            "Dispatched",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: user.type == "admin"
                                ? Container()
                                : Text(
                                    'On The Way',
                                    style: TextStyle(
                                        color: GlobalVariables
                                            .selectedNavBarColor
                                            .withOpacity(0.8),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                          isActive: curr_step >= 1,
                          state: curr_step >= 1
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: const Text(
                            "Delivering",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: user.type == "admin"
                                ? Container()
                                : Text(
                                    'Out For Delivery',
                                    style: TextStyle(
                                        color: GlobalVariables
                                            .selectedNavBarColor
                                            .withOpacity(0.8),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                          isActive: curr_step >= 2,
                          state: curr_step >= 2
                              ? StepState.complete
                              : StepState.indexed),
                      Step(
                          title: const Text(
                            "Delivered",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          content:
                              user.type == "admin" ? Container() : Container(),
                          isActive: curr_step >= 3,
                          state: curr_step >= 3
                              ? StepState.complete
                              : StepState.indexed),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
