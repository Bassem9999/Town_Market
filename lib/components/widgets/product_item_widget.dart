import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosomat/components/components.dart';
import 'package:khosomat/view_model/app_cubit/appCubit.dart';
import 'package:khosomat/view_model/app_cubit/appStates.dart';

import '../../model/product_model.dart';
import '../../view/customerView/productdetails.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  var source;
  var index;
  ProductItem({Key? key,required this.source,required this.index}): super(key: key);

  @override
  Widget build(BuildContext context) {
  var cubit = ShopCubit.get(context);
  ProductModel productModel = ProductModel.fromJson(source[index].data());
  return InkWell(
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 59, 59, 59),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Container(
            height: 130,
            width: 120,
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
              Text(source[index]['category'],style: const TextStyle(color: Colors.grey),),
            
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [  
                    Text("${source[index]['newPrice']}\$",style: const TextStyle(fontSize: 17, color: Colors.tealAccent)),
  
                    const SizedBox( width: 30,),
  
                    Text(source[index]['oldPrice'] + " \$",style:
                    const TextStyle(fontSize: 16,color: Colors.grey,decoration: TextDecoration.lineThrough)),
                  ],
                ),
              ),
              SizedBox(width: 170,
                child: BlocConsumer<ShopCubit, ShopsStates>(
                        listener: (context, state) {},
                        builder: (context, state) => Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                    cubit.addtoFavourites(source, index);
                                    print(cubit.favourites.toString());
                                },
                                icon: Icon(cubit.favouritesNames.contains(productModel.productName)? 
                                      Icons.favorite
                                    : Icons.favorite_border,color: Colors.red,size: 20,
                                )),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.ordersNames.contains(
                                          productModel.productName)
                                      ? null
                                      : cubit.addtoCart(
                                          productModel.productName,
                                          productModel.productNewPrice,
                                          productModel
                                              .productOldPrice,
                                          productModel.discount,
                                          productModel.productImage);
                                },
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(fontSize: 12),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.ordersNames
                                            .contains(productModel
                                                .productName)
                                        ? Colors.grey
                                        : Colors.orange)),
                                ],
                              ),
                            )
                     ),
                  ],
                ),
              ],
            ),
          ),
           onTap: () {
                  myPushNavigator(
                      context,
                      ProductDetails(
                        productName: productModel.productName,
                        productNewPrice: productModel.productNewPrice,
                        productOldPrice: productModel.productOldPrice,
                        discount: productModel.discount,
                        productImage: productModel.productImage,
                      ));
                },
        );
  }
}
