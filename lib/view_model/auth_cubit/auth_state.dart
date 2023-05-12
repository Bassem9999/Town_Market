part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginNotLoadingState extends AuthState {}

class SignUpLoadingState extends AuthState {}

class SignUpNotLoadingState extends AuthState {}

class PasswordVisibilityState extends AuthState {}
