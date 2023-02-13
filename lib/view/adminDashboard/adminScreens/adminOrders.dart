import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/order_model.dart';
import '../../../view_model/appCubit.dart';
import '../../../view_model/appStates.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Orders"),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: cubit.getOrderdData('orders'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        OrderModel orderModel =
                            OrderModel.fromJson(snapshot.data[i].data());
                        return Container(
                          height: 270,
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 189, 189, 189),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Name: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                    width: 113,
                                                    child: Text(
                                                      '${orderModel.customerName}',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Phone: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                    width: 110,
                                                    child: Text(
                                                        '${orderModel.customerPhone}')),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Address: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                    width: 105,
                                                    child: Text(
                                                        '${orderModel.customerAddress}')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Order: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      '${orderModel.order}',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Quantity: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text('${orderModel.quantity}'),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "time: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                        '${orderModel.time}')),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Total Price: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                    width: 90,
                                                    child: Text(
                                                        '${orderModel.totalPrice}')),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  '${orderModel.paymentStatus}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          '${orderModel.paymentStatus}' ==
                                                                  "Paid"
                                                              ? const Color
                                                                      .fromRGBO(
                                                                  26,
                                                                  106,
                                                                  172,
                                                                  1)
                                                              : Colors
                                                                  .redAccent),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 120, vertical: 5),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                cubit.orderDelivered(
                                                    context,
                                                    {
                                                      'id': orderModel.id,
                                                      'name': orderModel
                                                          .customerName,
                                                      'address': orderModel
                                                          .customerAddress,
                                                      'mobile': orderModel
                                                          .customerPhone,
                                                      'totalPrice':
                                                          orderModel.totalPrice,
                                                      'order': orderModel.order,
                                                      'quantity':
                                                          orderModel.quantity,
                                                      'paymentStatus':
                                                          orderModel
                                                              .paymentStatus,
                                                      'time': DateTime.now()
                                                          .toString(),
                                                      'status': "Delivered"
                                                    },
                                                    orderModel.id);
                                              },
                                              child: const Icon(
                                                Icons.delivery_dining_outlined,
                                                size: 30,
                                              )),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        });
  }
}
