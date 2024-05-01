import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
    required String displayName,
    required String birthday,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        user.updateDisplayName(displayName);
        await user.reload();
        user = await _auth.currentUser;
        print("Registered user:");
        print(user);
      }
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Şifre çok güçsüz.';
      } else if (e.code == 'email-already-in-use') {
        return 'Bu email zaten kayıtlı';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Giriş yapıldı!';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Kullanıcı Bulunamadı..';
      } else if (e.code == 'wrong-password') {
        return 'Hatalı şifre!';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
