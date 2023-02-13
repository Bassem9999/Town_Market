import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../view_model/appCubit.dart';
import '../../view_model/appStates.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                      height: 150,
                    ),
                    SizedBox(
                      child: Form(
                        key: formstatelogin,
                        child: Column(
                          children: [
                            const Text(
                              "Login to Town Market",
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
                                () {},
                                loginemail,
                                false,
                                myvalEmail),
                            myTextField(
                                'Password',
                                Icons.lock_outline,
                                cubit.isvisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                cubit.visibility,
                                loginpassword,
                                cubit.isvisible,
                                myvalPassword),
                            ElevatedButton(
                              onPressed: () {
                                cubit.login(context);
                              },
                              child: cubit.loginTap
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 122, vertical: 10),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 4.5,
                                      ))
                                  : const Text(
                                      "Login ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(300, 40),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have Account? ",
                                    style: TextStyle(color: Colors.white)),
                                TextButton(
                                    child: const Text("create One "),
                                    onPressed: () {
                                      myReplaceNavigator(context, SignUpPage());
                                    }),
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
