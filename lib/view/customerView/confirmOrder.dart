import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';
import 'myCart.dart';

class ConfirmOrdersPage extends StatelessWidget {
  const ConfirmOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            body: Form(
              key: formstateconfirmOrder,
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            myReplaceNavigator(context, const CartScreen());
                          },
                        )),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Your Information",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 530,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        myTextField("Real Name", Icons.person, const Icon(null),
                            () {}, name, false, myvalEmail),
                        const Spacer(),
                        myTextField("Mobile Number", Icons.phone_android,
                            const Icon(null), () {}, mobile, false, myvalEmail),
                        const Spacer(),
                        myTextField("Email", Icons.email_outlined,
                            const Icon(null), () {}, email, false, myvalEmail),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: address,
                            validator: cubit.myvalEmail,
                            maxLines: 3,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.65),
                                label: Text("Detailed Address"),
                                labelStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.home_outlined,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ),
                        ),
                        //  myTextField("Address", Icons.house_outlined, const Icon(null), (){}, address, false, myvalEmail),
                        const Spacer(),
                        const SizedBox(
                          height: 20,
                        ),

                        cubit.confirmtap
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 4.5,
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        cubit.makeUnpaidOrder(context);
                                      },
                                      child: Container(
                                        child: const Center(
                                            child: Text(
                                          "Pay Later",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        )),
                                        height: 50,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        cubit.makePaidOrder(
                                            cubit.price.ceil().toString(),
                                            context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 140,
                                        child: const Center(
                                            child: Text(
                                          "Pay Now",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
