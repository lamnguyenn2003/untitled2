import 'package:flutter/material.dart';
import 'create_sesion_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _emailNotifications = true;
  bool _sessionReminders = true;

  @override
  Widget build(BuildContext context) {
    // 1. Sử dụng DefaultTabController để quản lý 4 mục điều hướng
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),

        // PHẦN APPBAR (Thanh tiêu đề phía trên)
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Color(0xFF4F46E5)),
          title: const Text(
            "Transyncs",
            style: TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.grey)),
            const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF63B5E3),
              child: Text("Ln", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            const SizedBox(width: 16),
          ],
          // TabBar nằm dưới AppBar để thể hiện 4 mục
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF4F46E5),
            labelColor: Color(0xFF4F46E5),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Sessions", icon: Icon(Icons.home_outlined),),
              Tab(text: "Schedule", icon: Icon(Icons.calendar_today_outlined),),
              Tab(text: "Participants", icon: Icon(Icons.people_outline),),
              Tab(text: "Settings", icon: Icon(Icons.settings_outlined),),
            ],
          ),
        ),

        // --- PHẦN DRAWER (Thanh menu bên trái giống ảnh bạn gửi) ---
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(height: 60),
              ListTile(
                title: const Text("Transyncs",
                    style: TextStyle(color: Color(0xFF4F46E5), fontSize: 24, fontWeight: FontWeight.bold)),
                subtitle: const Text("Translation Platform"),
              ),
              const Divider(),
              const SizedBox(height: 20),

              _buildDrawerItem(Icons.home_outlined, "Sessions", true),
              _buildDrawerItem(Icons.calendar_today_outlined, "Schedule", false),
              _buildDrawerItem(Icons.people_outline, "Participants", false),
              _buildDrawerItem(Icons.settings_outlined, "Settings", false),

              const Spacer(),
              _buildDrawerItem(Icons.logout, "Sign Out", false),
              const SizedBox(height: 20),
            ],
          ),
        ),

        // --- PHẦN BODY (Nội dung thay đổi khi bấm vào Tab) ---
        body: TabBarView(
          children: [
            _buildSessionsContent(), // Trang Dashboard chính (Sessions)
            _buildScheduleContent(),
            _buildParticipantsContent(),
            _buildSettingsContent(),
          ],
        ),
      ),
    );
  }

  // Hàm xây dựng nội dung cho tab Sessions (Dashboard chính)
  Widget _buildSessionsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Learning Sessions", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Welcome back, Instructor", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateSessionScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("New Session", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              _buildStatCard("Live Sessions", "2", const Color(0xFFECFDF5), const Color(0xFF10B981), Icons.videocam),
              const SizedBox(width: 12),
              _buildStatCard("Scheduled", "4", const Color(0xFFEFF6FF), const Color(0xFF3B82F6), Icons.calendar_today),
              const SizedBox(width: 12),
              _buildStatCard("Completed", "2", const Color(0xFFFAF5FF), const Color(0xFF8B5CF6), Icons.trending_up),
            ],
          ),
          const SizedBox(height: 24),

          // --- Thanh tìm kiếm (Search Bar) ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search sessions or instructor...', // Dòng chữ gợi ý bạn muốn
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey), // Biểu tượng kính lúp
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.grey, size: 20), // Icon lọc (Status/Language)
                    onPressed: () {},
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: (value) {
                  // Xử lý logic tìm kiếm khi người dùng nhập chữ ở đây
                },
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTabItem("All", "8", false),
                _buildTabItem("Live", "2", true),
                _buildTabItem("Scheduled", "4", false),
                _buildTabItem("Past", "2", false),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildSessionCard(
            title: "French Conversation Practice",
            instructor: "John Instructor",
            lang1: "French",
            lang2: "English",
            participants: "12",
            duration: "45 min",
            isLive: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildScheduleContent(){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scheduled Sessions', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          const Text('Manage your upcoming learning sessions', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),

          _buildSectionHeader(Icons.calendar_today_outlined, "Today's Sessions"),
          const SizedBox(height: 16),
          _buildSessionsCard(
            title: "French Conversation Advanced",
            time: "2:00 PM (45 min)",
            tutor: "Pierre Dubois",
            participants: "12 participants",
            languages: "French → English",
            istoday: true,
          ),
          const SizedBox(height: 32),

          _buildSectionHeader(Icons.calendar_today_outlined, "Upcoming Sessions"),
          const SizedBox(height: 16),
          _buildSessionsCard(
            title: "German Business Language",
            time: "Jan 16, 2026 • 10:00 AM (60 min)",
            tutor: "Maria Schmidt",
            participants: "8 participants",
            languages: "German → English",
          ),
        ],
      )
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF4F46E5)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSessionsCard({required String title,String? date, required String time, required String tutor, required String participants, required String languages, bool istoday = false}){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: istoday
            ? const Border(left: BorderSide(color: Color(0xFF4F46E5), width: 5))
            : Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      padding: const EdgeInsets.all(65),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              if (istoday)
                const Badge(label: Text("Today"), backgroundColor: Color(0xFF4F46E5)),
              if (istoday)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Join Session", style: TextStyle(color: Colors.white)),
                )
              else
                Row(
                  children: [
                    OutlinedButton(onPressed: () {}, child: const Text("Details")),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _infoTile(Icons.access_time, date != null ? "$date • $time" : time),
              const SizedBox(height: 20),
              _infoTile(Icons.people_outline, participants),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _infoTile(Icons.videocam_outlined, tutor),
              const SizedBox(width: 10),
              _infoTile(Icons.translate, languages),
            ],
          ),
        ],
      ),
    );
  }
  Widget _infoTile(IconData icon, String label) {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }
  
  Widget _buildParticipantsContent(){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Participants", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Manage and view your students", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }


  Widget _buildSettingsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Settings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Manage your account preferences and settings", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),

          // --- Section: Profile Settings ---
          _buildSettingsCard(
            icon: Icons.person_outline,
            title: "Profile Settings",
            children: [
              _buildFieldLabel("Full Name"),
              _buildSettingsTextField(""),
              const SizedBox(height: 16),
              _buildFieldLabel("Email Address"),
              _buildSettingsTextField(""),
              const SizedBox(height: 16),
              _buildFieldLabel("Bio"),
              _buildSettingsTextField(""),
              const SizedBox(height: 16),
              _buildFieldLabel("Timezone"),
              _buildSettingsDropdown(""),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- Section: Language Preferences ---
          _buildSettingsCard(
            icon: Icons.language,
            title: "Language Preferences",
            children: [
              _buildFieldLabel("Primary Language"),
              _buildSettingsDropdown("English"),
            ],
          ),

          const SizedBox(height: 24),

          // --- Section: Notifications ---
          _buildSettingsCard(
            icon: Icons.notifications_none,
            title: "Notifications",
            children: [
              _buildSwitchRow(
                "Email Notifications",
                "Receive notifications via email",
                _emailNotifications,
                    (val) => setState(() => _emailNotifications = val), // Cập nhật trạng thái
              ),
              const Divider(height: 32),
              _buildSwitchRow(
                "Session Reminders",
                "Get alerted before your sessions start",
                _sessionReminders,
                    (val) => setState(() => _sessionReminders = val), // Cập nhật trạng thái
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Khung trắng bo góc cho mỗi phần Settings
  Widget _buildSettingsCard({required IconData icon, required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4F46E5), size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
    );
  }

  Widget _buildSettingsTextField(String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }

  Widget _buildSettingsDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: [DropdownMenuItem(value: value, child: Text(value))],
          onChanged: (v) {},
        ),
      ),
    );
  }

  // Thêm tham số Function(bool) vào cuối hàm
  Widget _buildSwitchRow(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged, // Sử dụng hàm callback được truyền vào
          activeColor: const Color(0xFF4F46E5),
        ),
      ],
    );
  }

  // Hàm tạo item cho Menu bên trái
  Widget _buildDrawerItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? const Color(0xFF4F46E5) : Colors.blueGrey),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF4F46E5) : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => Navigator.pop(context), // Đóng drawer khi bấm
      ),
    );
  }
  Widget _buildStatCard(String title, String count, Color bgColor, Color iconColor, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(count, style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: iconColor)),
                Icon(icon, size: 16, color: iconColor),
              ],
            ),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(
                fontSize: 11, color: iconColor.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
  Widget _buildTabItem(String label, String count, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isActive ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(width: 6),
          Text(count, style: TextStyle(color: isActive ? Colors.black45 : Colors.grey.shade400, fontSize: 12)),
        ],
      ),
    );
  }
  Widget _buildSessionCard({required String title, required String instructor, required String lang1, required String lang2, required String participants, required String duration, bool isLive = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          if (isLive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: 8),
                      SizedBox(width: 8),
                      Text("LIVE NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(backgroundColor: Colors.white, minimumSize: const Size(60, 24), padding: EdgeInsets.zero),
                    child: const Text("Join Now", style: TextStyle(color: Color(0xFF22C55E), fontSize: 12)),
                  )
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.videocam_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(instructor, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(color: const Color(0xFFF5F3FF), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(lang1, style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.translate, size: 14, color: Color(0xFF4F46E5)),
                      ),
                      Text(lang2, style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(participants, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 24),
                    const Icon(Icons.access_time, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(duration, style: const TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}