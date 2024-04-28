import 'package:flutter/widgets.dart';
import 'package:shop_one/screens/cart/cart_screen.dart';
import 'package:shop_one/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_one/screens/details/details_screen.dart';
import 'package:shop_one/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_one/screens/home/home_screen.dart';
import 'package:shop_one/screens/init_screen.dart';
import 'package:shop_one/screens/login_success/login_success_screen.dart';
import 'package:shop_one/screens/otp/otp_screen.dart';
import 'package:shop_one/screens/products/products_screen.dart';
import 'package:shop_one/screens/profile/profile_screen.dart';
import 'package:shop_one/screens/sign_in/sign_in_screen.dart';
import 'package:shop_one/screens/sign_up/sign_up_screen.dart';
import 'package:shop_one/screens/splash/splash_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
