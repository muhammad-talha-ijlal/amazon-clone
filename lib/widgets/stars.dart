import 'package:amazonclone/const/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class rating_app extends StatefulWidget {
  const rating_app({super.key, required this.rating});
  final double rating;

  @override
  State<rating_app> createState() => _rating_appState();
}

class _rating_appState extends State<rating_app> {
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
                color: GlobalVariables.secondaryColor,
              )),
    );
  }
}
