import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();
  late Box userBox;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('userBox');
    _loadProfileData();
  }

  void _loadProfileData() {
    Box sessionBox = Hive.box('sessionBox');
    String? currentUser =
        sessionBox.get('currentUser'); // Ambil user yang login

    if (currentUser != null && userBox.containsKey(currentUser)) {
      var userData = userBox.get(currentUser);

      setState(() {
        _usernameController.text = currentUser; // Username sesuai login
        _majorController.text = userData['major'] ?? 'Ilmu Komputer';
        _dobController.text = userData['birthdate'] ?? '2005-09-08';
        _emailController.text = userData['email'] ?? 'fideligo@ristek.ui.ac.id';

        String? imagePath = userData['profileImage'];
        if (imagePath != null && File(imagePath).existsSync()) {
          _image = File(imagePath);
        }
      });
    }
  }

  void _saveProfileData() {
    Box sessionBox = Hive.box('sessionBox');
    String? currentUser = sessionBox.get('currentUser');

    if (currentUser != null) {
      userBox.put(currentUser, {
        'major': _majorController.text.trim(),
        'birthdate': _dobController.text.trim(),
        'email': _emailController.text.trim(),
        'profileImage': _image?.path,
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      userBox.put('profileImage', pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Profile",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF5038BC),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: _image == null
                      ? const NetworkImage('https://placehold.co/100x100')
                      : FileImage(_image!) as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16.0,
                    backgroundColor: const Color(0xFF5038BC),
                    child: IconButton(
                      icon: const Icon(Icons.edit,
                          color: Colors.white, size: 16.0),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ProfileField(label: 'Username', controller: _usernameController),
            ProfileField(label: 'Major', controller: _majorController),
            ProfileField(
                label: 'Date of Birth',
                controller: _dobController,
                icon: Icons.calendar_today),
            ProfileField(label: 'Email', controller: _emailController),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveProfileData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5038BC),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text('Save Profile',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;

  const ProfileField(
      {super.key, required this.label, required this.controller, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF5038BC), fontWeight: FontWeight.bold)),
          const SizedBox(height: 4.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: const Color(0xFF5038BC)),
                  const SizedBox(width: 8.0),
                ],
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
