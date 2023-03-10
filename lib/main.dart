import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/presentation/welcom_screen.dart';
import 'view_model/appCubit.dart';
import 'view_model/appStates.dart';
import 'view/customerView/home.dart';
import 'view/customerView/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51MBhHVL3KQvWUvzkDfFq46BuVzGhuKnOiFeFEIkYfgZSy0lpsqD4SRjU73ERTqIFKAfiN98YVuc8UrPHQfuOUZgA00aAcENvel";
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getBool('loginStatus') == null) {
    preferences.setBool('loginStatus', false);
  }
  runApp(
      // DevicePreview(
      //   enabled: true,
      //   builder: (context)=>
      MyApp(
    loginStatus: preferences.getBool('loginStatus'),
  )
      // )
      );
}

class MyApp extends StatelessWidget {
  bool? loginStatus;
  MyApp({this.loginStatus});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getSearch(),
      child: MaterialApp(
        title: 'Town Market',
        color: Colors.teal,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(255, 32, 32, 32),
          ),
          scaffoldBackgroundColor: Color.fromARGB(255, 32, 32, 32),
        ),
        home: loginStatus == true ? HomePage() : const WelcomScreen(),
      ),
    );
  }
}


//--no-sound-null-safety