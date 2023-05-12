// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../model/product_model.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';
import 'myCart.dart';
import 'productdetails.dart';

// ignore: must_be_immutable
class Products extends StatelessWidget {
  bool? filter;
  String? category;
  Products({this.filter, this.category});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      drawer: myDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: filter == true
                  ? cubit.getFilteredData(category)
                  : cubit.getdata('products'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        ProductModel productModel =
                            ProductModel.fromJson(snapshot.data[i].data());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: myProductWidget(
                                context,
                                i,
                                snapshot.data,
                                BlocConsumer<ShopCubit, ShopsStates>(
                                  listener: (context, state) {},
                                  builder: (context, state) => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            cubit.favouritesNames.contains(
                                                    productModel.productName)
                                                ? cubit.removeFromFavourites(i)
                                                : cubit.addtoFavourites(
                                                    snapshot.data, i);
                                            print(cubit.favourites.toString());
                                          },
                                          icon: Icon(
                                            cubit.favouritesNames.contains(
                                                    productModel.productName)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                            size: 20,
                                          )),
                                      Spacer(),
                                      ElevatedButton(
                                          onPressed: () {
                                            cubit.ordersNames.contains(
                                                    productModel.productName)
                                                ? null
                                                : cubit.addtoCart(
                                                    productModel.productName,
                                                    productModel
                                                        .productNewPrice,
                                                    productModel
                                                        .productOldPrice,
                                                    productModel.discount,
                                                    productModel.productImage);
                                          },
                                          child: Text(
                                            "Add to cart",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: cubit.ordersNames
                                                      .contains(productModel
                                                          .productName)
                                                  ? Colors.grey
                                                  : Colors.orange)),
                                    ],
                                  ),
                                )),
                            onTap: () {
                              myPushNavigator(
                                  context,
                                  ProductDetails(
                                    productName: productModel.productName,
                                    productNewPrice:
                                        productModel.productNewPrice,
                                    productOldPrice:
                                        productModel.productOldPrice,
                                    discount: productModel.discount,
                                    productImage: productModel.productImage,
                                  ));
                            },
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.tealAccent),
                  );
                }
              },
            ),
          ),
          BlocConsumer<ShopCubit, ShopsStates>(
            listener: (context, state) {},
            builder: (context, state) => ElevatedButton(
              onPressed: () {
                cubit.orders.isEmpty
                    ? null
                    : myPushNavigator(context, CartScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart_checkout),
                  SizedBox(
                    width: 5,
                  ),
                  Text("My Cart"),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 40),
                  backgroundColor:
                      cubit.orders.isEmpty ? Colors.grey : Colors.orange),
            ),
          )
        ],
      ),
    );
  }
}
