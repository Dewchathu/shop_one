import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_one/services/firestore_service.dart';

import '../screens/init_screen.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await _auth.currentUser;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      debugPrint("Something went wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      debugPrint("Something went wrong");
    }
    return null;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        final User? userDetails = userCredential.user;

        if (userDetails != null) {
          // User signed in successfully
          Map<String, dynamic> userInfoMap = {
            "email": userDetails.email,
            "name": userDetails.displayName,
            "id": userDetails.uid,
            "phone": userDetails.phoneNumber,
            "address": '', // You can add more fields as needed
          };

          // Add user details to Firestore
          await FirestoreService().addUser(userDetails.uid, userInfoMap);

          Navigator.pushNamed(context, InitScreen.routeName);
        } else {
          // Handle case where userDetails is null (authentication failed)
          debugPrint('User authentication failed');
        }
      } else {
        // Handle case where googleSignInAccount is null (sign-in canceled)
        debugPrint('Google sign-in canceled');
      }
    } catch (e) {
      // Handle other exceptions that might occur during sign-in
      debugPrint('Error signing in with Google: $e');
      // Show error message or handle error gracefully
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sign-In Error'),
            content: Text('Failed to sign in with Google. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Something went wrong");
    }
  }
}
