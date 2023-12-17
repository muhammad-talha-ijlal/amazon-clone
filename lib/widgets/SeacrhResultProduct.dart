import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/widgets/RatingApp.dart';
import 'package:flutter/material.dart';

class SeacrhResultProduct extends StatefulWidget {
  const SeacrhResultProduct({super.key, required this.product});
  final Product product;

  @override
  State<SeacrhResultProduct> createState() => _SeacrhResultProductState();
}

class _SeacrhResultProductState extends State<SeacrhResultProduct> {
  @override
  Widget build(BuildContext context) {
    double totalrating = 0;
    double avgRating = 0;
    for (var i = 0; i < widget.product.rating!.length; i++) {
      totalrating += widget.product.rating![i].rating;
    }

    if (totalrating != 0) {
      avgRating = totalrating / widget.product.rating!.length;
    }
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
                      width: 200,
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 0, left: 10),
                        child: RatingApp(rating: avgRating)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 10),
                      child: Text(
                        "\$${widget.product.price}",
                        style: TextStyle(
                            fontSize: 18,
                            color: GlobalVariables.SelectedNavBarColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, left: 10),
                          child: widget.product.quantity == 0.0
                              ? const Text(
                                  "Out Of Stock",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                )
                              : const Text(
                                  "In Stock",
                                  style: TextStyle(
                                      fontSize: 18,
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
                            fontSize: 16,
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
