import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/product.dart';
import 'package:flutter/material.dart';

class OrderedProducts extends StatefulWidget {
  OrderedProducts({super.key, required this.product, required this.quantity});
  Product product;
  var quantity;

  @override
  State<OrderedProducts> createState() => _OrderedProductsState();
}

class _OrderedProductsState extends State<OrderedProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.product.images[0],
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 130,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
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
                      width: 235,
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 10),
                      child: Text(
                        "\$${widget.product.price}",
                        style: TextStyle(
                            fontSize: 16,
                            color: GlobalVariables.selectedNavBarColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 10),
                      child: Text(
                        "Qty: ${widget.quantity}",
                        style: TextStyle(
                            fontSize: 14,
                            color: GlobalVariables.selectedNavBarColor,
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
    ;
  }
}
