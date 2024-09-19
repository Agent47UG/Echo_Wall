import 'package:echo_wall/components/my_button.dart';
import 'package:echo_wall/components/my_loading_circle.dart';
import 'package:echo_wall/components/my_text_field.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 50),
                MyTextField(
                    controller: nameController,
                    hintText: "Enter Your Name",
                    obscureText: false),
                const SizedBox(height: 15),
                MyTextField(
                    controller: emailController,
                    hintText: "Enter Your Email",
                    obscureText: false),
                const SizedBox(height: 15),
                MyTextField(
                    controller: pwController,
                    hintText: "Enter A Password",
                    obscureText: false),
                const SizedBox(height: 15),
                MyTextField(
                    controller: confirmPwController,
                    hintText: "Confirm Password",
                    obscureText: true),
                const SizedBox(height: 30),
                MyButton(
                  onTap: register,
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
    );
  }
}
