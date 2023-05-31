import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../components/widgets/product_widget.dart';
import '../../view_model/app_cubit/appCubit.dart';
import '../../view_model/app_cubit/appStates.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Favourites"),
            ),
            body: ListView.builder(
                itemCount: cubit.favourites.length,
                itemBuilder: (context, i) {
                  return ProductWidget(
                                source: i,
                                index : i,
                                widget: 
                               ElevatedButton(
                                  onPressed: () {
                                    cubit.removeFromFavourites(i);
                                  },
                                  child: Text("Remove")));
                  // return myProductWidget(
                  //     context,
                  //     i,
                  //     cubit.favourites,
                      
                }),
          );
        });
  }
}
