import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../barrel.dart';

class AuthProviderDemo extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  AuthType _authType = AuthType.signIn;

  AuthType get authType => _authType;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  setAuthType() {
    _authType =
        _authType == AuthType.signIn ? AuthType.signUp : AuthType.signIn;
    notifyListeners();
  }

  /// Here we have methods to authenticate through Email, phone and google.
  ///
  /// Email/Password Authentication

  authenticate() async {
    UserCredential userCredential;
    try {
      if (_authType == AuthType.signUp) {
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await userCredential.user!.sendEmailVerification();
        firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          "email": userCredential.user!.email,
          "uid": userCredential.user!.uid,
          "user_name": userNameController.text,
        });
      }
      if (_authType == AuthType.signIn) {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      }
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  bool? emailVerified;

  updateEmailVerificationState() async {
    emailVerified = firebaseAuth.currentUser!.emailVerified;

    if (!emailVerified!) {
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        print('timer called');
        await firebaseAuth.currentUser!.reload();
        final user = FirebaseAuth.instance.currentUser;

        if (user!.emailVerified) {
          emailVerified = user!.emailVerified;
          timer.cancel();
          notifyListeners();
        }
      });
    }
  }

  TextEditingController resetEmailController = TextEditingController();

  resetPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('enter your email'),
              content: CustomTextField(
                iconData: Icons.email,
                hintText: 'enter email',
                controller: resetEmailController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context).pop();
                      try {
                        firebaseAuth.sendPasswordResetEmail(
                            email: resetEmailController.text);
                        Keys.scaffoldMessengerKey.currentState!
                            .showSnackBar(SnackBar(
                          content: Text('email sent'),
                          backgroundColor: Colors.teal,
                        ));
                        navigator;
                      } catch (e) {
                        Keys.scaffoldMessengerKey.currentState!
                            .showSnackBar(SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red,
                        ));
                        navigator;
                      }
                    },
                    child: Text('submit')),
              ],
            ));
  }

  /// Phone Authentication

  TextEditingController phoneController = TextEditingController();

  verifyPhoneNumber(BuildContext context) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (AuthCredential authCredential) {
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
            content: Text('verification completed'),
            backgroundColor: Colors.teal,
          ));
        },
        verificationFailed: (FirebaseAuthException exception) {
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
            content: Text('verification failed'),
            backgroundColor: Colors.red,
          ));
        },
        codeSent: (String? verId, int? forceCodeResent) {
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
            content: Text('Code sent successfully'),
            backgroundColor: Colors.teal,
          ));
          verificationID = verId;
          //otp dialog box defined below
          optDialogBox(context);
        },
        codeAutoRetrievalTimeout: (String verId) {
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
            content: Text('time out'),
            backgroundColor: Colors.red,
          ));
        },
      );
    } on FirebaseAuthException catch (e) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(e.message!),
        backgroundColor: Colors.red,
      ));
    }
  }

  String? verificationID;
  TextEditingController otpController = TextEditingController();

  optDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('enter your OTP'),
            content: CustomTextField(
              controller: otpController,
              iconData: Icons.code,
              hintText: 'Enter OTP',
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    signInWithPhone();
                    Navigator.of(context).pop(context);
                  },
                  child: Text('Submit'))
            ],
          );
        });
  }

// when we use the submit button after writing our OTP
  signInWithPhone() async {
    await firebaseAuth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationID!,
        smsCode: otpController.text,
      ),
    );
  }

  /// Google Authentication

  GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await firebaseAuth.signInWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text(e.message!),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Account not selected"),
        backgroundColor: Colors.red,
      ));
    }
  }

  /// Logout Function

  logOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}

enum AuthType {
  signUp,
  signIn,
}
