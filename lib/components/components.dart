// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../animation/animatedRoute.dart';
import '../view/customerView/products.dart';
import '../../../view_model/app_cubit/appCubit.dart';
import 'utils/controllers.dart';



var categories = [
  'suits',
  'dresses',
  'jackets',
  'shirts',
  'jeans',
  'tshirts',
  'blouzes',
  'accessories'
];
String? category;

ShopCubit cubit = ShopCubit();

myTextField(String label, prefex, suffex, action,
    TextEditingController mycontroller, bool isSecure, var myval) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      controller: mycontroller,
      validator: myval,
      obscureText: isSecure,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.65),
        focusColor: Colors.white,
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          prefex,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: suffex,
          onPressed: action,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

adminTextfield(TextEditingController mycontroller, String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: mycontroller,
      validator: myvalEmail,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withOpacity(0.6),
          hintText: text,
          border: OutlineInputBorder(
              //  borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
            color: Colors.white,
          )),
          hintStyle: TextStyle(color: Colors.grey)),
    ),
  );
}

myPushNavigator(context, screen) {
  return Navigator.of(context).push(SlideRoute(page: screen));
}

myReplaceNavigator(context, screen) {
  return Navigator.maybeOf(context)!
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
}

showdialog(context, String text, var content, var color) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          content: content,
          backgroundColor: color,
        );
      });
}

snackbar(context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  ));
}

String? myvalEmail(text) {
  if (text.trim().isEmpty) {
    return "This field mustn't be empty";
  }
  return null;
}

String? myvalPassword(text) {
  if (text.trim().isEmpty) {
    return "This field mustn't be empty";
  } else if (text.trim().length < 8) {
    return "Password should be 8 characters or more";
  }
  return null;
}

String? myvalConfirmPassword(text) {
  if (text.trim().isEmpty) {
    return "This field mustn't be empty";
  } else if (text != Controllers.createpassword.text) {
    return "Passwords is not the same ";
  }
   return null;
}

//  displayPaymentSheet(context)async{

//  }

myCategoryWidget(context, String text, String image, productCategory) {
  return InkWell(
    child: Container(
      height: 140,
      width: 120,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 32, 32, 32),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    ),
    onTap: () {
      myPushNavigator(
          context,
          Products(
            filter: true,
            category: productCategory,
          ));
    },
  );
}


