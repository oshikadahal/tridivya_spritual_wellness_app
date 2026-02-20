import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _toggleCurrent() => setState(() => _showCurrent = !_showCurrent);
  void _toggleNew() => setState(() => _showNew = !_showNew);
  void _toggleConfirm() => setState(() => _showConfirm = !_showConfirm);

  Future<void> _submit() async {
    final current = _currentController.text.trim();
    final newPwd = _newController.text.trim();
    final confirm = _confirmController.text.trim();

    if (current.isEmpty || newPwd.isEmpty || confirm.isEmpty) {
      _showSnack('Please fill all fields');
      return;
    }
    if (newPwd.length < 8) {
      _showSnack('New password must be at least 8 characters');
      return;
    }
    if (newPwd != confirm) {
      _showSnack('New password and confirmation do not match');
      return;
    }
    if (newPwd == current) {
      _showSnack('New password must be different from current');
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    setState(() => _isSubmitting = false);
    _showSnack('Password updated');
    Navigator.pop(context, true);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF7C4DFF);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(primary),
              const SizedBox(height: 24),
              _buildField(
                label: 'Current Password',
                controller: _currentController,
                obscure: !_showCurrent,
                onToggle: _toggleCurrent,
              ),
              const SizedBox(height: 24),
              _buildField(
                label: 'New Password',
                controller: _newController,
                obscure: !_showNew,
                onToggle: _toggleNew,
                helper: 'Password must be at least 8 characters long',
              ),
              const SizedBox(height: 24),
              _buildField(
                label: 'Confirm New Password',
                controller: _confirmController,
                obscure: !_showConfirm,
                onToggle: _toggleConfirm,
              ),
              const SizedBox(height: 24),
              Text(
                'Forgot Password?',
                style: TextStyle(color: primary, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3ECFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Updating your password will keep your account secure. You will be logged out of other active sessions after updating.',
                        style: TextStyle(color: Colors.grey.shade700, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Color primary) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 8),
        const Text(
          'Change Password',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        TextButton(
          onPressed: _isSubmitting ? null : _submit,
          child: const Text(
            'Update',
            style: TextStyle(color: Color(0xFF7C4DFF), fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? helper,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE6E8EC)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  decoration: const InputDecoration(
                    hintText: '••••••••',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: 8),
          Text(
            helper,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ],
    );
  }
}
