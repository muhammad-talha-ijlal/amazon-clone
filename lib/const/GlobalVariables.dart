import 'package:flutter/material.dart';

String uri = 'http://192.168.0.110:3000';

class GlobalVariables {
  // COLORS
  static const AppBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const ButtonColor = const Color.fromARGB(223, 254, 180, 19);
  static const SecondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color GreyBackgroundColor = Color(0xffebecee);
  static var SelectedNavBarColor = Colors.cyan[800]!;
  static const UnselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> CarouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> CategoryImages = [
    {
      'title': 'Mobiles',
      'image': 'images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'images/fashion.jpeg',
    },
  ];
}
