import 'package:flutter/material.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect with Others'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search members, chapters, or topics...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          
          // Filter Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(label: 'All Chapters', isSelected: true),
                const SizedBox(width: 8),
                _FilterChip(label: 'My Chapter', isSelected: false),
                const SizedBox(width: 8),
                _FilterChip(label: 'Nearby', isSelected: false),
                const SizedBox(width: 8),
                _FilterChip(label: 'Competitions', isSelected: false),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Connection Options
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _ConnectionCard(
                  icon: Icons.people,
                  title: 'Find Members',
                  subtitle: 'Connect with FBLA members from your chapter',
                  color: Colors.blue,
                  onTap: () {
                    // Navigate to members list
                  },
                ),
                const SizedBox(height: 12),
                _ConnectionCard(
                  icon: Icons.forum,
                  title: 'Discussion Forums',
                  subtitle: 'Join conversations and share ideas',
                  color: Colors.green,
                  onTap: () {
                    // Navigate to forums
                  },
                ),
                const SizedBox(height: 12),
                _ConnectionCard(
                  icon: Icons.event,
                  title: 'Upcoming Events',
                  subtitle: 'See events and meetups in your area',
                  color: Colors.orange,
                  onTap: () {
                    // Navigate to events
                  },
                ),
                const SizedBox(height: 12),
                _ConnectionCard(
                  icon: Icons.group_work,
                  title: 'Study Groups',
                  subtitle: 'Form study groups for competitions',
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to study groups
                  },
                ),
                const SizedBox(height: 12),
                _ConnectionCard(
                  icon: Icons.emoji_events,
                  title: 'Competition Teams',
                  subtitle: 'Find teammates for competitions',
                  color: Colors.amber,
                  onTap: () {
                    // Navigate to competition teams
                  },
                ),
                const SizedBox(height: 12),
                _ConnectionCard(
                  icon: Icons.leaderboard,
                  title: 'Leaderboard',
                  subtitle: 'See top performers and achievements',
                  color: Colors.red,
                  onTap: () {
                    // Navigate to leaderboard
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
      },
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ConnectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

