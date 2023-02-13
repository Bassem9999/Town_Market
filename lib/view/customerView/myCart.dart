// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';
import 'confirmOrder.dart';
import 'products.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              // appBar: AppBar(title: Text("My Orders"),),
              drawer: myDrawer(context),

              body: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myPushNavigator(
                                context,
                                Products(
                                  filter: false,
                                  category: null,
                                ));
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "My Cart",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cubit.orders.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color.fromARGB(255, 59, 59, 59),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 130,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: cubit
                                                  .decodeImage(cubit.orders[i]
                                                      ['imageUrl'])
                                                  .image,
                                              fit: BoxFit.fill),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                " " + cubit.orders[i]['name'],
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  cubit.orders[i]['newPrice'] +
                                                      " \$",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.tealAccent)),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                cubit.orders[i]['oldPrice'] +
                                                    " \$",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "  Discount : " +
                                              cubit.orders[i]['discount'] +
                                              " %",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    // padding: EdgeInsets.only(bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.tealAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                  Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                cubit.decreaseQuantity(i);
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "${cubit.ordersQuantities[i]}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            InkWell(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.tealAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                  Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                cubit.increaseQuantity(i);
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                cubit.removeFromCart(i);
                                              },
                                              child: Text(
                                                "Remove",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange,
                                                  fixedSize: Size(80, 30)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          myPushNavigator(context, ConfirmOrdersPage());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.payments_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Confirm Orders"),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 40),
                            backgroundColor: Colors.orange),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        cubit.price.toString() + " USD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
