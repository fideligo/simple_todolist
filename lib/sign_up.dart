import 'package:flutter/material.dart';
import 'package:simple_todolist/login_page.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  void signUp() {
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String major = _majorController.text.trim();
    String birthdate = _birthdateController.text.trim();

    // Validasi input
    if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        major.isEmpty ||
        birthdate.isEmpty) {
      _showDialog("Error", "Semua kolom harus diisi!");
      return;
    }
    if (!email.contains("@") || !email.contains(".")) {
      _showDialog("Error", "Masukkan email yang valid.");
      return;
    }
    if (username.contains(" ") || username.length < 3) {
      _showDialog(
          "Error", "Username tidak boleh ada spasi & minimal 3 karakter.");
      return;
    }
    if (password.length < 6) {
      _showDialog("Error", "Password harus minimal 6 karakter.");
      return;
    }

    var userBox = Hive.box('userBox');

    if (userBox.containsKey(username)) {
      _showDialog("Error", "Username sudah terdaftar!");
    } else {
      userBox.put(username, {
        'email': email,
        'password': password,
        'major': major,
        'birthdate': birthdate,
      });

      _showDialog("Success", "Sign-up berhasil! Silakan login.",
          isSuccess: true);
    }
  }

  void _showDialog(String title, String message, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              if (isSuccess) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5038BC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tudulis",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold)),
              const Text("Turn your to-dos into done.",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: "Poppins")),
              const SizedBox(height: 20),
              _buildInputField(
                  "Email", _emailController, "example123@example.com"),
              _buildInputField(
                  "Username", _usernameController, "Choose a username"),
              _buildInputField(
                  "Password", _passwordController, "Enter your password",
                  isPassword: true),
              _buildInputField("Major", _majorController, "Enter your major"),
              _buildDatePickerField(
                  "Birthdate", _birthdateController, "Select your birthdate"),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF5038BC)))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Poppins")),
                  TextButton(
                    child: const Text('Log in',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, String hint,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 11),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerField(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.text.isNotEmpty ? controller.text : hint,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.black)),
                  const Icon(Icons.calendar_today,
                      color: Colors.grey, size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
