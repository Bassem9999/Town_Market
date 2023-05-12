import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../components/components.dart';
import '../view/customerView/home.dart';
import 'appStates.dart';

class ShopCubit extends Cubit<ShopsStates> {
  ShopCubit() : super(NewsIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool loginTap = false;
  bool signupTap = false;
  bool confirmtap = false;
  bool addProductTap = false;
  bool updateProductTap = false;
  bool deleteProductTap = false;
  bool orderDeliveredTap = false;
  bool isvisible = true;
  int size = 3;
  List<Map> orders = [];
  List ordersNames = [];
  List ordersQuantities = [];
  List favourites = [];
  List favouritesNames = [];
  double price = 0;
  bool tapped = false;
  bool? source;
  dynamic file;
  String? imageName;
  List searchList = [];
  Map<String, dynamic>? paymentIntend;
  String SECRET_KEY =
      'sk_test_51MBhHVL3KQvWUvzkzMt5PZnQ5Z8fRfJQSBKZDAUTg8MbUvxSw8xjUr59liDrOQ7AXytUwLpgQxufygHpu8tWASgq0081IgYGyM';
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  getSearch() async {
    await _firestore.collection('products').get().then((value) {
      for (var item in value.docs) {
        searchList.add(item.data()['name']);
      }
      print(searchList);
    });
  }

  showImagesource(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text(
                  "Choose image source",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      child: const Text("Camera"),
                      onPressed: () {
                        source = true;
                        emit(GetImageState());
                        pickImage(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                    )),
                    const SizedBox(
                      width: 70,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      child: const Text("Gallary"),
                      onPressed: () {
                        source = false;
                        emit(GetImageState());
                        pickImage(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                    )),
                  ],
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          );
        });
  }

  pickImage(context) async {
    final myFile;
    if (source == true) {
      myFile = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      myFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    file = File(myFile.path);
    imageName = myFile.path.split('/').last;
    print(
        "$imageName +hellooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    emit(GetImageState());
    Navigator.pop(context);
  }

  chooseSize(index) {
    size = index;
    emit(ChooseSizeState());
  }

  visibility() {
    isvisible = !isvisible;
    emit(PasswordVisibilityState());
  }

  login(context) async {
    var currentData = formstatelogin.currentState;
    currentData!.save();
    if (currentData.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      loginTap = true;
      emit(LoginLoadingState());
      await _auth
          .signInWithEmailAndPassword(
              email: loginemail.text.trim(),
              password: loginpassword.text.trim())
          .then((value) {
        myPushNavigator(context, HomePage());
        loginTap = false;
        preferences.setBool('loginStatus', true);
        print(preferences.getBool('loginStatus'));
        emit(LoginNotLoadingState());
        print("success");
      }).catchError((onError) {
        loginTap = false;
        emit(LoginNotLoadingState());
        print(onError.toString());
        showdialog(context, "Some thing went Wrong", null, Colors.black);
      });
    }
  }

  signUp(context) async {
    var currentData = formstatesignup.currentState;
    currentData!.save();
    if (currentData.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      signupTap = true;
      emit(SignUpLoadingState());
      await _auth
          .createUserWithEmailAndPassword(
              email: createemail.text.trim(),
              password: createpassword.text.trim())
          .then((value) {
        myPushNavigator(context, HomePage());
        signupTap = false;
        preferences.setBool('loginStatus', true);
        emit(SignUpNotLoadingState());
        print("success");
      }).catchError((onError) {
        signupTap = false;
        emit(SignUpNotLoadingState());
        print(onError.toString());
        showdialog(context, "Email not valid", null, Colors.white);
      });
    }
  }

  droplist() {
    return Padding(
      padding:
          const EdgeInsets.only(right: 200.0, top: 10, bottom: 20, left: 10),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(30),
        value: category,
        hint: const Text(
          'Category',
          style: TextStyle(color: Colors.white),
        ),
        dropdownColor: const Color.fromARGB(255, 109, 109, 109),
        items: categories.map((item) {
          return DropdownMenuItem(
              value: item,
              child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(item,
                      style: const TextStyle(
                        color: Colors.white,
                      ))));
        }).toList(),
        onChanged: (String? prov) {
          category = prov;
          emit(DroplistState());
        },
      ),
    );
  }

  void addProduct(context) async {
    var formData = formstateAddProduct.currentState;
    formData!.save();
    if (formData.validate()) {
      addProductTap = true;
      emit(AddProductState());
      int _old = int.parse(oldPriceController.text);
      int _new = int.parse(newPriceController.text);
      double discount = 100 - _new / _old * 100;
      String image64 = '';
      if (file != null) {
        Uint8List imagepytes = await file!.readAsBytes();
        image64 = base64Encode(imagepytes);
      }
      await _firestore
          .collection('products')
          .doc(productNameController.text)
          .set({
        'name': productNameController.text,
        'newPrice': newPriceController.text,
        'oldPrice': oldPriceController.text,
        'discount': discount.ceil().toString(),
        'imageUrl': image64,
        'category': category,
        'time': DateTime.now()
      }).then((value) {
        productNameController.text = '';
        newPriceController.text = '';
        oldPriceController.text = '';
        file = null;
        addProductTap = false;
        snackbar(context, "Item was added successfully");
        emit(AddProductState());
        print("success");
      });
    }
  }

  void updateProduct(context, name, image, category) async {
    var formData = formstateUpdateProduct.currentState;
    formData!.save();
    if (formData.validate()) {
      updateProductTap = true;
      emit(UpdateProductState());
      int _old = int.parse(oldPriceController.text);
      int _new = int.parse(newPriceController.text);
      double discount = 100 - _new / _old * 100;
      String image64 = '';
      if (file != null) {
        Uint8List imagepytes = await file!.readAsBytes();
        image64 = base64Encode(imagepytes);
      } else {
        image64 = image;
      }
      await _firestore.collection('products').doc(name).set({
        'name': name,
        'newPrice': newPriceController.text,
        'oldPrice': oldPriceController.text,
        'discount': discount.ceil().toString(),
        'imageUrl': image64,
        'category': category,
        'time': DateTime.now()
      }).then((value) {
        productNameController.text = '';
        newPriceController.text = '';
        oldPriceController.text = '';
        file = null;
        updateProductTap = false;
        snackbar(context, "Item was Updated successfully");
        emit(UpdateProductState());
        print("success");
      });
    }
  }

  deleteProduct(context, String document) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text(
                  "Are you sure you want to Remove this Item?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 30),
                          backgroundColor: Colors.orange),
                    )),
                    const Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          deleteProductTap = true;
                          emit(DeleteProductState());
                          await _firestore
                              .collection('products')
                              .doc(document)
                              .delete()
                              .then((value) {
                            print("success");
                          });
                          deleteProductTap = false;
                          Navigator.pop(context);
                          snackbar(context, "Item was Deleted successfully");
                          emit(DeleteProductState());
                        },
                        child: deleteProductTap
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4,
                                )))
                            : const Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 30),
                            backgroundColor: Colors.orange),
                      ),
                    ),
                  ],
                )
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          );
        });
  }

  decodeImage(String decodedImage) {
    Uint8List image_64 = base64Decode(decodedImage);
    Image image = Image.memory(
      image_64,
      fit: BoxFit.cover,
    );
    return image;
  }

  addtoCart(productName, newPrice, oldPrice, discount, imageUrl) {
    orders.add({
      'name': productName,
      'newPrice': newPrice,
      'oldPrice': oldPrice,
      'discount': discount,
      'imageUrl': imageUrl,
    });
    ordersNames.add(productName);
    ordersQuantities.add(1);
    price = price + int.parse(newPrice);
    emit(AddtoCartState());
    print(orders);
  }

  removeFromCart(i) {
    price = price - int.parse(orders[i]['newPrice']) * ordersQuantities[i];
    orders.removeAt(i);
    ordersNames.removeAt(i);
    ordersQuantities.removeAt(i);
    emit(RemovefromCartState());
  }

  increaseQuantity(i) {
    ordersQuantities[i] = ordersQuantities[i] + 1;
    price = price + int.parse(orders[i]['newPrice']);
    emit(IncreaseQuantityState());
  }

  decreaseQuantity(i) {
    if (ordersQuantities[i] != 1) {
      ordersQuantities[i] = ordersQuantities[i] - 1;
      price = price - int.parse(orders[i]['newPrice']);
      emit(DecreaseQuantityState());
    }
  }

  addtoFavourites(dataSource, i) {
    favourites.add({
      'name': dataSource[i]['name'],
      'newPrice': dataSource[i]['newPrice'],
      'oldPrice': dataSource[i]['oldPrice'],
      'discount': dataSource[i]['discount'],
      'imageUrl': dataSource[i]['imageUrl'],
    });
    favouritesNames.add(dataSource[i]['name']);
    emit(AddtoFavouritesState());
    print(orders);
  }

  removeFromFavourites(i) {
    favourites.removeAt(i);
    favouritesNames.removeAt(i);
    emit(RemovefromFavouritesState());
  }

  getdata(String collection) async {
    var data = await _firestore.collection(collection).get();
    // var data = await _firestore.collection(collection).orderBy('time',descending: true).get();
    return data.docs;
  }

  getFilteredData(category) async {
    var data = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();
    return data.docs;
  }

  getOrderdData(collection) async {
    var data = await _firestore
        .collection(collection)
        .orderBy('time', descending: true)
        .get();
    return data.docs;
  }

  Future postData(
      String collection, Map<String, dynamic> mydata, String p_name) async {
    await _firestore.collection(collection).doc(p_name).set(mydata);
  }

  Future addData(String collection, Map<String, dynamic> mydata) async {
    await _firestore.collection(collection).add(mydata);
  }

  goToMap(double latitude, double longitude) async {
    String locationUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final urlEncode = Uri.encodeFull(locationUrl);
    // ignore: deprecated_member_use
    return await launch(urlEncode);
  }

  calculateAmount(String amount) {
    final calAmount = (int.parse(amount)) * 100;
    return calAmount.toString();
  }

  createPayment(String amount, String currency) async {
    try {
      Map data = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var url = 'https://api.stripe.com/v1/payment_intents';
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content_Type': 'application/x-www-form-urlencoded'
        },
      );
      var responsebody = jsonDecode(response.body);
      print(responsebody.toString());
      return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  Future makePaidOrder(String amount, context) async {
    var formData = formstateconfirmOrder.currentState;
    formData!.save();
    if (formData.validate()) {
      confirmtap = true;
      emit(ConfirmOrderState());
      try {
        paymentIntend = await createPayment(amount, 'USD');
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntend!['client_secret'],
                // applePay: PaymentSheetApplePay(merchantCountryCode: '+92'),
                // googlePay: PaymentSheetGooglePay(testEnv: true,currencyCode: "US",merchantCountryCode: )
                appearance: const PaymentSheetAppearance(
                  colors: PaymentSheetAppearanceColors(
                      background: Color.fromARGB(255, 68, 68, 68),
                      // componentText: Colors.white,
                      // primary: Colors.white,
                      componentBackground: Colors.black,
                      componentBorder: Colors.teal,
                      primaryText: Colors.white,
                      componentDivider: Colors.teal,
                      componentText: Colors.white,
                      placeholderText: Colors.grey,
                      icon: Colors.white,
                      secondaryText: Colors.white),
                ),
                style: ThemeMode.light,
                merchantDisplayName: 'Bassem'));
        confirmtap = false;
        emit(ConfirmOrderState());
        await Stripe.instance.presentPaymentSheet().then((value) {
          postData(
            'orders',
            {
              'id': email.text + ordersNames.toString(),
              'name': name.text,
              'address': address.text,
              'mobile': mobile.text,
              'email': email.text,
              'totalPrice': price.toString(),
              'order': ordersNames.toString(),
              'quantity': ordersQuantities.toString(),
              'paymentStatus': "Paid",
              'time': DateTime.now().toString()
            },
            email.text + ordersNames.toString(),
          ).then((value) {
            name.text = "";
            address.text = "";
            mobile.text = "";
            email.text = "";
            orders.clear();
            ordersNames.clear();
            ordersQuantities.clear();

            price = 0;
            confirmtap = false;
            emit(ConfirmOrderState());
            myReplaceNavigator(context, HomePage());
            return snackbar(context, "Your Order was submitted successfully");
          });
        });
      } catch (e) {
        print(e.toString() + "failed");
        confirmtap = false;
        showdialog(context, "Error Has been Occured!!", null, Colors.black);
        emit(ConfirmOrderState());
      }
    }
  }

  makeUnpaidOrder(context) {
    var formData = formstateconfirmOrder.currentState;
    formData!.save();
    if (formData.validate()) {
      confirmtap = true;
      emit(ConfirmOrderState());
      postData(
        'orders',
        {
          'id': email.text + ordersNames.toString(),
          'name': name.text,
          'address': address.text,
          'mobile': mobile.text,
          'email': email.text,
          'totalPrice': price.toString(),
          'order': ordersNames.toString(),
          'quantity': ordersQuantities.toString(),
          'paymentStatus': "UnPaid",
          'time': DateTime.now().toString()
        },
        email.text + ordersNames.toString(),
      ).then((value) {
        name.text = "";
        address.text = "";
        mobile.text = "";
        email.text = "";
        orders.clear();
        ordersNames.clear();
        ordersQuantities.clear();
        price = 0;
        confirmtap = false;
        emit(ConfirmOrderState());
        myReplaceNavigator(context, HomePage());
        return snackbar(context, "Your Order was submitted successfully");
      }).catchError((e) {
        confirmtap = false;
        showdialog(context, "Some thing went Wrong", null, Colors.black);
        emit(ConfirmOrderState());
      });
    }
  }

  orderDelivered(context, Map<String, dynamic> data, docId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text(
                  "Are you sure you want to Remove this order ?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 30),
                          backgroundColor: Colors.teal),
                    )),
                    const Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          orderDeliveredTap = true;
                          emit(OrderDeliveredState());
                          await postData('sales', data, data['id']);
                          await _firestore
                              .collection('orders')
                              .doc(docId)
                              .delete()
                              .then((value) {
                            print("success");
                          }).then((value) {
                            orderDeliveredTap = false;
                            Navigator.pop(context);
                            snackbar(context, "Order Delivered");
                            emit(OrderDeliveredState());
                          });
                        },
                        child: orderDeliveredTap
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4,
                                )))
                            : const Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 30),
                            backgroundColor: Colors.teal),
                      ),
                    ),
                  ],
                )
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          );
        });
    // orderDeliveredTap = true;
    // emit(OrderDeliveredState());
    // // addData('sales', data).then((value) {
    // _firestore.collection('orders').doc(docId).delete().then((value) {
    //   orderDeliveredTap = false;
    //   showdialog(context, "Order Delivered", null, Colors.green);
    //   emit(OrderDeliveredState());
    //   //   });
    // }).catchError((e) {
    //   orderDeliveredTap = false;
    //   showdialog(context, "Some Thing Wrong Happened", null, Colors.red);
    //   emit(OrderDeliveredState());
    // });
  }

  String? myvalEmail(text) {
    if (text.trim().isEmpty) {
      return "This field mustn't be empty";
    }
    return null;
  }

  String? myvalPhone(text) {
    if (text.trim().isEmpty) {
      return "This field mustn't be empty";
    } else if (text.trim().length < 10) {
      return "Password should be 10 Numbers";
    } else if (text.startsWith(RegExp('05')) == false) {
      return "should starts with 05";
    }
    return null;
  }

  String? myvalConfirmPassword(text) {
    if (text.trim().isEmpty) {
      return "This field mustn't be empty";
    }
    return null;
  }
}
