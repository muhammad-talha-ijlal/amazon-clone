import 'package:amazonclone/const/GlobalVariables.dart';

import 'package:amazonclone/pages/Category.dart';

import 'package:amazonclone/widgets/CarouselImages.dart';
import 'package:amazonclone/widgets/DealOfDay.dart';
import 'package:flutter/material.dart';

class CustomScroll extends StatefulWidget {
  const CustomScroll({super.key});

  @override
  State<CustomScroll> createState() => _CustomScrollState();
}

class _CustomScrollState extends State<CustomScroll> {
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
                    itemCount: GlobalVariables.CategoryImages.length,
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
                                      .CategoryImages[index]['title']
                                      .toString());
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  GlobalVariables.CategoryImages[index]['image']
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
                            GlobalVariables.CategoryImages[index]['title']
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
            const CarouselImages(),
            const DealOfDay(),
          ],
        )
      ],
    );
  }
}
