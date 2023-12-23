import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<dynamic> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString("user-token");
    try {
      Dio dio = Dio();
      String baseURL = 'https://demoapi-hilmy.sanbercloud.com/';
      await dio.post("$baseURL/api/logout",
          options: Options(headers: {"authorization": "Bearer $userToken"}));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on DioException catch (dioError) {
      var message = "";
      switch (dioError.response!.statusCode) {
        case 400:
          message = dioError.response!.data["message"].toString();
          break;
        case 404:
          message = "Server Not Found";
          break;
        case 500:
          message = "Internal Server Error";
        default:
          message = "Invalid username and password";
      }

      final snackbar = SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      "assets/img/profile.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Ananta Kusuma P",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "kusumaananta042@gmail.com",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(FontAwesomeIcons.linkedin),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ananta Kusuma",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(FontAwesomeIcons.telegram),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "@Kusumaananta99",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //   onTap: () {
              //     logout();
              //   },
              //   child: Container(
              //     height: 50,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.red[400],
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.logout,
              //           color: Colors.white,
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           "Logout",
              //           style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
