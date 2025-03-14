import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Guardar usuario en Local Storage
  Future<void> _saveUserLocally(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUID', user.uid);
    await prefs.setString('userEmail', user.email ?? '');
  }

  // Registro de usuario
  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _saveUserLocally(user);
      }
      return user;
    } catch (e) {
      print("Error en registro: $e");
      return null;
    }
  }

  // Inicio de sesión
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _saveUserLocally(user);
      }
      return user;
    } catch (e) {
      print("Error en inicio de sesión: $e");
      return null;
    }
  }

  // Obtener usuario almacenado localmente
  Future<Map<String, String?>> getUserFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUID = prefs.getString('userUID');
    String? userEmail = prefs.getString('userEmail');
    return {'userUID': userUID, 'userEmail': userEmail};
  }

  // Cerrar sesión y limpiar almacenamiento local
  Future<void> logoutUser() async {
    await _auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userUID');
    await prefs.remove('userEmail');
  }
}