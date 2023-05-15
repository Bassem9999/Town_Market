// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/adminDashboard/adminDashboard.dart';
import '../view/customerView/favourites.dart';
import '../view/customerView/home.dart';
import '../animation/animatedRoute.dart';
import '../view/customerView/myCart.dart';
import '../view/customerView/products.dart';
import '../../../view_model/app_cubit/appCubit.dart';
import '../view/presentation/welcom_screen.dart';

TextEditingController loginemail = TextEditingController();
TextEditingController loginpassword = TextEditingController();

GlobalKey<FormState> formstatelogin = GlobalKey<FormState>();

TextEditingController createemail = TextEditingController();
TextEditingController createpassword = TextEditingController();
TextEditingController confirmpassword = TextEditingController();

GlobalKey<FormState> formstatesignup = GlobalKey<FormState>();

TextEditingController name = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController mobile = TextEditingController();
TextEditingController email = TextEditingController();

GlobalKey<FormState> formstateconfirmOrder = GlobalKey<FormState>();

TextEditingController productNameController = TextEditingController();

TextEditingController newPriceController = TextEditingController();

TextEditingController oldPriceController = TextEditingController();

GlobalKey<FormState> formstateAddProduct = GlobalKey<FormState>();
GlobalKey<FormState> formstateUpdateProduct = GlobalKey<FormState>();

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
          fillColor: Colors.black,
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
  } else if (text != createpassword.text) {
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

myAdminDashboardWidget(context, Color color, screen, Widget widget) {
  return Expanded(
    child: InkWell(
      child: Container(
          height: 170,
          width: 170,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Colors.white.withOpacity(0.4), width: 3)),
          child: widget),
      onTap: () {
        myPushNavigator(context, screen);
      },
    ),
  );
}

myProductWidget(context, i, source, Widget? widget) {
  return Card(
    color: Color.fromARGB(255, 59, 59, 59),
    child: Row(
      children: [
        Container(
          height: 130,
          width: 130,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: cubit.decodeImage(source[i]['imageUrl']).image,
                  fit: BoxFit.fill)),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                source[i]['name'],
                style: TextStyle(color: Colors.white, fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Category : " + source[i]['category'] + " %",
              style: TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  //  Text("Price : "),

                  Text(source[i]['newPrice'] + " \$",
                      style: TextStyle(fontSize: 17, color: Colors.tealAccent)),

                  SizedBox(
                    width: 30,
                  ),

                  Text(
                    source[i]['oldPrice'] + " \$",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ),
            SizedBox(width: 170, child: widget),
          ],
        ),
      ],
    ),
  );
}

myDrawer(context) {
  return Drawer(
    backgroundColor: Color.fromARGB(255, 32, 32, 32),
    child: ListView(children: [
      UserAccountsDrawerHeader(
        accountName: Text(""),
        accountEmail: Text(""),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage("images/clothes shop background6.jpg"),
                fit: BoxFit.cover)),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(
              "Home",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.home, color: Colors.white),
            onTap: () {
              myPushNavigator(context, HomePage());
            }),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(
              "Admin Dashboard",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.open_in_browser_outlined, color: Colors.white),
            onTap: () {
              myPushNavigator(context, AdminDashboard());
            }),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(
              "Products",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.category_outlined, color: Colors.white),
            onTap: () {
              myPushNavigator(
                  context,
                  Products(
                    filter: false,
                    category: null,
                  ));
            }),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(
              "My Cart",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onTap: () {
              myPushNavigator(context, CartScreen());
            }),
      ),
      Padding(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
              title: Text(
                "Favourites",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              leading: Icon(Icons.favorite_border, color: Colors.white),
              onTap: () {
                myPushNavigator(context, FavouritePage());
              })),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(
              "Test",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.favorite_border, color: Colors.white),
            onTap: () {
             // myPushNavigator(context, WelcomScreen());
             cubit.showToken();
            }),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            leading: Icon(Icons.logout, color: Colors.white),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool('loginStatus', false);
              print(preferences.getBool('loginStatus'));
              myReplaceNavigator(context, WelcomScreen());
            }),
      ),
    ]),
  );
}
