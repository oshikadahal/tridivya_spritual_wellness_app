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

  void _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authViewModelProvider.notifier).registerUser(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final state = ref.read(authViewModelProvider);
    if (state.status == AuthStatus.registered) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered successfully')));
      ref.read(authViewModelProvider.notifier).resetState();
      Navigator.pop(context);
    } else if (state.status == AuthStatus.error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: authState.status == AuthStatus.loading ? null : _handleSignup,
                child: authState.status == AuthStatus.loading ? const CircularProgressIndicator() : const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
