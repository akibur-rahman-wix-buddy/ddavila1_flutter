// import 'dart:developer';
// import 'package:errolspreadlove_app/helpers/all_routes.dart';
// import 'package:errolspreadlove_app/helpers/navigation_service.dart';
// import 'package:errolspreadlove_app/helpers/toast.dart';
// import 'package:errolspreadlove_app/networks/api_acess.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class SocialAuthData {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//   static final GoogleSignIn googleSignIn = GoogleSignIn();

//   static Future<User?> signInWithGoogle(BuildContext context) async {
//     try {
//       // await InternetAddress.lookup('google.com');

//       // Trigger the Google Sign In flow
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();

//       // Obtain the GoogleSignInAuthentication object
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;

//       // Create a new credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       log('accesstoken is : ${credential.accessToken}');

//       // Once signed in, return the UserCredential
//       var authResult = await _auth.signInWithCredential(credential);
//       // ToastUtil.showLongToast(authResult.toString());
//       if (authResult.user != null) {
//         log('auth user not null ');
//         await postSocailLoginRX.postSocailLogin(
//           token: credential.accessToken.toString(),
//           registerType: "google",
//         );
//         log('accesstoken is : ${credential.accessToken}');
//         //NavigationService.navigateTo(Routes.navigationScreen);
//         NavigationService.navigateTo(Routes.petProfileSwitchingScreen);
//         ToastUtil.showLongToast('Login Sussessfully');
//       }
//       log("google sing in info$authResult");
//       // Return the current user
//       return authResult.user;
//     } catch (error) {
//       ToastUtil.showLongToast(error.toString());
//       log("error type cast${error.toString()}");
//       return null;
//     }
//   }
// }
