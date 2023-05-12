import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/components.dart';
import '../../../view_model/app_cubit/appCubit.dart';
import '../../../view_model/app_cubit/appStates.dart';
import 'updateScreen.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Products"),
            ),
            body: FutureBuilder(
              future: cubit.getdata('products'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: myProductWidget(
                                context, i, snapshot.data, null),
                            onTap: () {
                              myPushNavigator(
                                  context,
                                  UpdateScreen(
                                    productName: snapshot.data[i]['name'],
                                    productOldPrice: snapshot.data[i]
                                        ['oldPrice'],
                                    productNewPrice: snapshot.data[i]
                                        ['newPrice'],
                                    productCategory: snapshot.data[i]
                                        ['category'],
                                    productImage: snapshot.data[i]['imageUrl'],
                                  ));
                            },
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.tealAccent),
                  );
                }
              },
            ),
          );
        });
  }
}
