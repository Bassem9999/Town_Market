import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/components.dart';
import '../../components/utils/controllers.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);

    final _firestore = FirebaseFirestore.instance;


  bool? source;
  dynamic file;
  String? imageName;
  bool addProductTap = false;
  bool updateProductTap = false;
  bool deleteProductTap = false;
  bool orderDeliveredTap = false;

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

  decodeImage(String decodedImage) {
    Uint8List image_64 = base64Decode(decodedImage);
    Image image = Image.memory(
      image_64,
      fit: BoxFit.cover,
    );
    return image;
  }


   getdata(String collection) async {
    var data = await _firestore.collection(collection).get();
    // var data = await _firestore.collection(collection).orderBy('time',descending: true).get();
    return data.docs;
  }

  getOrderdData(collection) async {
    var data = await _firestore
        .collection(collection)
        .orderBy('time', descending: true)
        .get();
    return data.docs;
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
    var formData = Controllers.formstateAddProduct.currentState;
    formData!.save();
    if (formData.validate()) {
      addProductTap = true;
      emit(AddProductState());
      int _old = int.parse(Controllers.oldPriceController.text);
      int _new = int.parse(Controllers.newPriceController.text);
      double discount = 100 - _new / _old * 100;
      String image64 = '';
      if (file != null) {
        Uint8List imagepytes = await file!.readAsBytes();
        image64 = base64Encode(imagepytes);
      }
      await _firestore
          .collection('products')
          .doc(Controllers.productNameController.text)
          .set({
        'name': Controllers.productNameController.text,
        'newPrice': Controllers.newPriceController.text,
        'oldPrice': Controllers.oldPriceController.text,
        'discount': discount.ceil().toString(),
        'imageUrl': image64,
        'category': category,
        'time': DateTime.now()
      }).then((value) {
        Controllers.productNameController.text = '';
        Controllers.newPriceController.text = '';
        Controllers.oldPriceController.text = '';
        file = null;
        addProductTap = false;
        snackbar(context, "Item was added successfully");
        emit(AddProductState());
        print("success");
      });
    }
  }

  void updateProduct(context, name, image, category) async {
    var formData = Controllers.formstateUpdateProduct.currentState;
    formData!.save();
    if (formData.validate()) {
      updateProductTap = true;
      emit(UpdateProductState());
      int _old = int.parse(Controllers.oldPriceController.text);
      int _new = int.parse(Controllers.newPriceController.text);
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
        'newPrice': Controllers.newPriceController.text,
        'oldPrice': Controllers.oldPriceController.text,
        'discount': discount.ceil().toString(),
        'imageUrl': image64,
        'category': category,
        'time': DateTime.now()
      }).then((value) {
        Controllers.productNameController.text = '';
        Controllers.newPriceController.text = '';
        Controllers.oldPriceController.text = '';
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
                       //   await postData('sales', data, data['id']);
                          await _firestore.collection('orders').doc(docId).delete().then((value) {
                            orderDeliveredTap = false;
                            Navigator.pop(context);
                            snackbar(context, "Order Delivered");
                            emit(OrderDeliveredState());
                          });
                        },
                        child: orderDeliveredTap? Container(
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
  }


  
}
