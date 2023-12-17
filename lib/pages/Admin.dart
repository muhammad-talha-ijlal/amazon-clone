import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/main.dart';
import 'package:amazonclone/model/Product.dart';
import 'package:amazonclone/pages/AddProduct.dart';
import 'package:amazonclone/pages/AdminProduct.dart';
import 'package:amazonclone/services/AdminService.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AdminService serv = AdminService();

// other method to to tackle with the future builder
  List<Product> productList = [];

  bool isLoading = true;

  void getAllProducts() async {
    productList = await serv.fetchAllproduct(context);
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
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
                      GestureDetector(
                        onTap: () async {
                          await serv.turnUser(context: context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()));
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
                        color: GlobalVariables.SecondaryColor,
                      ),
                    ),
                  )
                : productList.isEmpty
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
                        itemCount: productList.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // how many products in rows side thing
                          crossAxisCount: 2, mainAxisExtent: 320,
                        ),
                        itemBuilder: (context, index) {
                          Product product = productList[index];
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
                                              .SelectedNavBarColor,
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
                                          AdminService adm = AdminService();
                                          bool check = await adm.deleteProduct(
                                              context: context,
                                              product: product,
                                              onSuccess: () {});

                                          if (check) {
                                            productList.removeAt(index);
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, right: 10),
                                          child: Icon(
                                            Icons.delete,
                                            color:
                                                GlobalVariables.SecondaryColor
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
                                                      AdminProductScreen(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
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
