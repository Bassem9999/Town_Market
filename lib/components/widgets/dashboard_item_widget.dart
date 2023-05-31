import 'package:flutter/material.dart';

import '../components.dart';

// ignore: must_be_immutable
class DashboardItem extends StatelessWidget {
  IconData icon;
  String text;
  Color color;
  Widget screen;

  DashboardItem ({Key? key, required this.icon, required this.text, required this.color, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
    child: InkWell(
      child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Colors.white.withOpacity(0.4), width: 3)),
          child: Column(
                  children:[
                    SizedBox(height: MediaQuery.of(context).size.height * .01,),
                    Icon(icon,size: 100,),
                    Text(text,style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),),
      onTap: () {
        myPushNavigator(context, screen);
      },
    ),
  );
  }
}