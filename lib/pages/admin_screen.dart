import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/main.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/pages/add_product_Screen.dart';
import 'package:amazonclone/pages/admin_product.dart';
import 'package:amazonclone/services/admin_services.dart';
import 'package:amazonclone/widgets/top_button.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final adminServices serv = adminServices();

// other method to to tackle with the future builder
  List<Product> product_list = [];

  bool isLoading = true;

  void getAllProducts() async {
    product_list = await serv.fetchAllproduct(context);
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
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
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
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
                      gradient: GlobalVariables.appBarGradient),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 6),
                        child: Image.asset(
                          "images/amazon_in.png",
                          width: 120,
                          height: 45,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await serv.turnUser(context: context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            'Admin',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
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
                    height: 180,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                  )
                : product_list.isEmpty
                    ? Opacity(
                        opacity: 0.4,
                        child: Container(
                          height: 650,
                          child: Center(
                              child: Image.asset(
                            "images/amazon_in.png",
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
                        itemCount: product_list.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // how many products in rows side thing
                          crossAxisCount: 2, mainAxisExtent: 320,
                        ),
                        itemBuilder: (context, index) {
                          Product product = product_list[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: GlobalVariables.selectedNavBarColor
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
                                        product.images[0],
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
                                      product.name,
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0, left: 10),
                                    child: Text(
                                      "\$${product.price}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: GlobalVariables
                                              .selectedNavBarColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 10),
                                        child: product.quantity == 0.0
                                            ? const Text(
                                                "Out Of Stock",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(
                                                "Available ${product.quantity.toString().split(".")[0]}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          adminServices adm = adminServices();
                                          bool check = await adm.deleteProduct(
                                              context: context,
                                              product: product,
                                              onSuccess: () {});

                                          if (check) {
                                            product_list.removeAt(index);
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, right: 10),
                                          child: Icon(
                                            Icons.delete,
                                            color: GlobalVariables
                                                .secondaryColor
                                                .withOpacity(0.91),
                                            size: 22,
                                          ),
                                        ),
                                      )
                                    ],
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      adminProductShow(
                                                          product: product)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 7, top: 3, left: 45),
                                          child: Text(
                                            "View Product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: GlobalVariables
                                                    .selectedNavBarColor),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, add_product_screen.routeName);
        },
        elevation: 0,
        tooltip: 'Add a product', // gives a message on long tap
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
