import 'package:flutter/material.dart';
import '../widgets/user_info_tile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String name = 'Willy';
  String email = 'willy@email.com';
  String bio = 'Mobile Developer | Flutter Enthusiast | Loves UI/UX';
  String photoUrl = 'https://randomuser.me/api/portraits/men/32.jpg';

  @override
  void initState() {
    super.initState();
    print('UserProfileScreen initState');
  }

  @override
  void dispose() {
    print('UserProfileScreen dispose');
    super.dispose();
  }

  void _editProfile() async {
    final result = await Navigator.pushNamed(
      context,
      '/edit',
      arguments: {
        'name': name,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
      },
    );
    if (result != null && result is Map) {
      setState(() {
        name = result['name'] ?? name;
        email = result['email'] ?? email;
        bio = result['bio'] ?? bio;
        photoUrl = result['photoUrl'] ?? photoUrl;
      });
    }
  }

  void _onPhotoTap() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Foto profil $name')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editProfile),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _onPhotoTap,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(photoUrl),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    UserInfoTile(
                      icon: Icons.person,
                      label: 'Nama',
                      value: name,
                    ),
                    UserInfoTile(
                      icon: Icons.email,
                      label: 'Email',
                      value: email,
                    ),
                    UserInfoTile(
                      icon: Icons.info_outline,
                      label: 'Bio',
                      value: bio,
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
}
