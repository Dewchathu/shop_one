import 'package:flutter/material.dart';
import 'package:shop_one/services/auth_service.dart';
import '../../components/socal_card.dart';
import '../../constants.dart';
import '../init_screen.dart';
import 'components/sign_up_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";


  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLoadingState(); // Load initial loading state from SharedPreferences
  }

  Future<void> _loadLoadingState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = prefs.getBool('isLoading') ?? false; // Default to false if key doesn't exist
    });
  }

  Future<void> _setLoadingState(bool isLoading) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoading', isLoading);
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Register Account", style: headingStyle),
                  const Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SignUpForm(
                    isLoading: _isLoading,
                    setLoadingState: _setLoadingState,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () async {
                          await _setLoadingState(true); // Set loading state to true
                          AuthService().signInWithGoogle(context).then((success) {
                              _setLoadingState(false);
                          });
                        },
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
