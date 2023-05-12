import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/components.dart';
import '../../view/customerView/home.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  final _auth = FirebaseAuth.instance;


  bool loginTap = false;
  bool signupTap = false;
  bool isvisible = true;


  visibility() {
    isvisible = !isvisible;
    emit(PasswordVisibilityState());
  }

  login(context) async {
    var currentData = formstatelogin.currentState;
    currentData!.save();
    if (currentData.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      loginTap = true;
      emit(LoginLoadingState());
      await _auth.signInWithEmailAndPassword( email: loginemail.text.trim(),password: loginpassword.text.trim()).then((value) {
        myPushNavigator(context, HomePage());
        loginTap = false;
        preferences.setBool('loginStatus', true);
        print(preferences.getBool('loginStatus'));
        emit(LoginNotLoadingState());
        print("success");
      }).catchError((onError) {
        loginTap = false;
        emit(LoginNotLoadingState());
        print(onError.toString());
        showdialog(context, "Some thing went Wrong", null, const Color.fromARGB(255, 68, 68, 68));
      });
    }
  }

  signUp(context) async {
    var currentData = formstatesignup.currentState;
    currentData!.save();
    if (currentData.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      signupTap = true;
      emit(SignUpLoadingState());
      await _auth
          .createUserWithEmailAndPassword(
              email: createemail.text.trim(),
              password: createpassword.text.trim())
          .then((value) {
        myPushNavigator(context, HomePage());
        signupTap = false;
        preferences.setBool('loginStatus', true);
        emit(SignUpNotLoadingState());
        print("success");
      }).catchError((onError) {
        signupTap = false;
        emit(SignUpNotLoadingState());
        print(onError.toString());
        showdialog(context, "Email not valid", null, Colors.white);
      });
    }
  }
}
