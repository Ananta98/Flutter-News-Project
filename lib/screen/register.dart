import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/login.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? name;
  String? username;
  String? email;
  String? password;
  late bool _isLoading = false;
  var passwordVisible = false;

  Future<dynamic> registerSubmit() async {
    var data = {
      "name": name,
      "username": username,
      "email": email,
      "password": password
    };

    try {
      Dio dio = Dio();
      String baseURL = 'https://demoapi-hilmy.sanbercloud.com/';

      setState(() {
        _isLoading = true;
      });

      await dio.post('$baseURL/api/register',
          data: data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          }));

      final snackbar = SnackBar(
        content: const Text("Register Success"),
        backgroundColor: Colors.green,
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));

    } on DioException catch (dioError) {
      var message = "";
      switch (dioError.response!.statusCode) {
        case 422:
          Map<String, dynamic> errorData = dioError.response!.data["errors"];
          var getListMessage = errorData.values;
          var result = getListMessage.map((item) => item.toString().substring(1, item.toString().length - 2));
          setState(() {
            _isLoading = false;
          });
          message = result.join("\n");
          break;
        case 404:
          setState(() {
            _isLoading = false;
          });
          message = "Server Not Found";
          break;
        default:
          setState(() {
            _isLoading = false;
          });
          message = "Server Error";
      }

      final snackbar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
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
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            shrinkWrap: true,
            children: [
              Text(
                "Hello!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    color: Colors.blue[700]),
              ),
              const Text(
                "Signup to get Started",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (String? nameValue) {
                            if (nameValue!.isEmpty) {
                              return "Enter name text";
                            }
                            name = nameValue;
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person),
                              hintText: "Name"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (String? userNameValue) {
                            if (userNameValue!.isEmpty) {
                              return "Enter username text";
                            }
                            username = userNameValue;
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.perm_identity),
                              hintText: "Username"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
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
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (String? passwordValue) {
                            if (passwordValue!.isEmpty) {
                              return "Enter password text";
                            }
                            password = passwordValue;
                            return null;
                          },
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.lock),
                              hintText: "Password",
                              suffixIcon:  IconButton(
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
                            registerSubmit();
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
                            "Register",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Already have an account?"),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            },
                            child: const Text("Login",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                )),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
