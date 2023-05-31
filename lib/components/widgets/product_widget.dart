import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosomat/view_model/app_cubit/appCubit.dart';
import 'package:khosomat/view_model/app_cubit/appStates.dart';

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  var source;
  var index;
  Widget? widget;
  ProductWidget({Key? key,required this.source,required this.index,required this.widget}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopsStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 59, 59, 59),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              Container(
                height: 130,
                width: 130,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: cubit.decodeImage(source[index]['imageUrl']).image,
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      source[index]['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    source[index]['category'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        //  Text("Price : "),

                        Text(source[index]['newPrice'] + " \$",
                            style: const TextStyle(
                                fontSize: 17, color: Colors.tealAccent)),

                        const SizedBox(
                          width: 30,
                        ),

                        Text(
                          source[index]['oldPrice'] + " \$",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 170, child: widget),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
