import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({Key? key}) : super(key: key);

  @override
  State<AnimationTest> createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  double rotate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: 
                         //Change Container Size
          // Transform.scale(scale: 1.0,child: Container(height: 100,width: 100,color: Colors.blue,),)
        
                         //Change Container place
          //  Transform.translate(offset: Offset(20,20),child: Container(height: 100,width: 100,color: Colors.blue,),)

                        //Rotate Container 
          //  Transform.rotate(angle: rotate,child: Container(height: 100,width: 100,color: Colors.blue,),),
            Container()
          ),

          // Slider(value: rotate,min: 0,max:3, onChanged: (value){
          //   setState(() {
          //     rotate = value;
          //   });
          // })
        ],
      ),
    );
  }
}