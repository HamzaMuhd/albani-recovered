// import 'dart:convert';

// import 'package:albani/core/configs/constants/app_urls.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   Future<Map<String, dynamic>> register(
//       String fullName, String email, String password) async {
//     final response = await http.post(
//       Uri.parse(AppUrls.register),
//       headers: {"Content-Type": "application/json"},
//       body: json.encode({
//         "full_name": fullName,
//         "email": email,
//         "password": password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to signup');
//     }
//   }

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse(AppUrls.login),
//       headers: {"Content-Type": "application/json"},
//       body: json.encode({
//         "email": email,
//         "password": password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to signup');
//     }
//   }
// }
