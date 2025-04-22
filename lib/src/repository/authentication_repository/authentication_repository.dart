import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/user_screen.dart';
import 'package:pawlse/src/features/authentication/screens/login/login_screen.dart';
import 'package:pawlse/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:pawlse/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:pawlse/src/repository/authentication_repository/exeptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;
  var verificationId = ''.obs;
  final _db = FirebaseFirestore.instance;

  // late final GoogleSignInAccount _googleUser;

  User? get firebaseUser => _firebaseUser.value;
  String get getUserID => firebaseUser?.uid ?? "";
  String get getUserEmail => firebaseUser?.email ?? "";

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
    // ever(_firebaseUser, _setInitialScreen);
  }

  setInitialScreen(User? user) async {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : user.emailVerified
            ? Get.offAll(() => const UserScreen())
            : Get.offAll(() => const MailVerification());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong');
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credential =
        await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId.value,
      smsCode: otp,
    ));
    return credential.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _db.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        // "name": email,
        "email": email,
        // "photoURL": "",
        "createdAt": FieldValue.serverTimestamp(),
        "signInMethod": "email",
        "accessToDisplay": true,
        "petName": "none",
        "admin": false,
        "adminPassword": "none"
      }, SetOptions(merge: true));

      _firebaseUser.value != null
          ? Get.offAll(() => const UserScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = PExecptions.code(e.code);
      print("FIREBASE AUTH EXEPTION - ${ex.message}");
      throw ex;
    } catch (_) {
      const ex = PExecptions();
      print("EXEPTION - ${ex.message}");
      throw ex;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = PExecptions.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = PExecptions();
      throw ex.message;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      onReady();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error creating user', e.message.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuth catch (e) {
      final ex = PExecptions.code(e.toString());
      throw ex.message;
    } catch (_) {
      const ex = PExecptions();
      throw ex.message;
    }
  }

  Future<void> handleGoogleSignIn() async {
    final userCredential = await signInWithGoogle();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not signed in!");
    } else {
      print("User is signed in: ${user.email}");
      saveUserToFirestore(userCredential.user!);
    }
  }

  Future<void> checkUser() async {}

  Future<void> saveUserToFirestore(User user) async {
    final userDoc = _db.collection("Users").doc(user.uid);

    final snapshot = await userDoc.get();
    if (!snapshot.exists) {
      await userDoc.set({
        "uid": user.uid,
        "name": user.displayName ?? "",
        "email": user.email ?? "",
        "photoURL": user.photoURL ?? "",
        "createdAt": FieldValue.serverTimestamp(),
        "signInMethod": "google",
        "accessToDisplay": true,
        "petName": "none",
        "admin": false,
        "adminPassword": "none",
        "dogFurType": "Not Set",
        "dogSize": "Not Set"
      });
    }
  }

  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      throw "Unable to logout. Try again.";
    }
  }
}
