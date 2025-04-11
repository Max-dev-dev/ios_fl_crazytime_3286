// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/audio_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsOn = false;
  bool musicOn = AudioManager().isMusicOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              color: Colors.white.withOpacity(0.5),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          children: [
            const Text(
              "The Ringmaster’s Tent",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24.0),
            _buildSwitchTile(
              icon: '🔔',
              label: 'Notifications',
              value: notificationsOn,
              onChanged: (val) {
                setState(() {
                  notificationsOn = val;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              icon: '🎵',
              label: 'Background  music',
              value: musicOn,
              onChanged: (val) async {
                setState(() => musicOn = val);
                AudioManager().toggleMusic(val);
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final uri = Uri.parse('https://example.com/terms');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: _buildStaticTile(icon: '📜', label: 'Terms of Use'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF761520),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFF1B016), width: 2),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Color(0xFFF1B016),
            inactiveTrackColor: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget _buildStaticTile({required String icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF761520),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFF1B016), width: 2),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
