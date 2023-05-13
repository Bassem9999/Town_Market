import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosomat/view_model/admin_cubit/admin_cubit.dart';
import '../../../model/sales_history_model.dart';


class SalesHistory extends StatelessWidget {
  const SalesHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Sales History"),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: cubit.getOrderdData('sales'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        SalesModel salesModel =
                            SalesModel.fromJson(snapshot.data[i].data());
                        return Container(
                          height: 270,
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 158, 156, 156),
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
                                                      '${salesModel.customerName}',
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
                                                        '${salesModel.customerPhone}')),
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
                                                        '${salesModel.customerAddress}')),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Shipping Status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  '${salesModel.status}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          26, 106, 172, 1)),
                                                ),
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
                                                      '${salesModel.order}',
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
                                                Text('${salesModel.quantity}'),
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
                                                        '${salesModel.time}')),
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
                                                        '${salesModel.totalPrice}')),
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
                                                  '${salesModel.paymentStatus}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          '${salesModel.paymentStatus}' ==
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
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //           flex: 1,
                              //           child: Container(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 120, vertical: 5),
                              //             child: ElevatedButton(
                              //                 onPressed: () {},
                              //                 child: const Icon(
                              //                   Icons.delivery_dining_outlined,
                              //                   size: 30,
                              //                 )),
                              //           ))
                              //     ],
                              //   ),
                              // )
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
