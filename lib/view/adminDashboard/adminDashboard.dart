import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/widgets/dashboard_item_widget.dart';
import '../../view_model/app_cubit/appCubit.dart';
import '../../view_model/app_cubit/appStates.dart';
import 'adminScreens/add.dart';
import 'adminScreens/adminOrders.dart';
import 'adminScreens/remove.dart';
import 'adminScreens/sales_history.dart';
import 'adminScreens/update.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            //   appBar: AppBar(title: const Text("Admin Dashboard"),centerTitle: true,),
            body: Column(
              children: [
                 SizedBox(
                  height: MediaQuery.of(context).size.height * .07,
                ),

                const Text("Admin Dashboard", style: TextStyle( fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold)),
                                       
                 SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text("Hello Bassem", style: TextStyle( fontSize: 22,color: Colors.white,fontWeight: FontWeight.normal))),
                                       
                Container(
                  padding: const EdgeInsets.only(left: 20,top: 5),
                  alignment: Alignment.centerLeft,
                  child: const Text("Welcom Back !",style: TextStyle(color: Colors.grey, fontSize: 15))),
                    
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),

                 Expanded(
                   child: Row(
                     children: [
                       DashboardItem( icon: Icons.archive_outlined,
                                      text: "Salse",
                                      color: Colors.tealAccent,
                                      screen: const SalesHistory()),
                 
                       DashboardItem( icon: Icons.monetization_on_outlined,
                                      text: "Revenu",
                                      color: const Color.fromARGB(255, 205, 179, 212),
                                      screen: const AdminOrders()),
                     ],
                   ),
                 ),               
                

                 Expanded(
                   child: Row(
                     children: [
                       DashboardItem( icon: Icons.shopping_cart_checkout_sharp,
                                      text: "Orders",
                                      color: const Color.fromARGB(255, 211, 218, 113),
                                      screen: const AdminOrders()),
                                 
                       DashboardItem( icon: Icons.add_circle_outline_rounded,
                                      text: "Add Product",
                                      color: const Color.fromARGB(255, 137, 202, 131),
                                      screen: const Insert()),
                     ],
                   ),
                 ),


                 Expanded(
                   child: Row(
                     children: [
                       DashboardItem( icon: Icons.update_rounded,
                                      text: "Update Product",
                                      color: const Color.fromARGB(255, 166, 197, 223),
                                      screen: const UpdateProduct()),
                 
                       DashboardItem( icon: Icons.delete_outline,
                                      text: "Remove Product",
                                      color: const Color.fromARGB(255, 223, 166, 166),
                                      screen: const DeleteProduct()),
                     ],
                   ),
                 ),               
              ],
            ),
          );
        });
  }
}
