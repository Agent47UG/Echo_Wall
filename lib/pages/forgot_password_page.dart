import 'package:echo_wall/components/my_text_field.dart';
import 'package:echo_wall/helper/password_helper.dart';
import 'package:echo_wall/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final _auth = AuthService();
  bool isSent = false;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await _auth.forgotPassword(emailController.text.trim());
      setState(() {
        isSent = true;
        emailController.clear();
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9, left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter your Email and we'll send you a mail to reset it!",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: MyTextField(
                controller: emailController,
                hintText: "Enter Your Email",
                obscureText: false,
                validator: (val) {
                  if (!val!.isValidEmail) {
                    return "Enter a Valid Email!";
                  }
                  return null;
                }),
          ),
          if (isSent)
            Padding(
              padding:
                  const EdgeInsets.only(left: 17, right: 10, top: 8, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "We've sent you a link to reset your password if your email exists",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: passwordReset,
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Send Email",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 15,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    )
                  ],
                ),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
