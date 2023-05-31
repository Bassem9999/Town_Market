import 'package:flutter/material.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import '../../components/components.dart';
import '../../components/widgets/lastadditions_item.dart';
import '../../components/widgets/mydrawer_widget.dart';
import '../../model/product_model.dart';
import '../../view_model/app_cubit/appCubit.dart';

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
          drawer: const MyDrawer(),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     cubit.sendNotification("test", "Hello", "1");
          //  // print("kjfjjjp");
          //   },
          // ),
          body: CustomScrollView(
            
            slivers: [
             SliverToBoxAdapter(
              child:  Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                  child: Carousel(
                    dotBgColor: Colors.black12,
                    dotSize: 7,
                    dotIncreasedColor: Colors.black,
                    images: [
                      Image.asset("images/clothes shop background9.jpg",fit: BoxFit.cover,),
                      Image.asset("images/clothes shop background2.jpg",fit: BoxFit.cover,),
                      Image.asset("images/clothes shop background3.jpg",fit: BoxFit.cover,),
                      Image.asset("images/clothes shop background7.jpg",fit: BoxFit.cover,),
                      Image.asset("images/clothes shop background5.jpg",fit: BoxFit.cover,),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20, left: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text("Categories",style: TextStyle(fontSize: 22, color: Colors.white),)),
          
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      myCategoryWidget(context, "Suits", 'images/suit.jpg', 'suits'),
                      myCategoryWidget(context, "Dresses", 'images/dress.jpg', 'dresses'),
                      myCategoryWidget(context, "Jackets", 'images/jacket.jpg', 'jackets'),
                      myCategoryWidget(context, "Shirts", 'images/shirts.jpg', 'shirts'),
                      myCategoryWidget(context, "Jeans", 'images/jeans.jpg', 'jeans'),
                      myCategoryWidget(context, "T-Shirts", 'images/t-shirt.jpg', 'tshirts'),
                      myCategoryWidget(context, "Blouzes", 'images/blouze.jpg', 'blouzes'),
                      myCategoryWidget(context, "Accessories",'images/accessories2.jpg', 'accessories'),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: const Text("Last Additions",style: TextStyle(fontSize: 22, color: Colors.white))),
              ],
            ),
             ),

             SliverToBoxAdapter(
              child: FutureBuilder(
                  future: cubit.getdata('products'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            ProductModel productModel = ProductModel.fromJson(snapshot.data[i].data());
                            
                            return LastAdditionsItem(productModel: productModel,);
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
