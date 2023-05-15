import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:khosomat/view/customerView/products.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import '../../components/components.dart';
import '../../view/customerView/home.dart';
import 'appStates.dart';

class ShopCubit extends Cubit<ShopsStates> {
  ShopCubit() : super(NewsIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  
  bool confirmtap = false;
  
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
  String SECRET_KEY = 'sk_test_51MBhHVL3KQvWUvzkzMt5PZnQ5Z8fRfJQSBKZDAUTg8MbUvxSw8xjUr59liDrOQ7AXytUwLpgQxufygHpu8tWASgq0081IgYGyM';
  final _firestore = FirebaseFirestore.instance;
  final fbm = FirebaseMessaging.instance;

  getSearch() async {
    await _firestore.collection('products').get().then((value) {
      for (var item in value.docs) {
        searchList.add(item.data()['name']);
      }
      print(searchList);
    });
  }

  showToken(){
    fbm.getToken().then((value){
      print("===================   $value   ===================");
    });
  //  print(token.);
  }

  showNotifications(context){
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(" ============ ${event.notification!.title} ===========");
      myPushNavigator(context, Products());
     });
   
  }

  showInialNotifications(context)async{
    var message = await fbm.getInitialMessage();
     if(message != null){
      myPushNavigator(context, Products());
     }
   
  }

   getNotifications(){
    FirebaseMessaging.onMessage.listen((event) { 
      print("======================");
      print(event.notification?.body);
      print("======================");
    });
  }

  sendNotification(String title, String body,String id)async{
    var serverKey = "AAAA0YnwaBQ:APA91bEnjVwwyweyT5CyxITYOVi0e1dPy0IlrZfybUZYhd42h0hiAIOT6PBB7Wxlrm-D6QrT0S55IarJVzJ2STwk3j88YN2iDs-2Y4ZePTmV2tSQTuIUQfM_ij7v7vvctPPLkt_KNyxe";
    var data = jsonEncode({
      'notification' : {'body' : body, 'title' : title},
      'priority' : 'high',
      'data' : {'click_action' : 'FLUTTER_NOTIFICATION_CLICK', 'id' : id, 'name' : 'bassem'},
      'to' : await fbm.getToken()
      });
    var url = 'https://fcm.googleapis.com/fcm/send';

    await http.post(Uri.parse(url), body: data, headers: {'Content-Type' : 'application/json', 'Authorization' : 'key-$serverKey'}).then((value) {
      print(value.body.toString());
    });
  }


  showImagesource(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text("Choose image source",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                const SizedBox(height: 10,),
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

  

}