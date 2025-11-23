import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String selectedChapter;

  const HomeScreen({super.key, required this.selectedChapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow[600]!,
                        Colors.yellow[700]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to FBLA!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.brown[900],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chapter: $selectedChapter',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.brown[800],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Quick Actions
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.people,
                      title: 'Connect',
                      color: Colors.yellow[700]!,
                      onTap: () {
                        // Navigate to connect screen
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.chat_bubble,
                      title: 'Chatbot',
                      color: Colors.orange[600]!,
                      onTap: () {
                        // Navigate to chatbot screen
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.folder,
                      title: 'Documents',
                      color: Colors.yellow[600]!,
                      onTap: () {
                        // Navigate to documents screen
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.event,
                      title: 'Events',
                      color: Colors.orange[500]!,
                      onTap: () {
                        // Navigate to events (if implemented)
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Recent Activity
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
              ),
              const SizedBox(height: 16),
              
              Card(
                child: ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.yellow[700]),
                  title: const Text('Welcome to FBLA Mobile App'),
                  subtitle: const Text('Get started by exploring the app features'),
                  trailing: Icon(Icons.chevron_right, color: Colors.brown[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

