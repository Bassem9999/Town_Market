import 'package:flutter/material.dart';

abstract class Controllers{
  
   static TextEditingController loginemail = TextEditingController();
   static TextEditingController loginpassword = TextEditingController();

   static GlobalKey<FormState> formstatelogin = GlobalKey<FormState>();


   static TextEditingController createemail = TextEditingController();
   static TextEditingController createpassword = TextEditingController();
   static TextEditingController confirmpassword = TextEditingController();

   static GlobalKey<FormState> formstatesignup = GlobalKey<FormState>();


   static TextEditingController name = TextEditingController();
   static TextEditingController address = TextEditingController();
   static TextEditingController mobile = TextEditingController();
   static TextEditingController email = TextEditingController();

   static GlobalKey<FormState> formstateconfirmOrder = GlobalKey<FormState>();


   static TextEditingController productNameController = TextEditingController();
   static TextEditingController newPriceController = TextEditingController();
   static TextEditingController oldPriceController = TextEditingController();

   static GlobalKey<FormState> formstateAddProduct = GlobalKey<FormState>();
   static GlobalKey<FormState> formstateUpdateProduct = GlobalKey<FormState>();
}