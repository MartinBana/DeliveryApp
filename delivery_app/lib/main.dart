import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Dalton - AI OS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0F16),
        primaryColor: const Color(0xFF7E57C2),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7E57C2),
          secondary: Color(0xFF00E5FF),
          surface: Color(0xFF161824),
        ),

        fontFamily: 'Roboto',

        // Fixed: use CardThemeData instead of CardTheme
        cardTheme: CardThemeData(
          color: const Color(0xFF161824),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white10, width: 1),
          ),
          elevation: 4,
        ),
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ChatWorkspace(),
    const ControlCenter(),
    const AgentWorkspace(),
    const GitHubWorkspace(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 70,
            color: const Color(0xFF11131C),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Logo placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7E57C2), Color(0xFF00E5FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.blur_on, color: Colors.white),
                ),
                const SizedBox(height: 40),
                _buildNavItem(Icons.chat_bubble_outline, 0, 'Chat'),
                _buildNavItem(Icons.dashboard_customize_outlined, 1, 'Control'),
                _buildNavItem(Icons.group_work_outlined, 2, 'Agents'),
                _buildNavItem(Icons.code, 3, 'GitHub'),
                const Spacer(),
                _buildNavItem(Icons.settings_outlined, -1, 'Settings'),
                const SizedBox(height: 24),
                // User Avatar
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/100?img=11',
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String tooltip) {
    final isSelected = _selectedIndex == index;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () {
          if (index != -1) setState(() => _selectedIndex = index);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E2132) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: Colors.white12) : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? const Color(0xFF00E5FF) : Colors.white54,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class ChatWorkspace extends StatelessWidget {
  const ChatWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Secondary Sidebar (Chat History & Projects)
        Container(
          width: 260,
          color: const Color(0xFF161824),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text("New Chat"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF232536),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(
                    double.infinity,
                    48,
                  ), // Fixed const Size.infinity error
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: Colors.white10),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Chat History",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildHistoryItem("Refactoring API", Icons.chat_bubble_outline),
              _buildHistoryItem(
                "Market Analysis Q3",
                Icons.chat_bubble_outline,
              ),
              _buildHistoryItem("Emetter Platform", Icons.chat_bubble_outline),
              const SizedBox(height: 24),
              const Text(
                "Active Projects",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildProjectItem("AI Assistant Platform", "72%"),
              _buildProjectItem("Home Automation", "42%"),
              const Spacer(),
              _buildAgentStatus("DevOps Agent", Colors.green),
              _buildAgentStatus("Data Engineering", Colors.orange),
            ],
          ),
        ),
        // Main Chat Area
        Expanded(
          child: Column(
            children: [
              // Chat Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Active Project: Advanced AI Assistant",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(
                          alpha: 0.1,
                        ), // Fixed withOpacity deprecation
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3),
                        ), // Fixed withOpacity
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.hub, size: 14, color: Colors.green),
                          SizedBox(width: 6),
                          Text(
                            "Agent Orchestrator: Active",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Chat Messages
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [_buildAiMessage()],
                ),
              ),
              // Input Area
              _buildChatInput(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectItem(String title, String progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.folder_outlined, size: 16, color: Color(0xFF7E57C2)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          Text(
            progress,
            style: const TextStyle(color: Color(0xFF7E57C2), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentStatus(String name, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white12,
            child: Icon(Icons.person, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF7E57C2)
                .withValues(alpha: 0.2), // Fixed withOpacity
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: Color(0xFF7E57C2),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "AI Assistant",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Hello! I'm monitoring your latest GitHub repository changes and the device telemetry. How can I help with the Advanced AI Assistant Platform project today?",
                style: TextStyle(color: Colors.white70, height: 1.5),
              ),
              const SizedBox(height: 16),
              // Mocked Telemetry Card inside Chat
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2132),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hardware Status",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildMiniGraph(
                                  "CPU",
                                  "34%",
                                  Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildMiniGraph(
                                  "RAM",
                                  "82%",
                                  Colors.orangeAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(width: 1, height: 80, color: Colors.white10),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.code, size: 16, color: Colors.white54),
                              SizedBox(width: 8),
                              Text(
                                "GitHub Commits",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildCommitItem("Recent commit", "17 mins ago"),
                          _buildCommitItem("Updated API logic", "2 hours ago"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiniGraph(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: CustomPaint(painter: WavePainter(color: color)),
        ),
      ],
    );
  }

  Widget _buildCommitItem(String title, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 10),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 10, color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2132),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2), // Fixed withOpacity
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: Colors.white54),
          const SizedBox(width: 12),
          const Icon(Icons.image_outlined, color: Colors.white54),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ask me anything, run an agent, or analyze code...",
                hintStyle: TextStyle(color: Colors.white38),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7E57C2), Color(0xFF00E5FF)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.send, color: Colors.white54),
        ],
      ),
    );
  }
}

class ControlCenter extends StatelessWidget {
  const ControlCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "AI SYSTEM CONTROL CENTER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(
                    alpha: 0.1,
                  ), // Fixed withOpacity
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "ALL SYSTEMS OPERATIONAL",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.3,
              children: [
                _buildCpuMonitor(),
                _buildRamMonitor(),
                _buildBiometricSecurity(),
                _buildToggleCard(
                  "GitHub Integration",
                  "Active - 4 repos",
                  true,
                  Colors.greenAccent,
                ),
                _buildToggleCard(
                  "Voice Assistant / Mic",
                  "Always-listening active",
                  true,
                  Colors.purpleAccent,
                ),
                _buildToggleCard(
                  "Camera & Sensors",
                  "Requires Permission",
                  false,
                  Colors.grey,
                ),
                _buildToggleCard(
                  "Web Browser & Extractor",
                  "Standby",
                  true,
                  Colors.orangeAccent,
                ),
                _buildToggleCard(
                  "Cellular & eSIM",
                  "LTE - Connected",
                  true,
                  Colors.tealAccent,
                ),
                _buildActiveAgentsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCpuMonitor() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CPU MONITOR",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CustomPaint(
                    painter: CircularProgressPainter(
                      percentage: 42,
                      color: const Color(0xFF00E5FF),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "42%",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "54°C",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Mock core usage bars
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Core $index",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: Random().nextDouble() * 0.8 + 0.1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00E5FF),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildRamMonitor() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "RAM & HOST DEVICE",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "18.4 GB / 32.0 GB (57.5%)",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.575,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF7E57C2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomPaint(
                painter: WavePainter(
                  color: const Color(0xFF7E57C2),
                  isSmooth: true,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Intel Core i9 | 32GB DDR5 | Ubuntu 24.04 LTS",
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricSecurity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BIOMETRIC SECURITY",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.fingerprint,
                    size: 60,
                    color: Colors.amberAccent,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amberAccent.withValues(alpha: 0.3),
                        width: 2,
                      ), // Fixed withOpacity
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amberAccent.withValues(alpha: 0.1),
                        width: 1,
                      ), // Fixed withOpacity
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Face Unlock: Enabled",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  "Fingerprint: Ready",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleCard(
    String title,
    String subtitle,
    bool isActive,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Switch(
                  value: isActive,
                  onChanged: (v) {},
                  activeThumbColor: color, // Fixed activeColor deprecation
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.white10,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CustomPaint(
                painter: WavePainter(
                  color: isActive ? color : Colors.white10,
                  isSmooth: true,
                ),
                size: Size.infinite, // Fixed const Size.infinite error
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveAgentsList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ACTIVE AI AGENTS",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildMiniAgentRow(
              "Software Eng.",
              "Refactoring API",
              0.84,
              Colors.teal,
            ),
            const SizedBox(height: 12),
            _buildMiniAgentRow("DevOps System", "Idle", 0.0, Colors.grey),
            const SizedBox(height: 12),
            _buildMiniAgentRow(
              "Research Intel",
              "Searching...",
              0.45,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniAgentRow(
    String name,
    String status,
    double progress,
    Color color,
  ) {
    return Row(
      children: [
        Icon(Icons.smart_toy, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                status,
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ],
          ),
        ),
        if (progress > 0)
          SizedBox(
            width: 40,
            height: 4,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              color: color,
            ),
          ),
      ],
    );
  }
}

class AgentWorkspace extends StatelessWidget {
  const AgentWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "PROJECT: OMNI-DRIVE AI",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E5FF)
                      .withValues(alpha: 0.1), // Fixed withOpacity
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
                  ), // Fixed withOpacity
                ),
                child: const Text(
                  "ORCHESTRATOR: ACTIVE",
                  style: TextStyle(color: Color(0xFF00E5FF), fontSize: 10),
                ),
              ),
              const Spacer(),
              const Text(
                "Multi-Agent Engineering Workspace",
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                // Agent List Column
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [
                      _buildAgentCard(
                        "SOFTWARE ENGINEER",
                        "SE-Agent-01",
                        "Analyzing Github repo: Omni-drive/src",
                        0.84,
                        Colors.amber,
                      ),
                      _buildAgentCard(
                        "FINANCIAL MARKETS",
                        "FM-Agent-04",
                        "Tracking global indices...",
                        0.42,
                        Colors.teal,
                      ),
                      _buildAgentCard(
                        "DEVOPS & SYSTEMS",
                        "DO-Agent-02",
                        "CI/CD Pipeline check",
                        1.0,
                        Colors.purple,
                      ),
                      _buildAgentCard(
                        "ELECTRICAL ENGINEER",
                        "EE-Agent-03",
                        "Optimizing circuit footprint",
                        0.15,
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Central Orchestrator Dashboard
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Active Agents:\n7",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Text(
                                        "Task Queue:\n14",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      Text(
                                        "Coordination Load:\n34%",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomPaint(
                                    painter: NetworkGraphPainter(),
                                    child: const Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 120),
                                          Text(
                                            "Simulate AI routing",
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "System Log",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildLogItem(
                                        "Delegated UX optimization to SE-01",
                                      ),
                                      _buildLogItem(
                                        "Delegated CI/CD check to DO-02",
                                      ),
                                      _buildLogItem(
                                        "Delegated Market Fetch to FM-04",
                                      ),
                                      _buildLogItem("Syncing global states..."),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(child: _buildProgressCard()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildTimelineCard()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentCard(
    String title,
    String id,
    String task,
    double progress,
    Color accentColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: accentColor.withValues(alpha: 0.2),
                  child: Icon(Icons.person, color: accentColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        id,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: Colors.white54, size: 16),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.sync, color: accentColor, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      progress < 1.0 ? "Busy" : "Idle",
                      style: TextStyle(color: accentColor, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              color: accentColor,
              minHeight: 4,
            ),
            const SizedBox(height: 12),
            Text(
              task,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "→ ",
            style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Global Task Progress",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CustomPaint(
                        painter: CircularProgressPainter(
                          percentage: 68,
                          color: const Color(0xFF00E5FF),
                        ),
                        child: const Center(
                          child: Text(
                            "68%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sprint",
                      style: TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CustomPaint(
                        painter: CircularProgressPainter(
                          percentage: 50,
                          color: const Color(0xFF7E57C2),
                        ),
                        child: const Center(
                          child: Text(
                            "50%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Resolution",
                      style: TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Real-time Activity Timeline",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTimelineItem(
                    "13:21",
                    "SE-Agent-01 generated pull request #114",
                    const Color(0xFF00E5FF),
                  ),
                  _buildTimelineItem(
                    "13:19",
                    "FM-Agent-04 retrieved Q3 market feed",
                    const Color(0xFF7E57C2),
                  ),
                  _buildTimelineItem(
                    "13:17",
                    "SE-Agent-01 refactored API endpoints",
                    const Color(0xFF00E5FF),
                  ),
                  _buildTimelineItem(
                    "13:15",
                    "System listening for trigger",
                    Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String time, String event, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white54, fontSize: 10),
          ),
          const SizedBox(width: 12),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              event,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class GitHubWorkspace extends StatelessWidget {
  const GitHubWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E), // VSCode style dark theme
      child: Row(
        children: [
          // File Explorer Sidebar
          Container(
            width: 250,
            color: const Color(0xFF252526),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFF333333),
                  child: const Row(
                    children: [
                      Icon(Icons.folder, color: Colors.white70, size: 16),
                      SizedBox(width: 8),
                      Text(
                        "Project Specification",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildGitAction(Icons.call_split, "main"),
                      _buildGitAction(Icons.compare_arrows, "Pull Req"),
                      _buildGitAction(Icons.history, "Commits"),
                    ],
                  ),
                ),
                const Divider(color: Colors.white10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      _buildFileTreeItem(
                        ".gitignore",
                        Icons.insert_drive_file_outlined,
                        0,
                      ),
                      _buildFileTreeItem(
                        "src",
                        Icons.folder,
                        0,
                        isFolder: true,
                      ),
                      _buildFileTreeItem(
                        "components",
                        Icons.folder,
                        1,
                        isFolder: true,
                      ),
                      _buildFileTreeItem(
                        "App.jsx",
                        Icons.javascript,
                        2,
                        isSelected: true,
                        color: Colors.yellow,
                      ),
                      _buildFileTreeItem(
                        "index.js",
                        Icons.javascript,
                        2,
                        color: Colors.yellow,
                      ),
                      _buildFileTreeItem(
                        "package.json",
                        Icons.data_object,
                        0,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Code Editor Area
          Expanded(
            child: Column(
              children: [
                // Editor Tabs
                Container(
                  height: 40,
                  color: const Color(0xFF2D2D2D),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: const Color(0xFF1E1E1E),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.javascript,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "App.jsx",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.close, color: Colors.white54, size: 14),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Last commit: 2 hrs ago by AI-Agent",
                          style: TextStyle(color: Colors.white38, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                // Code Content
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        color: const Color(0xFF1E1E1E),
                        child: const SelectableText.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFFD4D4D4),
                            ),
                            children: [
                              TextSpan(
                                text: "import ",
                                style: TextStyle(color: Color(0xFFC586C0)),
                              ),
                              TextSpan(
                                text: "React ",
                                style: TextStyle(color: Color(0xFF4FC1FF)),
                              ),
                              TextSpan(
                                text: "from ",
                                style: TextStyle(color: Color(0xFFC586C0)),
                              ),
                              TextSpan(
                                text: "'react';\n",
                                style: TextStyle(color: Color(0xFFCE9178)),
                              ),

                              TextSpan(
                                text: "\nexport default function ",
                                style: TextStyle(color: Color(0xFF569CD6)),
                              ),
                              TextSpan(
                                text: "App",
                                style: TextStyle(color: Color(0xFFDCDCAA)),
                              ),
                              TextSpan(text: "() {\n"),

                              TextSpan(
                                text: "  const ",
                                style: TextStyle(color: Color(0xFF569CD6)),
                              ),
                              TextSpan(
                                text: "data ",
                                style: TextStyle(color: Color(0xFF4FC1FF)),
                              ),
                              TextSpan(
                                text: "= ",
                                style: TextStyle(color: Color(0xFFD4D4D4)),
                              ),
                              TextSpan(
                                text: "fetchData",
                                style: TextStyle(color: Color(0xFFDCDCAA)),
                              ),
                              TextSpan(text: "();\n\n"),

                              TextSpan(
                                text: "  return (\n",
                                style: TextStyle(color: Color(0xFFC586C0)),
                              ),
                              TextSpan(
                                text: "    <div ",
                                style: TextStyle(color: Color(0xFF808080)),
                              ),
                              TextSpan(
                                text: "className",
                                style: TextStyle(color: Color(0xFF9CDCFE)),
                              ),
                              TextSpan(
                                text: "=",
                                style: TextStyle(color: Color(0xFFD4D4D4)),
                              ),
                              TextSpan(
                                text: "\"app-container\"",
                                style: TextStyle(color: Color(0xFFCE9178)),
                              ),
                              TextSpan(
                                text: ">\n",
                                style: TextStyle(color: Color(0xFF808080)),
                              ),

                              TextSpan(
                                text: "      <DataView ",
                                style: TextStyle(color: Color(0xFF4EC9B0)),
                              ),
                              TextSpan(
                                text: "source",
                                style: TextStyle(color: Color(0xFF9CDCFE)),
                              ),
                              TextSpan(
                                text: "=",
                                style: TextStyle(color: Color(0xFFD4D4D4)),
                              ),
                              TextSpan(
                                text: "{data}",
                                style: TextStyle(color: Color(0xFF9CDCFE)),
                              ),
                              TextSpan(
                                text: " />\n",
                                style: TextStyle(color: Color(0xFF808080)),
                              ),

                              TextSpan(
                                text: "    </div>\n",
                                style: TextStyle(color: Color(0xFF808080)),
                              ),
                              TextSpan(text: "  );\n}\n"),
                            ],
                          ),
                        ),
                      ),
                      // AI Refactoring Overlay Mock
                      Positioned(
                        top: 100,
                        left: 16,
                        right: 60,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF003366)
                                .withValues(alpha: 0.5), // Fixed withOpacity
                            border: Border.all(color: const Color(0xFF007ACC)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: Color(0xFF00E5FF),
                                    size: 14,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Suggested Refactor: Async/Await with error handling",
                                    style: TextStyle(
                                      color: Color(0xFF00E5FF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // AI Assistant Sidebar
          Container(
            width: 320,
            decoration: const BoxDecoration(
              // Fixed Container border parameter error
              color: Color(0xFF252526),
              border: Border(left: BorderSide(color: Colors.white10)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    // Fixed Border assigned to Decoration error
                    border: Border(bottom: BorderSide(color: Colors.white10)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.smart_toy, color: Color(0xFF7E57C2)),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Developer Agent",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Online • Analysis Active",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildDeveloperChatMessage(
                        "User",
                        "Can we refactor the fetch data logic in App.jsx to use async/await and optimize error handling?",
                        isUser: true,
                      ),
                      _buildDeveloperChatMessage(
                        "AI Developer",
                        "Here's a refactored version of the data fetching logic using async/await with robust error handling states.",
                        isUser: false,
                      ),
                      // Diff viewer mock
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.red.withValues(
                                alpha: 0.1,
                              ), // Fixed withOpacity
                              width: double.infinity,
                              child: const Text(
                                "- const data = fetchData();",
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.green.withValues(
                                alpha: 0.1,
                              ), // Fixed withOpacity
                              width: double.infinity,
                              child: const Text(
                                "+ const [data, setData] = useState(null);\n+ useEffect(() => {\n+   const load = async () => {\n+     try { ... } catch (e) { ... }\n+   }\n+ }, []);",
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  color: Colors.greenAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7E57C2),
                              ),
                              child: const Text(
                                "Apply Changes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                "Preview Diff",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFF1E1E1E),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Ask AI Assistant...",
                      hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      suffixIcon: Icon(
                        Icons.send,
                        color: Colors.white54,
                        size: 16,
                      ),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGitAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white54, size: 18),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildFileTreeItem(
    String name,
    IconData icon,
    int depth, {
    bool isFolder = false,
    bool isSelected = false,
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.only(left: depth * 16.0, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white10 : Colors.transparent,
      ),
      child: Row(
        children: [
          if (isFolder)
            const Icon(Icons.arrow_drop_down, color: Colors.white54, size: 16)
          else
            const SizedBox(width: 16),
          Icon(icon, color: color ?? Colors.white54, size: 16),
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperChatMessage(
    String sender,
    String text, {
    required bool isUser,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: isUser
                ? Colors.blueGrey
                : const Color(0xFF7E57C2)
                      .withValues(alpha: 0.3), // Fixed withOpacity
            child: Icon(
              isUser ? Icons.person : Icons.smart_toy,
              size: 14,
              color: isUser ? Colors.white : const Color(0xFF7E57C2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.4,
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

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;

  CircularProgressPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 8;

    final bgPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start at top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  final Color color;
  final bool isSmooth;

  WavePainter({required this.color, this.isSmooth = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final random = Random(42); // Fixed seed for stable UI rendering

    path.moveTo(0, size.height / 2);

    for (double i = 0; i <= size.width; i += size.width / 20) {
      final y =
          (size.height / 2) +
          (random.nextDouble() *
              size.height /
              2 *
              (random.nextBool() ? 1 : -1));
      if (isSmooth) {
        // Simplified bezier curve approximation for smooth waves
        path.quadraticBezierTo(i - (size.width / 40), y, i, y);
      } else {
        path.lineTo(i, y);
      }
    }

    // Add gradient fill under the line
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.3),
          Colors.transparent,
        ], // Fixed withOpacity
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NetworkGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 20;

    final nodePaint = Paint()
      ..color = const Color(0xFF00E5FF)
      ..style = PaintingStyle.fill;
    final edgePaint = Paint()
      ..color = Colors.white12
      ..strokeWidth = 1;
    final activeEdgePaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.5)
      ..strokeWidth = 2; // Fixed withOpacity

    final int numNodes = 12;
    List<Offset> nodes = [];

    // Inner core
    canvas.drawCircle(
      center,
      25,
      Paint()
        ..color = const Color(0xFF00E5FF).withValues(alpha: 0.1)
        ..style = PaintingStyle.fill,
    ); // Fixed
    canvas.drawCircle(
      center,
      15,
      Paint()
        ..color = const Color(0xFF00E5FF).withValues(alpha: 0.3)
        ..style = PaintingStyle.fill,
    ); // Fixed
    canvas.drawCircle(center, 5, nodePaint);

    // Outer nodes
    for (int i = 0; i < numNodes; i++) {
      final angle = (2 * pi * i) / numNodes;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      nodes.add(Offset(x, y));
    }

    // Draw edges
    for (int i = 0; i < nodes.length; i++) {
      canvas.drawLine(
        center,
        nodes[i],
        i % 3 == 0 ? activeEdgePaint : edgePaint,
      );
      for (int j = i + 1; j < nodes.length; j++) {
        if ((i - j).abs() == 1 ||
            (i - j).abs() == numNodes - 1 ||
            i % 4 == j % 4) {
          canvas.drawLine(nodes[i], nodes[j], edgePaint);
        }
      }
    }

    // Draw nodes
    for (var node in nodes) {
      canvas.drawCircle(node, 4, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
