import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/components.dart';
import '../../../view_model/appCubit.dart';
import '../../../view_model/appStates.dart';

class Insert extends StatelessWidget {
  const Insert({Key? key}) : super(key: key);

  //  void filter()async{
  //   await _firestore.collection('products').where('name', isEqualTo: name.text).get().then(((value) {
  //     print(value.docs[0].data());
  //   }));

  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add new Product",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            body: Form(
              key: formstateAddProduct,
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          child: Container(
                            height: 170,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: cubit.file == null
                                        ? Icon(
                                            Icons.photo_camera_outlined,
                                            size: 120,
                                            color: Color.fromARGB(
                                                242, 233, 227, 227),
                                          )
                                        : Image.file(
                                            cubit.file,
                                            scale: 2,
                                          )),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.showImagesource(context);
                                      },
                                      child: const Text("Add Picture",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // decoration: BoxDecoration(
                            //   border: Border.all(width: 5),
                            //   borderRadius: BorderRadius.circular(20)
                            // ),
                          ),
                          onTap: () {
                            cubit.showImagesource(context);
                          },
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                  adminTextfield(productNameController, 'name'),
                  adminTextfield(newPriceController, 'newPrice'),
                  adminTextfield(oldPriceController, 'oldPrice'),
                  cubit.droplist(),
                  ElevatedButton(
                    onPressed: () {
                      cubit.addProduct(context);
                    },
                    child: cubit.addProductTap
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 152, vertical: 10),
                            child: Center(
                                child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4.2,
                            )))
                        : const Text('Add this product'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 40),
                        backgroundColor: Colors.orange),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
