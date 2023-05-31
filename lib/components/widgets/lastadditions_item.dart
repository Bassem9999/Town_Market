import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosomat/model/product_model.dart';

import '../../view/customerView/productdetails.dart';
import '../../view_model/app_cubit/appCubit.dart';
import '../../view_model/app_cubit/appStates.dart';
import '../components.dart';

// ignore: must_be_immutable
class LastAdditionsItem extends StatelessWidget {
  ProductModel productModel;
  LastAdditionsItem({Key? key,required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return InkWell(
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(232, 51, 51, 51),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      height: 80,
                      width: 145,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(30),
                          image: DecorationImage(image: cubit.decodeImage( "${productModel.productImage}").image,fit: BoxFit.contain)),
                    ),

                    "${productModel.discount}" != '0'?
                      Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius:BorderRadius.circular(40)),
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text("Off",style: TextStyle(color: Colors.white,fontSize: 11)),
                            Text("${productModel.discount}" '%',style: const TextStyle(color: Colors.white)),
                          ],
                        )),
                      )
                    : const Text("")
              ],
            ),
            Column(
              crossAxisAlignment:CrossAxisAlignment.end,
              children: [

                Container(
                  width: 180,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20,top: 10,bottom: 3),
                  child: Text( productModel.productName.toString(),maxLines: 2,
                          style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("${productModel.productNewPrice} \$",style: const TextStyle( fontSize: 16,color: Colors.tealAccent))),
                       "${productModel.discount}" != '0'
                          ? Expanded(
                              child: Text(
                                "${productModel.productOldPrice}",style: const TextStyle(fontSize: 15,decoration:TextDecoration.lineThrough, color: Colors.grey),),)
                           : const Text(""),
                
                      BlocBuilder<ShopCubit, ShopsStates>(
                        builder: (context, state) {
                        return InkWell(
                          child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: cubit.ordersNames.contains("${productModel.productName}")
                                      ? Colors.grey
                                      : Colors.orange,
                                  borderRadius:BorderRadius.circular(30)),
                
                              child: Icon(Icons.add),    
                              ),
                          onTap: () {
                                cubit.ordersNames.contains("${productModel.productName}")
                                    ? null
                                    : cubit.addtoCart(
                                        "${productModel.productName}",
                                        "${productModel.productNewPrice}",
                                        "${productModel.productOldPrice}",
                                        "${productModel.discount}",
                                        "${productModel.productImage}");
                              },                
                        );
                              })     
                    ],
                  ),
                ),
              
              ],
            ),
          ]),
        ),
        onTap: () {
          myPushNavigator(
              context,
              ProductDetails(
                productName:
                    "${productModel.productName}",
                productNewPrice:
                    "${productModel.productNewPrice}",
                productOldPrice:
                    "${productModel.productOldPrice}",
                discount: "${productModel.discount}",
                productImage:
                    "${productModel.productImage}",
              ));
            },
          );
  }
}