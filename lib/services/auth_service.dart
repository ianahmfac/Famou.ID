part of 'services.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      // Create akun
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Convert semua data ke user
      User user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      // Update User
      await UserService.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(msg: e.toString().split(", ")[1]);
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromFirestore();
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(msg: e.toString().split(", ")[1]);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async{
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignInSignUpResult {
  User user;
  String msg;

  SignInSignUpResult({this.user, this.msg});
}
