import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_one/services/auth_service.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  final bool isLoading;
  final Function(bool) setLoadingState;
  const SignUpForm({super.key, required this.isLoading, required this.setLoadingState});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  bool _isObscure = true;
  bool _isObscureCon = true;
  final List<String?> errors = [];
  final _auth = AuthService();


  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _isObscure,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                child: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: _isObscure ? Colors.grey : kPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _isObscureCon,
            onSaved: (newValue) => conform_password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty && password == conform_password) {
                removeError(error: kMatchPassError);
              }
              conform_password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if ((password != value)) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:  GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscureCon = !_isObscureCon;
                  });
                },
                child: Icon(
                  _isObscureCon ? Icons.visibility_off : Icons.visibility,
                  color: _isObscureCon ? Colors.grey : kPrimaryColor,
                ),
              ),
            ),
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.setLoadingState(true); // Set loading state to true
                _signUp().then((success) {
                  if (success) {
                    // Navigate to next screen if sign-up is successful
                    Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                  } else {
                    // Handle sign-up failure
                    widget.setLoadingState(false); // Set loading state to false
                    // Show error message or retry logic
                  }
                });
              }
            },
            child: widget.isLoading?const SizedBox(
              height: 30,
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [Colors.white],
                strokeWidth: 2,
              ),
            )
                :const Text("Continue"),
          ),
        ],
      ),
    );
  }
  _signUp() async{
    _auth.createUserWithEmailAndPassword(email!, password!);
      debugPrint('User Created Successfully');
    }
}
