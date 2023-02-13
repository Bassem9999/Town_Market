import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../model/product_model.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';
import 'productdetails.dart';
import 'search.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Town Market'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: Search(searchData: cubit.searchList));
            },
          ),
        ],
      ),
      drawer: myDrawer(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     cubit.getId();
      //   },
      // ),
      body: ListView(
        children: [
          SizedBox(
            height: 170,
            child: Carousel(
              dotBgColor: Colors.black12,
              dotSize: 7,
              dotIncreasedColor: Colors.black,
              images: [
                Image.asset(
                  "images/clothes shop background9.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/clothes shop background2.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/clothes shop background3.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/clothes shop background7.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/clothes shop background5.jpg",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 20, left: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Categories",
                style: TextStyle(fontSize: 22, color: Colors.white),
              )),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                myCategoryWidget(context, "Suits", 'images/suit.jpg', 'suits'),
                myCategoryWidget(
                    context, "Dresses", 'images/dress.jpg', 'dresses'),
                myCategoryWidget(
                    context, "Jackets", 'images/jacket.jpg', 'jackets'),
                myCategoryWidget(
                    context, "Shirts", 'images/shirts.jpg', 'shirts'),
                myCategoryWidget(context, "Jeans", 'images/jeans.jpg', 'jeans'),
                myCategoryWidget(
                    context, "T-Shirts", 'images/t-shirt.jpg', 'tshirts'),
                myCategoryWidget(
                    context, "Blouzes", 'images/blouze.jpg', 'blouzes'),
                myCategoryWidget(context, "Accessories",
                    'images/accessories2.jpg', 'accessories'),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Products ",
                style: TextStyle(fontSize: 22, color: Colors.white),
              )),
          SizedBox(
            height: 500,
            child: FutureBuilder(
                future: cubit.getdata('products'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          ProductModel productModel =
                              ProductModel.fromJson(snapshot.data[i].data());
                          return InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(232, 51, 51, 51),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 145,
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: DecorationImage(
                                              image: cubit
                                                  .decodeImage(
                                                      "${productModel.productImage}")
                                                  .image,
                                              fit: BoxFit.contain)),
                                    ),
                                    "${productModel.discount}" != '0'
                                        ? Container(
                                            height: 48,
                                            width: 48,
                                            decoration: BoxDecoration(
                                                color: Colors.teal,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                                child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                const Text("Discount",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11)),
                                                Text(
                                                    "${productModel.discount}" +
                                                        '%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            )),
                                          )
                                        : const Text("")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Text(
                                                productModel.productName
                                                    .toString(),
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "${productModel.productNewPrice}" +
                                                    " \$",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.tealAccent)),
                                          ),
                                          "${productModel.discount}" != '0'
                                              ? Expanded(
                                                  child: Text(
                                                    "${productModel.productOldPrice}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              : const Text(""),
                                        ],
                                      ),
                                    ),
                                    BlocConsumer<ShopCubit, ShopsStates>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          return Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: cubit.ordersNames.contains(
                                                          "${productModel.productName}")
                                                      ? Colors.grey
                                                      : Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: TextButton(
                                                  onPressed: () {
                                                    cubit.ordersNames.contains(
                                                            "${productModel.productName}")
                                                        ? null
                                                        : cubit.addtoCart(
                                                            "${productModel.productName}",
                                                            "${productModel.productNewPrice}",
                                                            "${productModel.productOldPrice}",
                                                            "${productModel.discount}",
                                                            "${productModel.productImage}");
                                                  },
                                                  child: const Text(
                                                    "Add to Cart",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        })
                                  ],
                                ),
                              ]),
                            ),
                            onTap: () {
                              myPushNavigator(
                                  context,
                                  ProductDetails(
                                    productName: "${productModel.productName}",
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
                        });
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.tealAccent));
                  }
                }),
          )
        ],
      ),
    );
  }
}
