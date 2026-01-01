import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/state/auth_state.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/view_model/auth_view_model.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    await ref.read(authViewModelProvider.notifier).registerUser(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final state = ref.read(authViewModelProvider);
    if (state.status == AuthStatus.registered) {
      // success: show confirmation, reset state and navigate
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered successfully')));
      ref.read(authViewModelProvider.notifier).resetState();
      Navigator.pushReplacementNamed(context, '/login');
    } else if (state.status == AuthStatus.error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

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
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 56),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Tridivya",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Image.asset(
                    "assets/images/logo.png",
                    height: 56,
                  ),

                  const SizedBox(height: 24),

                  // FULL NAME
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText: "Your full name",
                      filled: true,
                      fillColor: const Color(0xFFE5D9FF),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Full name is required' : null,
                  ),

                  const SizedBox(height: 12),

                  // EMAIL
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "you@gmail.com",
                      filled: true,
                      fillColor: const Color(0xFFE5D9FF),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Email is required' : null,
                  ),

                  const SizedBox(height: 12),

                  // PASSWORD
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "*********",
                      filled: true,
                      fillColor: const Color(0xFFE5D9FF),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Password is required' : null,
                  ),

                  const SizedBox(height: 12),

                  // CONFIRM PASSWORD
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      filled: true,
                      fillColor: const Color(0xFFE5D9FF),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Confirm password is required';
                      if (v.trim() != _passwordController.text.trim()) return 'Passwords do not match';
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  /// SIGNUP BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE9B74D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: authState.status == AuthStatus.loading ? null : () async {
                        await _handleSignup();
                      },
                      child: authState.status == AuthStatus.loading ? const CircularProgressIndicator() : const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // OR Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white54)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('or', style: TextStyle(color: Colors.white70)),
                      ),
                      Expanded(child: Divider(color: Colors.white54)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Social sign-up buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.g_mobiledata),
                          label: const Text('Sign up with Google'),
                          onPressed: () {
                            // TODO: integrate Google Sign-In
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google sign-up not implemented')));
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: Icon(Icons.apple),
                          label: Text('Sign up with Apple'),
                          onPressed: () {
                            // TODO: integrate Apple Sign-In
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Apple sign-up not implemented')));
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Already have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
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
