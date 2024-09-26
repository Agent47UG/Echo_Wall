import 'package:echo_wall/components/my_button.dart';
import 'package:echo_wall/components/my_loading_circle.dart';
import 'package:echo_wall/components/my_text_field.dart';
import 'package:echo_wall/helper/password_helper.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:echo_wall/services/database/database_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final _db = DatabaseService();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void register() async {
    if (pwController.text == confirmPwController.text) {
      showLoadingCircle(context);

      try {
        await _auth.registerEmailPassword(
            emailController.text, pwController.text);

        if (mounted) hideLoadingCircle(context);

        await _db.saveUserInfoInFirebase(
          name: nameController.text,
          email: emailController.text,
        );
      } catch (e) {
        if (mounted) hideLoadingCircle(context);
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password Do not match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_open_rounded,
                        size: 72,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Welcome! Let's get you started",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 50),
                      MyTextField(
                          controller: nameController,
                          hintText: "Enter Your Name",
                          obscureText: false,
                          validator: (val) {
                            if (!val!.isValidName) {
                              return "Enter a Valid Name";
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      MyTextField(
                          controller: emailController,
                          hintText: "Enter Your Email",
                          obscureText: false,
                          validator: (val) {
                            if (!val!.isValidEmail) {
                              return "Enter a Valid Email!";
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      MyTextField(
                          controller: pwController,
                          hintText: "Enter A Password",
                          obscureText: false,
                          validator: (val) {
                            if (!val!.isValidPassword) {
                              return "The Password Must Contain\n • Minimum 8 characters \n • At least one Lowercase letter (a-z).\n • At least one Uppercase letter (A-Z).\n • At least one digit (0-9).\n • At least one special character";
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      MyTextField(
                          controller: confirmPwController,
                          hintText: "Confirm Password",
                          obscureText: true,
                          validator: (val) {
                            if (confirmPwController.text.toString() !=
                                pwController.text.toString()) {
                              return "Passwords Do Not Match!";
                            }
                            return null;
                          }),
                      const SizedBox(height: 30),
                      MyButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            register();
                          }
                        },
                        text: "Register",
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already a member?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              " Login Now!",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
