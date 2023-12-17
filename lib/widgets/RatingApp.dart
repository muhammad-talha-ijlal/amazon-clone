import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingApp extends StatefulWidget {
  const RatingApp({super.key, required this.rating});
  final double rating;

  @override
  State<RatingApp> createState() => _RatingAppState();
}

class _RatingAppState extends State<RatingApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBarIndicator(
          direction: Axis.horizontal,
          itemCount: 5,
          rating: widget.rating,
          itemSize: 18,
          itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.SecondaryColor,
              )),
    );
  }
}
