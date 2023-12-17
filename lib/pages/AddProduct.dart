import 'dart:io';

import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/const/Snackbar.dart';
import 'package:amazonclone/widgets/CustomButton.dart';
import 'package:amazonclone/widgets/CustomField.dart';
import 'package:amazonclone/services/AdminService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

// to pick images from gallery
Future<List<File>> pickImages() async {
  List<File> images = []; // multiple product images will get selected

  try {
    // version 4.5.1
    var files_var = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (files_var != null && files_var.files.isNotEmpty) {
      for (var i = 0; i < files_var.files.length; i++) {
        images.add(File(files_var.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const String routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _add_product_screenState();
}

class _add_product_screenState extends State<AddProductScreen> {
  final AdminService admin = AdminService();
  final Formkey = GlobalKey<FormState>();
  TextEditingController productNameControl = TextEditingController();
  TextEditingController descrpControl = TextEditingController();
  TextEditingController priceControl = TextEditingController();
  TextEditingController quantityControl = TextEditingController();

  // we get the images from a future function so if at start iamges will be empty so selected bool worked but after one click on selected Future builder get activated
  late Future<List<File>> images;

  String current_cat = "Mobiles";

  List<String> productCategory = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];

  List<File> img_sent = [];

  bool selected = false;
  bool selling = false;

  @override
  Widget build(BuildContext context) {
    void dispose() {
      productNameControl.dispose();
      descrpControl.dispose();
      priceControl.dispose();
      quantityControl.dispose();
    }

    void sellProduct() {
      if (Formkey.currentState!.validate() && img_sent.isNotEmpty) {
        selling = true;
        setState(() {});
        admin.sellproduct(
            context: context,
            name: productNameControl.text,
            description: descrpControl.text,
            price: double.parse(priceControl.text),
            quantity: double.parse(quantityControl.text),
            category: current_cat,
            images: img_sent);
      }

      if (img_sent.isEmpty) {
        Snackbar(context, "Product images must");
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          flexibleSpace: Container(
            // flexible space is used to give gradient color
            decoration:
                const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            pinned: true,
            toolbarHeight: 50,
            flexibleSpace: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.only(top: 5),
                  height: 50,
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.AppBarGradient),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'Add Product',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // scrollable part of the page
          SliverToBoxAdapter(
            child: selling
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: GlobalVariables.SelectedNavBarColor,
                      ),
                    ),
                  )
                : Form(
                    key: Formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              var res = pickImages(); // function to pick images

                              setState(() {
                                images = res;
                                selected = true;
                              });
                            },
                            child: selected
                                ? FutureBuilder<List<File>>(
                                    future: images,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Display a loading indicator while waiting for the Future to complete
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        // Display an error message if the Future completes with an error
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        // Display the data from the Future
                                        List<File> data = snapshot.data!;
                                        img_sent =
                                            data; // list to sent to auth services

                                        return data.isEmpty
                                            ? DottedBorder(
                                                // if the user clicked the selected photos but dont select anyone
                                                borderType: BorderType.RRect,
                                                radius:
                                                    const Radius.circular(10),
                                                dashPattern: const [10, 4],
                                                strokeCap: StrokeCap.round,
                                                strokeWidth: 2.4,
                                                color: Colors.grey.shade500,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.folder_open,
                                                          size: 40,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          'Select Product Images',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors.grey
                                                                  .shade400,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                            : CarouselSlider(
                                                // selected images
                                                items: data.map((e) {
                                                  return Builder(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.file(
                                                          e,
                                                          fit: BoxFit.scaleDown,
                                                          height: 200,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(), // return list of widgets
                                                options: CarouselOptions(
                                                    autoPlay: true,
                                                    viewportFraction:
                                                        1, // fraction of veiport occupied
                                                    height: 200));
                                      }
                                    })
                                : DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    dashPattern: const [10, 4],
                                    strokeCap: StrokeCap.round,
                                    strokeWidth: 2.4,
                                    color: Colors.grey.shade500,
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.folder_open,
                                              size: 40,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Select Product Images',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade400,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomField(
                              controller: productNameControl,
                              hint: "Product Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomField(
                            controller: descrpControl,
                            hint: "Description",
                            maxlines: 7,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomField(controller: priceControl, hint: "Price"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomField(
                              controller: quantityControl, hint: "Quantity"),
                          SizedBox(
                              width: double.infinity,
                              child: DropdownButton(
                                // to have ad
                                onChanged: (changevalue) {
                                  // when value get change what to do function
                                  setState(() {
                                    current_cat = changevalue.toString();
                                  });
                                },
                                value: current_cat, // current value
                                icon: const Icon(Icons
                                    .keyboard_arrow_down), // icons to show Droupdoown butoon
                                items: productCategory.map((item) {
                                  // this requires a list so first we iterate it and return menu item
                                  return DropdownMenuItem(
                                      value: item, child: Text(item));
                                }).toList(),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          selling
                              ? Container()
                              : CustomButton(
                                  text: 'Sell',
                                  onTap: () {
                                    sellProduct();
                                  }),
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
