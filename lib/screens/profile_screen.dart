import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String selectedChapter;
  final VoidCallback onSignOut;

  const ProfileScreen({
    super.key,
    required this.selectedChapter,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.brown[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.yellow[50]!,
              Colors.yellow[100]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow[600]!,
                      Colors.yellow[700]!,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.brown[900],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.yellow[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'FBLA Member',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.brown[900],
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedChapter,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.brown[800],
                          ),
                    ),
                  ],
                ),
              ),
            
              // Profile Information
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProfileSection(
                      title: 'Chapter Information',
                      children: [
                        _InfoTile(
                          icon: Icons.school,
                          label: 'Chapter',
                          value: selectedChapter,
                        ),
                        _InfoTile(
                          icon: Icons.location_on,
                          label: 'Region',
                          value: 'United States',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    _ProfileSection(
                      title: 'Account',
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.yellow[700]),
                          title: const Text('Settings'),
                          trailing: Icon(Icons.chevron_right, color: Colors.brown[800]),
                          onTap: () {
                            // Navigate to settings
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help_outline, color: Colors.yellow[700]),
                          title: const Text('Help & Support'),
                          trailing: Icon(Icons.chevron_right, color: Colors.brown[800]),
                          onTap: () {
                            // Navigate to help
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info_outline, color: Colors.yellow[700]),
                          title: const Text('About'),
                          trailing: Icon(Icons.chevron_right, color: Colors.brown[800]),
                          onTap: () {
                            // Show about dialog
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Sign Out Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.yellow[50],
                              title: Text(
                                'Sign Out',
                                style: TextStyle(color: Colors.brown[900]),
                              ),
                              content: Text(
                                'Are you sure you want to sign out?',
                                style: TextStyle(color: Colors.brown[800]),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.brown[800]),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    onSignOut();
                                  },
                                  child: Text(
                                    'Sign Out',
                                    style: TextStyle(color: Colors.yellow[800]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.logout, color: Colors.brown[800]),
                        label: Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.brown[800]),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(
                            color: Colors.brown[800]!,
                          ),
                        ),
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
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown[900],
              ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.yellow[700]),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

