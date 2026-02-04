import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedRole = ''; // Mặc định chọn Instructor như trong ảnh

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF), // Màu nền nhạt phía sau
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Phần Header màu xanh (Chuyển từ cột trái web sang phần trên mobile)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4F46E5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Transyncs",
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "AI-powered real-time translation for seamless learning experiences",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      _buildBulletPoint("Live translation during training"),
                      _buildBulletPoint("Support for multiple languages"),
                      _buildBulletPoint("Perfect for instructors and students"),
                    ],
                  ),
                ),

                // Phần chọn Role (Chuyển từ cột phải web xuống dưới)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Welcome to Transyncs", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text("Choose Your Role", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      const SizedBox(height: 24),

                      // Role: Student
                      _buildRoleOption(
                        title: "Student",
                        subtitle: "Access and join learning sessions",
                        icon: Icons.school_outlined,
                        isSelected: selectedRole == 'Student',
                        onTap: () => setState(() => selectedRole = 'Student'),
                      ),
                      const SizedBox(height: 16),

                      // Role: Instructor
                      _buildRoleOption(
                        title: "Instructor",
                        subtitle: "Create and manage courses",
                        icon: Icons.account_circle_outlined,
                        isSelected: selectedRole == 'Instructor',
                        onTap: () => setState(() => selectedRole = 'Instructor'),
                      ),

                      const SizedBox(height: 32),

                      // Nút Sign in
                      // Nút Sign in
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // KIỂM TRA ĐIỀU KIỆN: Nếu role là Instructor
                            if (selectedRole == 'Instructor') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                              );
                            } else if (selectedRole == 'Student') {
                              // Thông báo nếu chọn Student (vì bạn muốn ưu tiên làm trang Create trước)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Trang dành cho Student đang phát triển!")),
                              );
                            } else {
                              // Thông báo nếu chưa chọn role nào
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Vui lòng chọn vai trò Instructor để tiếp tục!")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Sign in with Google",
                              style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          "By signing in, you agree to our Terms and Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white54, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildRoleOption({required String title, required String subtitle, required IconData icon, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4F46E5) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? const Color(0xFF4F46E5) : Colors.grey.shade100,
              child: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}