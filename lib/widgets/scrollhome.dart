import 'package:amazonclone/const/global_var.dart';

import 'package:amazonclone/pages/category_deals.dart';

import 'package:amazonclone/widgets/caraoselimage.dart';
import 'package:amazonclone/widgets/dealofday.dart';
import 'package:flutter/material.dart';

class customeScroll extends StatefulWidget {
  const customeScroll({super.key});

  @override
  State<customeScroll> createState() => _customeScrollState();
}

class _customeScrollState extends State<customeScroll> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Container(
                height: 60,
                color: Colors.white,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: GlobalVariables.categoryImages.length,
                    itemExtent: MediaQuery.of(context).size.width *
                        0.2, // extent the list items  evenly
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CategoryScreen.routeName,
                                  arguments: GlobalVariables
                                      .categoryImages[index]['title']
                                      .toString());
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  GlobalVariables.categoryImages[index]['image']
                                      .toString(),
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            GlobalVariables.categoryImages[index]['title']
                                .toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    }))),
            const SizedBox(
              height: 10,
            ),
            const carouselImages(),
            const DealOfDay(),
          ],
        )
      ],
    );
  }
}
