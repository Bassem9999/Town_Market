import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';

class ProductDetails extends StatelessWidget {
  final productName;
  final productNewPrice;
  final productOldPrice;
  final discount;
  final productImage;
  ProductDetails(
      {required this.productName,
      required this.productNewPrice,
      required this.productOldPrice,
      required this.discount,
      required this.productImage});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Info"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: cubit.decodeImage(productImage)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              productName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Size",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          BlocConsumer<ShopCubit, ShopsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: CircleAvatar(
                          child: const Text('S'),
                          backgroundColor: cubit.size == 0
                              ? Colors.teal
                              : const Color.fromARGB(255, 68, 68, 68),
                        ),
                        onTap: () {
                          cubit.chooseSize(0);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: CircleAvatar(
                          child: const Text('M'),
                          backgroundColor: cubit.size == 1
                              ? Colors.teal
                              : const Color.fromARGB(255, 68, 68, 68),
                        ),
                        onTap: () {
                          cubit.chooseSize(1);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: CircleAvatar(
                          child: const Text('L'),
                          backgroundColor: cubit.size == 2
                              ? Colors.teal
                              : const Color.fromARGB(255, 68, 68, 68),
                        ),
                        onTap: () {
                          cubit.chooseSize(2);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: CircleAvatar(
                          child: const Text('XL'),
                          backgroundColor: cubit.size == 3
                              ? Colors.teal
                              : const Color.fromARGB(255, 68, 68, 68),
                        ),
                        onTap: () {
                          cubit.chooseSize(3);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: CircleAvatar(
                          child: const Text('XXL'),
                          backgroundColor: cubit.size == 4
                              ? Colors.teal
                              : const Color.fromARGB(255, 68, 68, 68),
                        ),
                        onTap: () {
                          cubit.chooseSize(4);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  productNewPrice + " \$",
                  style: const TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              BlocConsumer<ShopCubit, ShopsStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        cubit.ordersNames.contains(productName)
                            ? null
                            : cubit.addtoCart(productName, productNewPrice,
                                productOldPrice, discount, productImage);
                      },
                      child: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                              color: cubit.ordersNames.contains(productName)
                                  ? Colors.grey
                                  : Colors.orange,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: Text(
                            "Add to Card",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ))),
                    );
                  }),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
