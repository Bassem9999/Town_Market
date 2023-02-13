import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';
import 'adminScreens/add.dart';
import 'adminScreens/adminOrders.dart';
import 'adminScreens/remove.dart';
import 'adminScreens/sales_history.dart';
import 'adminScreens/update.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            //   appBar: AppBar(title: const Text("Admin Dashboard"),centerTitle: true,),
            body: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello Bassem",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Welcom Back !",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      myAdminDashboardWidget(
                        context,
                        Colors.tealAccent,
                        const SalesHistory(),
                        Column(
                          children: const [
                            Icon(
                              Icons.archive_outlined,
                              size: 100,
                            ),
                            Text(
                              "Sales",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      myAdminDashboardWidget(
                        context,
                        const Color.fromARGB(255, 205, 179, 212),
                        const AdminOrders(),
                        Column(
                          children: const [
                            Icon(
                              Icons.monetization_on_outlined,
                              size: 100,
                            ),
                            Text(
                              "Revenu",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      myAdminDashboardWidget(
                        context,
                        const Color.fromARGB(255, 211, 218, 113),
                        const AdminOrders(),
                        Column(
                          children: const [
                            Icon(
                              Icons.shopping_cart_checkout_sharp,
                              size: 100,
                            ),
                            Text(
                              "Orders",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      myAdminDashboardWidget(
                        context,
                        const Color.fromARGB(255, 137, 202, 131),
                        const Insert(),
                        Column(
                          children: const [
                            Icon(
                              Icons.add_circle_outline_rounded,
                              size: 100,
                            ),
                            Text(
                              "Add Product",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      myAdminDashboardWidget(
                        context,
                        const Color.fromARGB(255, 166, 197, 223),
                        const UpdateProduct(),
                        Column(
                          children: const [
                            Icon(
                              Icons.update_rounded,
                              size: 100,
                            ),
                            Text(
                              "Update Product",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      myAdminDashboardWidget(
                        context,
                        const Color.fromARGB(255, 223, 166, 166),
                        const DeleteProduct(),
                        Column(
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              size: 100,
                            ),
                            Text(
                              "Remove Product",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
