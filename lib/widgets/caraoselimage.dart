import 'package:amazonclone/const/global_var.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class carouselImages extends StatefulWidget {
  const carouselImages({super.key});

  @override
  State<carouselImages> createState() => _carouselImagesState();
}

class _carouselImagesState extends State<carouselImages> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((e) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              e,
              fit: BoxFit.cover,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }).toList(), // return list of widgets
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1, // fraction of veiport occupied
            height: 200));
  }
}
