import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosomat/view_model/admin_cubit/admin_cubit.dart';
import '../../../components/components.dart';
import '../../../components/widgets/product_widget.dart';
import '../../customerView/productdetails.dart';

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Remove Products",
              ),
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
                            child: ProductWidget(
                                source: snapshot.data,
                                index : i,
                                widget: 
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.deleteProduct(context, snapshot.data[i]['name']);
                                  },
                                  child: Text("Remove Product"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                )),
                            onTap: () {
                              myPushNavigator(
                                  context,
                                  ProductDetails(
                                    productName: snapshot.data[i]['name'],
                                    productNewPrice: snapshot.data[i]
                                        ['newPrice'],
                                    productOldPrice: snapshot.data[i]
                                        ['oldPrice'],
                                    discount: snapshot.data[i]['discount'],
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
