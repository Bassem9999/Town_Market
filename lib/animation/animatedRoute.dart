import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder{
  final page;
  SlideRoute({this.page}) : super(
    pageBuilder:(context,animation,animationtwo) => page,
    transitionsBuilder : (context,animation,animationtwo,child){

      // var begin = const Offset(1,0);
      // var end = const Offset(0,0);
      // var tween = Tween(begin: begin,end: end);
               //First way...
      // var offsetAnimation = animation.drive(tween);
      // return SlideTransition(position: offsetAnimation,child:child);
              
               //second way...
      // var curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOutBack);
      // return SlideTransition(position: tween.animate(curvesAnimation),child:child);

                  //another animation...
      var begin =0.0;
      var end = 1.0;
      var tween = Tween(begin: begin,end: end);
                  //Scale Animation
      var curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOutBack);
      return ScaleTransition(scale: tween.animate(curvesAnimation),child:child);

                  //Rotation Animation
      // var curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOutBack);
      // return RotationTransition(turns: tween.animate(curvesAnimation),child:child);

                              //another animation...
       //return Align(alignment: Alignment.center,child: SizeTransition(sizeFactor: animation,child: child,),);

                              //another animation...
      //  return FadeTransition(opacity: animation,child: child);
    }
    );
   
}