import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosomat/view_model/app_cubit/appCubit.dart';
import 'package:khosomat/view_model/app_cubit/appStates.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
      listener: (context, state) {},
      builder: (context, state) {
      var cubit = ShopCubit.get(context);
      return Scaffold(
      appBar: AppBar(title: const Text("Payment"),),
      body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child:  cubit.confirmtap? 
             const CircularProgressIndicator(color: Colors.white,strokeWidth: 4.5,)
            : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Text("Choose the Payment Method",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      width: 230,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 223, 144, 26), borderRadius:BorderRadius.circular(30)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.credit_card,color: Colors.white,size: 70,),
                          SizedBox(height: 20,),
                          Text("Pay with Credit Card",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onTap: () {
                        cubit.makeStripePaidOrder(cubit.price.ceil().toString(), context);
                    },
                  ),
                ),

                Expanded(
                  child: InkWell(
                    child: Container(
                      width: 230,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 57, 25, 165), borderRadius:BorderRadius.circular(30)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.paypal,color: Colors.white,size: 70,),
                          SizedBox(height: 20,),
                          Text("Pay with PayPal",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onTap: () {
                        cubit.makePayPalPaidOrder(context);
                    },
                  ),
                ),

                Expanded(
                  child: InkWell(
                    child: Container(
                      width: 230,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.teal, borderRadius:BorderRadius.circular(30)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money_off,color: Colors.white,size: 70,),
                          SizedBox(height: 20,),
                          Text("Pay Later",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onTap: () {
                        cubit.makeUnpaidOrder(context);
                    },
                  ),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Total Price :  ${cubit.price} \$",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,)))

        ],),
      ),
    );
    });
  }
}