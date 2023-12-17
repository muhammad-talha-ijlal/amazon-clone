import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/providers/userproviders.dart';
import 'package:amazonclone/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cart_product extends StatefulWidget {
  cart_product({super.key, required this.index});

  final int index;

  @override
  State<cart_product> createState() => _cart_productState();
}

class _cart_productState extends State<cart_product> {
  final ProductDetailsServices serv = ProductDetailsServices();
  void increaseQuantity(Product product) {
    serv.addCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    serv.removeFromProduct(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
                  color: Colors.black54.withOpacity(0.3), width: 1.0))),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.images[0],
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: 130,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black12),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    decreaseQuantity(product);
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 28,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                      border: Border.all(
                                          color: Colors.black12, width: 1.5)),
                                  child: Container(
                                      width: 28,
                                      height: 28,
                                      alignment: Alignment.center,
                                      child: Text(
                                        quantity.toString(),
                                        style: TextStyle(),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    increaseQuantity(product);
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 200,
                      child: Text(
                        product.name,
                        style: const TextStyle(fontSize: 20),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 10),
                      child: Text(
                        "\$${product.price}",
                        style: TextStyle(
                            fontSize: 20,
                            color: GlobalVariables.selectedNavBarColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, left: 10),
                          child: product.quantity == 0.0
                              ? const Text(
                                  "Out Of Stock",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                )
                              : const Text(
                                  "In Stock",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 10),
                      child: Text(
                        "Eligible for Free Shipping",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
