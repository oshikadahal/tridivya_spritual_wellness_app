import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/login_page.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen_layout.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/edit_profile_page.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _imagePicker = ImagePicker();
  String? userName;
  String? userEmail;
  String? userProfilePicture;
  final List<String> _sessionTabs = ['Yoga', 'Meditation', 'Mantra', 'Pranayama'];
  int _selectedSessionTab = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userSessionService = ref.read(userSessionServiceProvider);
    setState(() {
      userName = userSessionService.getCurrentUserFullName() ?? 'Guest User';
      userEmail = userSessionService.getCurrentUserEmail() ?? '';
      userProfilePicture = userSessionService.getCurrentUserProfilePicture();
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 68,
                        width: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE8E8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.error_outline, color: Colors.red, size: 38),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.of(dialogCtx).pop(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'You will be logged out of your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFFCBD2D9)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Navigator.of(dialogCtx).pop(),
                        child: const Text('Cancel', style: TextStyle(color: Color(0xFF4B5563), fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: const Color(0xFFFF4D4F),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          Navigator.of(dialogCtx).pop();
                          await ref.read(authViewModelProvider.notifier).logout();
                          await ref.read(userSessionServiceProvider).clearUserSession();
                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                            );
                          }
                        },
                        child: const Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _uploadProfileImage(File image) async {
    try {
      final uploadedPath = await ref.read(authViewModelProvider.notifier).updateProfileImage(image);
      if (uploadedPath != null && mounted) {
        await ref.read(userSessionServiceProvider).updateProfilePicture(uploadedPath);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile image updated successfully!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
        await _uploadProfileImage(File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
        await _uploadProfileImage(File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error capturing image: $e')),
        );
      }
    }
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Choose Photo',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Upload from Photos'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Open Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF7C4DFF);
    const muted = Color(0xFF6E6B7B);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3FF),
      bottomNavigationBar: _buildBottomNav(context, primary),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(primary),
              const SizedBox(height: 16),
              _buildProfileCard(primary, muted),
              const SizedBox(height: 24),
              _buildSectionTitle('Account Details'),
              const SizedBox(height: 14),
              _buildAccountDetailsCard(muted),
              const SizedBox(height: 26),
              _buildSectionTitle('My Saved Sessions', trailing: 'View All'),
              const SizedBox(height: 12),
              _buildSessionTabs(primary, muted),
              const SizedBox(height: 14),
              _buildSavedSessions(primary, muted),
              const SizedBox(height: 28),
              _buildSectionTitle('Security Settings'),
              const SizedBox(height: 14),
              _buildSecurityCard(
                title: 'Change Password',
                icon: Icons.lock_reset_outlined,
                primary: primary,
                muted: muted,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildLogoutCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color primary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        Text(
          'Tridivya',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: primary,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 26, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileCard(Color primary, Color muted) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _showImagePickerBottomSheet,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: const Color(0xFFEFE7FF),
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : (userProfilePicture != null
                              ? NetworkImage(userProfilePicture!) as ImageProvider
                              : const AssetImage('assets/images/onboarding.png')),
                    ),
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName ?? 'Guest User',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail?.isNotEmpty == true ? '@${userEmail?.split('@').first}' : '@manisha12',
                      style: TextStyle(color: muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1CC88A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                onPressed: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                  if (updated == true && mounted) {
                    _loadUserData();
                  }
                },
                child: const Text('Edit Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: 0,
            onTap: (index) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BottomScreenLayout(initialIndex: index),
                ),
              );
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.spa_outlined), label: 'Meditation'),
              BottomNavigationBarItem(icon: Icon(Icons.fitness_center_outlined), label: 'Yoga'),
              BottomNavigationBarItem(icon: Icon(Icons.music_note_outlined), label: 'Mantra'),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Library'),
            ],
            unselectedItemColor: const Color(0xFF9AA3B5),
            selectedItemColor: primary,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: const TextStyle(color: Color(0xFF7C4DFF), fontWeight: FontWeight.w700),
          ),
      ],
    );
  }

  Widget _buildAccountDetailsCard(Color muted) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildReadonlyField('First Name', (userName ?? 'Manisha').split(' ').first, muted)),
              const SizedBox(width: 12),
              Expanded(child: _buildReadonlyField('Last Name', (userName ?? 'Sapkota').split(' ').skip(1).join(' '), muted)),
            ],
          ),
          const SizedBox(height: 12),
          _buildReadonlyField('Email', userEmail ?? 'manisha12@gmail.com', muted),
          const SizedBox(height: 12),
          _buildReadonlyField('Username', userEmail?.isNotEmpty == true ? '@${userEmail?.split('@').first}' : '@manisha12', muted),
        ],
      ),
    );
  }

  Widget _buildReadonlyField(String label, String value, Color muted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: muted, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7FB),
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionTabs(Color primary, Color muted) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_sessionTabs.length, (index) {
          final selected = _selectedSessionTab == index;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(
                _sessionTabs[index],
                style: TextStyle(
                  color: selected ? Colors.white : muted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              selected: selected,
              onSelected: (_) => setState(() => _selectedSessionTab = index),
              selectedColor: primary,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSavedSessions(Color primary, Color muted) {
    final sessions = [
      {
        'title': 'Morning Sun Salutation',
        'level': 'Beginner • Vinyasa',
        'time': '15:00',
        'image': 'assets/images/light_of_yoga.jpg',
      },
      {
        'title': 'Deep Relax Stretch',
        'level': 'Intermediate • Yin',
        'time': '22:00',
        'image': 'assets/images/onboarding1.png',
      },
    ];

    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sessions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = sessions[index];
          return Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image.asset(
                      item['image'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1EBFF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        _sessionTabs[_selectedSessionTab],
                        style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: muted),
                        const SizedBox(width: 4),
                        Text(item['time'] as String, style: TextStyle(color: muted, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  item['level'] as String,
                  style: TextStyle(color: muted, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSecurityCard({
    required String title,
    required IconData icon,
    required Color primary,
    required Color muted,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFEFE7FF),
              child: Icon(icon, color: primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 18, color: muted),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutCard() {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0F2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFCDD2)),
        ),
        child: Row(
          children: const [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.logout, color: Colors.red),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.red),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
