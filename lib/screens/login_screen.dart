import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/screens/signup_screen.dart';
import '../widgets/my_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "you@gmail.com",
                    filled: true,
                    fillColor: Color(0xFFE5D9FF),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
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

           
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "*********",
                    filled: true,
                    fillColor: Color(0xFFE5D9FF), // light purple
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
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
                    text: "Sign In",
                    color: const Color(0xFFE9B74D), 
                    onPressed: () {},
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
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
)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
