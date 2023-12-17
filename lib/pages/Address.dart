import 'package:amazonclone/const/GlobalVariables.dart';
import 'package:amazonclone/const/Snackbar.dart';
import 'package:amazonclone/model/Address.dart';
import 'package:amazonclone/providers/UserProvider.dart';
import 'package:amazonclone/services/DatabaseService.dart';
import 'package:amazonclone/widgets/CustomButton.dart';
import 'package:amazonclone/widgets/CustomField.dart';
import 'package:amazonclone/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  AddressScreen({
    super.key,
    required this.isPay,
  });
  static const String routeName = '/address';
  bool isPay = false;

  @override
  State<AddressScreen> createState() => _addressFormState();
}

class _addressFormState extends State<AddressScreen> {
  final TextEditingController flat = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController pinode = TextEditingController();
  final TextEditingController city = TextEditingController();

  final AuthService authServ = AuthService();

  String address = "";

  final address_key = GlobalKey<FormState>();
  String addressToBeUsed = "";

  @override
  void initState() {
    super.initState();
    // Fetch the address from local storage and populate text fields if available
    populateAddressFromLocalStorage();
  }

  void populateAddressFromLocalStorage() async {
    final addresses = await DatabaseService()
        .getEntries(); // Fetch addresses from local storage

    // Check if addresses are available and set the text fields if not empty
    if (addresses.isNotEmpty) {
      address = addresses.first.toString();
    }
  }

  void payFunction(String addressFromtheProvider, double totalSum) {
    addressToBeUsed = "";
    bool isForm = flat.text.isNotEmpty ||
        area.text.isNotEmpty ||
        pinode.text.isNotEmpty ||
        city.text.isNotEmpty;
    if (isForm) {
      if (address_key.currentState!.validate()) {
        addressToBeUsed =
            '${flat.text},${area.text},${city.text} - ${pinode.text}';
        authServ.saveAddress(
            context: context,
            address: '${flat.text},${area.text},${city.text} - ${pinode.text}');
        authServ.orderProduct(
            context: context, address: addressToBeUsed, totalSum: totalSum);
      }
    } else if (addressFromtheProvider.isNotEmpty) {
      addressToBeUsed = addressFromtheProvider;

      authServ.orderProduct(
          context: context, address: addressToBeUsed, totalSum: totalSum);
    } else {
      Snackbar(context, "Please Enter Your Delivery Address");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flat.dispose();
    area.dispose();
    pinode.dispose();
    city.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    if (address.isEmpty) {
      address = context.watch<UserProvider>().user.address;
    }

    num sum = 0;
    user.cart.map(
      (e) {
        sum += e['quantity'] * e['product']['price'];
      },
    ).toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.AppBarGradient),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // disable the Sliver app bar back button
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
            ), // used to the set the back button of the screen
            pinned: true,
            automaticallyImplyLeading: true,
            toolbarHeight: 50,
            flexibleSpace: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.only(top: 5),
                  height: 50,
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.AppBarGradient),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  address.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              child: Text(
                                address,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "No Address Saved",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                  Form(
                      // form requires a key
                      key: address_key,
                      child: Column(
                        children: [
                          CustomField(
                            controller: flat,
                            hint: "Flat,House no,building",
                          ),
                          CustomField(controller: area, hint: "Area, Street"),
                          CustomField(
                            controller: pinode,
                            hint: "Pin Code",
                          ),
                          CustomField(
                            controller: city,
                            hint: "Town/City",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: address.isEmpty
                                  ? "Set My Address"
                                  : "Confirm New Address",
                              onTap: () {
                                // here we check whole form is valid or not if yes sign up user function get runs
                                if (address_key.currentState!.validate()) {
                                  authServ.saveAddress(
                                      context: context,
                                      address:
                                          '${flat.text},${area.text},${city.text} - ${pinode.text}');

                                  DatabaseService().insertEntry(Address(
                                      flat: flat.text,
                                      area: area.text,
                                      city: city.text,
                                      zipCode: pinode.text));
                                }
                              },
                              color: GlobalVariables.ButtonColor),
                          widget.isPay
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: CustomButton(
                                      text: 'Proceed To Pay \$${sum}',
                                      onTap: () {
                                        payFunction(address, sum.toDouble());
                                      },
                                      color: GlobalVariables.ButtonColor),
                                )
                              : Container(),
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
