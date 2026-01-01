import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/signup_page.dart';
import 'package:tridivya_spritual_wellness_app/widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    final form = _formKey.currentState;
    if (form == null) return;

    if (!form.validate()) {
      // show errors — validators will display messages
      return;
    }

    setState(() => _isLoading = true);
    // simulate login
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return;
    // TODO: replace with real auth flow
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged in')));
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC6A8F4),
              Color(0xFF7CB0FF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Tridivya",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Image.asset(
                    "assets/images/logo.png",
                    height: 60,
                  ),

                  const SizedBox(height: 40),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "you@gmail.com",
                      filled: true,
                      fillColor: const Color(0xFFE5D9FF),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Email is required' : null,
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "*********",
                      filled: true,
                      fillColor: const Color(0xFFE5D9FF),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Password is required' : null,
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forget Password ?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      text: _isLoading ? 'Signing in...' : 'Sign In',
                      color: const Color(0xFFE9B74D),
                      onPressed: _isLoading ? null : () { _onSignIn(); },
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have account ? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!mounted) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
