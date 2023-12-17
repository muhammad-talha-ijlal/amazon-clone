import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({super.key});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.CarouselImages.map((e) {
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
