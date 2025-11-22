import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "https://your-backend-url.com/api/auth";

  // ----------------------------
  //  SIGNUP
  // ----------------------------
  Future<Map<String, dynamic>> signup(String email, String password) async {
    final url = Uri.parse("$baseUrl/signup");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ----------------------------
  //  LOGIN
  // ----------------------------
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["token"] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["token"]);
    }

    return data;
  }

  // ----------------------------
  // VERIFY OTP
  // ----------------------------
  Future<Map<String, dynamic>> verifyOtp({required String email, required String otp}) async {
    final url = Uri.parse('$baseUrl/api/auth/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  // ----------------------------
  // GET CURRENT USER
  // ----------------------------
  Future<Map<String, dynamic>> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final url = Uri.parse("$baseUrl/me");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }

  // ----------------------------
  // LOGOUT
  // ----------------------------
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }


  // send reset password OTP
  Future<Map<String, dynamic>> sendResetPasswordOtp(String email) async {
    final url = Uri.parse('$baseUrl/api/auth/verify-otp'); // or /api/auth/forgot-password
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }



}
