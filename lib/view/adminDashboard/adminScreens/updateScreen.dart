import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../../view_model/appCubit.dart';
import '../../../view_model/appStates.dart';

class UpdateScreen extends StatelessWidget {
  final productName;
  final productOldPrice;
  final productNewPrice;
  final productCategory;
  final productImage;
  UpdateScreen(
      {this.productName,
      this.productOldPrice,
      this.productNewPrice,
      this.productCategory,
      this.productImage});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formstateUpdateProduct,
              child: ListView(
                children: [
                  Container(
                      height: 340,
                      padding: EdgeInsets.all(10),
                      child: cubit.file == null
                          ? cubit.decodeImage(productImage)
                          : Image.file(cubit.file)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.showImagesource(context);
                      },
                      child: Text(
                        "Update Picture",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(fixedSize: Size(100, 40)),
                    ),
                  ),

                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Product old price : ",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: oldPriceController,
                          validator: myvalEmail,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: productOldPrice,
                              hintStyle: TextStyle(color: Colors.grey)),
                          //initialValue: widget.productOldPrice,
                        ),
                      ),
                      const Text(
                        " \$",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Product new price : ",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: newPriceController,
                          validator: myvalEmail,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: productNewPrice,
                              hintStyle: TextStyle(color: Colors.grey)),
                          // initialValue: widget.productNewPrice,
                        ),
                      ),
                      const Text(
                        " \$",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Product Description : ",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  // SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      height: 130,
                      child: TextFormField(
                        //   initialValue: widget.productName,
                        maxLines: 4,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      cubit.updateProduct(
                          context, productName, productImage, productCategory);
                    },
                    child: cubit.updateProductTap
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 152, vertical: 10),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4.2,
                            ))
                        : const Text("Update"),
                    style: ElevatedButton.styleFrom(fixedSize: Size(300, 40)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
