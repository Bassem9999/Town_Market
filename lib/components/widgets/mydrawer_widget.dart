import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/adminDashboard/adminDashboard.dart';
import '../../view/customerView/favourites.dart';
import '../../view/customerView/home.dart';
import '../../view/customerView/myCart.dart';
import '../../view/customerView/products.dart';
import '../../view/presentation/welcom_screen.dart';
import '../components.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
    backgroundColor: Color.fromARGB(255, 32, 32, 32).withOpacity(0.9),
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
            title: Text("Admin Dashboard",style: TextStyle(fontSize: 18, color: Colors.white),),
            leading: Icon(Icons.open_in_browser_outlined, color: Colors.white),
            onTap: () {
              myPushNavigator(context, AdminDashboard());
            }),
      ),
      Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            title: Text("Products", style: TextStyle(fontSize: 18, color: Colors.white),),
            leading: Icon(Icons.category_outlined, color: Colors.white),
            onTap: () {
              myPushNavigator(context,Products(filter: false,category: null,));
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
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setBool('loginStatus', false);
              print(preferences.getBool('loginStatus'));
              myReplaceNavigator(context, WelcomScreen());
            }),
      ),
    ]),
  );
  }
}