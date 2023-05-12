// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';

// ignore: must_be_immutable
class MarketPage extends StatelessWidget {
  String marketname;
  String address;
  String collection;
  double longitude;
  double latitude;
   MarketPage({Key? key, required this.marketname,required this.address,required this.collection, required this.longitude,required this.latitude }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopsStates>(
      listener: (context, state) {},
      builder: (context, state) {
      var cubit = ShopCubit.get(context);
      return Scaffold(
      appBar: AppBar(),

      body: ListView(
        children: [

          Container(
            height: 200,
            child: Image.asset("images/shop4.jpg",fit: BoxFit.cover,),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(marketname,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),

            Row(
              children: [
                Container(
                padding: EdgeInsets.all(10),
                child: Text("Address: ",style: TextStyle(fontSize: 20,),),),

                SizedBox(width: 30,),

                Container(
                padding: EdgeInsets.all(10),
                child: Text(address,style: TextStyle(fontSize: 20,color:  Colors.deepOrange),),),
              ],
            ),



          ElevatedButton(onPressed: (){ cubit.goToMap(latitude, longitude);},
           child: Text("Location")),

           
          Container(
            padding: EdgeInsets.only(right:15),
            alignment: Alignment.centerRight,
            child: Text(":المنتجات اللتى يقدمها هذا المتجر",style: TextStyle(fontSize: 20),)),

          SizedBox(
            height: 400,
            child: FutureBuilder(
                 future: cubit.getFilteredData(collection),
                 builder: (BuildContext context , AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Card(
                          child: Row(
                            children: [
                      
                              Container(
                                height: 130,
                                width: 130,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(image:  NetworkImage(snapshot.data[i]['imageUrl']),fit: BoxFit.cover,),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                ),
                                
                                SizedBox(width: 20,),
                      
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" "+snapshot.data[i]['name'],
                                  style: TextStyle(fontSize: 18),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text("Price : "),

                                        Text(snapshot.data[i]['newPrice']+ " LE",style: TextStyle(color: Colors.deepOrange)),
                                        
                                        SizedBox(width: 20,),
                                        
                                        Text(snapshot.data[i]['oldPrice'] + " LE",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough),),
                                          
                                       
                                      ],
                                    ),
                                  ),
                                  Text("  Discount : "+snapshot.data[i]['discount']+" %",style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                  }else{
                    return Center(child: CircularProgressIndicator(color: Colors.black),);
                  }
                  
                 },
            ),
          ),
        ],
      ),
    );});
  }
}