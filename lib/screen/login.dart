import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/home.dart';
import 'package:flutter_news_app/screen/register.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? email;
  late String? password;
  var passwordVisible = false;

  Future<dynamic> login() async {
    var data = {
      "email": email,
      "password": password,
    };

    try {
      Dio dio = Dio();
      String baseURL = 'https://demoapi-hilmy.sanbercloud.com/';

      setState(() {
        _isLoading = true;
      });

      Response response = await dio.post('$baseURL/api/login',
          data: data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          }));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user-token", response.data['token']);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on DioException catch (dioError) {
      var message = "";
      switch (dioError.response!.statusCode) {
        case 400:
          message = dioError.response!.data["message"].toString();
          setState(() {
            _isLoading = false;
          });
          break;
        case 404:
          message = "Server Not Found";
          setState(() {
            _isLoading = false;
          });
          break;
        case 500:
          setState(() {
            _isLoading = false;
          });
          message = "Internal Server Error";
        default:
          setState(() {
            _isLoading = false;
          });
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
      key: _scaffoldKey,
        body: LoadingOverlay(
          isLoading: _isLoading,
          child: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/news-app-logo.jpeg",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 278,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue[400]!),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        validator: (String? emailValue) {
                          if (emailValue!.isEmpty) {
                            return "Enter Email text";
                          }
                          email = emailValue;
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.person),
                            hintText: "Email"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 278,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue[400]!),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        obscureText: !passwordVisible,
                        validator: (String? passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return "Enter password text";
                          }
                          password = passwordValue;
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.lock),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: passwordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Does not have account?"),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text("Register",
                        style: TextStyle(
                          color: Colors.lightBlue,
                        )),
                  )
                ],
              ),
            ],
                ),
              ),
          ),
        ));
  }
}
