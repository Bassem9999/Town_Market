import 'package:flutter/material.dart';
import 'package:khosomat/view/customerView/payment.dart';
import '../../components/components.dart';
import '../../components/utils/controllers.dart';
import 'myCart.dart';

class ConfirmOrdersPage extends StatelessWidget {
  const ConfirmOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Form(
              key: Controllers.formstateconfirmOrder,
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            myReplaceNavigator(context, const CartScreen());
                          },
                        )),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Your Information",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 560,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        myTextField("Real Name", Icons.person, const Icon(null),() {}, Controllers.name, false, myvalEmail),
                        SizedBox(height: 10,),
                        myTextField("Mobile Number", Icons.phone_android,const Icon(null), () {}, Controllers.mobile, false, myvalEmail),
                        SizedBox(height: 10,),
                        myTextField("Email", Icons.email_outlined,const Icon(null), () {}, Controllers.email, false, myvalEmail),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: Controllers.address,
                            validator: myvalEmail,
                            maxLines: 3,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.65),
                                label: Text("Detailed Address"),
                                labelStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.home_outlined,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ),
                        ),
                        //  myTextField("Address", Icons.house_outlined, const Icon(null), (){}, address, false, myvalEmail),
                      //  const Spacer(),
                        const SizedBox(
                          height: 20,
                        ),

                         InkWell(
                           child: Container(
                             height: 60,
                             width: 250,
                             decoration: BoxDecoration(color: Colors.teal, borderRadius:BorderRadius.circular(30)),
                             child: const Center( child: Text("Go to Payment",style: TextStyle(color: Colors.white,fontSize: 20))),
                           ),
                           onTap: () {
                            var formData = Controllers.formstateconfirmOrder.currentState;
                            formData!.save();
                            if (formData.validate()) {
                            myPushNavigator(context, const PaymentPage());
                            }
                           },
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
