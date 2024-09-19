import 'package:echo_wall/components/my_button.dart';
import 'package:echo_wall/components/my_loading_circle.dart';
import 'package:echo_wall/components/my_text_field.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void login() async {
    showLoadingCircle(context);

    try {
      await _auth.loginEmailPassword(emailController.text, pwController.text);

      if (mounted) hideLoadingCircle(context);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/login_page_logo.png',
                  scale: 5,
                ),
                const SizedBox(height: 10),
                Text(
                  "Welcome back, we missed you!",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 50),
                MyTextField(
                    controller: emailController,
                    hintText: "Enter Your Email",
                    obscureText: false),
                const SizedBox(height: 25),
                MyTextField(
                    controller: pwController,
                    hintText: "Enter Your Password",
                    obscureText: true),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                MyButton(
                  onTap: login,
                  text: "Login",
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        " Register Now!",
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
    );
  }
}
