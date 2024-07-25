import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Color blueColor = const Color(0xFF007BFF);
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: SvgPicture.asset("lib/core/assets/icons/backArrow.svg"),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "TASK-WAN",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: 35),
            ),
            const Text(
              "Management  App",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "Create an account",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            Spacer(),
            textField(
                blueColor: blueColor,
                hintText: "Username",
                icon: Icons.person,
                controller: usernameController),
            textField(
                blueColor: blueColor,
                hintText: "email",
                icon: Icons.email,
                controller: emailController),
            textField(
              obscureText: passwordVisible,
              blueColor: blueColor,
              hintText: "Password",
              icon: Icons.lock,
              controller: passwordController,
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: blueColor,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
            textField(
              blueColor: blueColor,
              hintText: "Confirm Password",
              icon: Icons.lock,
              controller: passwordConfirmController,
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: blueColor,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.075,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {},
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class textField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final IconButton? suffixIcon;
  const textField({
    super.key,
    required this.blueColor,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
  });

  final Color blueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              suffixIcon: suffixIcon,
              prefixIcon: Container(
                height: MediaQuery.of(context).size.height * 0.065,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ) // Adjust this to add space
              ),
        ),
      ),
    );
  }
}
