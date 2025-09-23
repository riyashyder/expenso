import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF2E2E2E),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 20),
            const Text(
              'Expenso\n1.0-free',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.white30, height: 30),
            _buildTile(Icons.settings, 'Preferences'),
            const SizedBox(height: 10),
            const Text('Management', style: TextStyle(color: Colors.white54, fontSize: 14)),
            _buildTile(Icons.file_upload_outlined, 'Export records'),
            _buildTile(Icons.backup_outlined, 'Backup & Restore'),
            _buildTile(Icons.delete_forever_outlined, 'Delete & Reset'),
            const SizedBox(height: 20),
            const Text('Application', style: TextStyle(color: Colors.white54, fontSize: 14)),
            _buildTile(Icons.star_border, 'Pro version'),
            _buildTile(Icons.thumb_up_off_alt, 'Like MyMoney'),
            _buildTile(Icons.help_outline, 'Help'),
            _buildTile(Icons.mail_outline, 'Feedback'),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE9E362)),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        // Add navigation or functionality
      },
    );
  }
}
