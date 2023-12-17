import 'package:amazonclone/const/global_var.dart';
import 'package:amazonclone/model/product.dart';
import 'package:amazonclone/pages/productdetails.dart';
import 'package:amazonclone/services/home_services.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  void bringDealOfDay() async {
    home_back_services serv = home_back_services();
    product = await serv.fetchDealOfDay(context: context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bringDealOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Container(
            height: 400,
            child: Center(
                child: CircularProgressIndicator(
              color: GlobalVariables.selectedNavBarColor,
            )),
          )
        : product!.name.isEmpty
            ? const SizedBox(
                height: 50,
              )
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailScreen.routeName,
                      arguments: product);
                },
                child: Column(children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      )),
                  Image.network(
                    product!.images[0],
                    height: 235,
                    fit: BoxFit.scaleDown,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      '\$${product!.price}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: GlobalVariables.selectedNavBarColor
                              .withOpacity(0.8)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                    child: Text(
                      product!.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product!.images.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 5, top: 10, bottom: 10),
                          child: Center(
                              child: Image.network(
                            e,
                            width: 100,
                            height: 100,
                            fit: BoxFit.scaleDown,
                          )),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15)
                            .copyWith(left: 15, bottom: 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'See All details',
                          style: TextStyle(
                              color: Colors.cyan[800],
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 9,
                        child: Icon(
                          Icons.arrow_right_alt_sharp,
                          color: Colors.cyan[800],
                          size: 25,
                        ),
                      )
                    ],
                  )
                ]),
              );
  }
}
