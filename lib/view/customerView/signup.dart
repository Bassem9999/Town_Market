import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';

import 'login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("images/clothes shop background5.jpg"),
                        fit: BoxFit.cover,
                        opacity: .4)),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      child: Form(
                        key: formstatesignup,
                        child: Column(
                          children: [
                            const Text(
                              "Create Account",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            myTextField(
                                'Email',
                                Icons.email_outlined,
                                const Icon(null),
                                null,
                                createemail,
                                false,
                                myvalEmail),
                            myTextField(
                                'Password',
                                Icons.lock_outline,
                                cubit.isvisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                cubit.visibility,
                                createpassword,
                                cubit.isvisible,
                                myvalPassword),
                            myTextField(
                                'ConfirmPassword',
                                Icons.confirmation_number_outlined,
                                cubit.isvisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                cubit.visibility,
                                confirmpassword,
                                cubit.isvisible,
                                myvalConfirmPassword),
                            ElevatedButton(
                              onPressed: () {
                                cubit.signUp(context);
                              },
                              child: cubit.signupTap
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 122, vertical: 10),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 4.5,
                                      ))
                                  : const Text(
                                      "Create Account ",
                                      style: TextStyle(fontSize: 17),
                                    ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(300, 40),
                                //animationDuration: Duration(milliseconds: 2000)
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have Account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  child: const Text("Login "),
                                  onPressed: () {
                                    myReplaceNavigator(
                                        context, const LoginPage());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
