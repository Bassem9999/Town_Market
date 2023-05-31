// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../components/widgets/mydrawer_widget.dart';
import '../../components/widgets/product_item_widget.dart';
import '../../model/product_model.dart';
import '../../view_model/app_cubit/appCubit.dart';
import '../../view_model/app_cubit/appStates.dart';
import 'myCart.dart';

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
      drawer: const MyDrawer(), 
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
                        return ProductItem(source: snapshot.data,index: i,);
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
                cubit.orders.isEmpty? null: myPushNavigator(context, CartScreen());
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
