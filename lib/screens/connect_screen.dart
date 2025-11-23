import 'package:flutter/material.dart';
import 'dart:math' as math;

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Sample data - replace with your actual data source
  final List<Person> _myChapterMembers = [
    Person(id: '1', name: 'You', chapter: 'Your Chapter', isCurrentUser: true),
    Person(id: '2', name: 'Alex', chapter: 'Your Chapter'),
    Person(id: '3', name: 'Sam', chapter: 'Your Chapter'),
    Person(id: '4', name: 'Jordan', chapter: 'Your Chapter'),
    Person(id: '5', name: 'Taylor', chapter: 'Your Chapter'),
    Person(id: '6', name: 'Casey', chapter: 'Your Chapter'),
  ];
  
  final List<Person> _connectedChapters = [
    Person(id: '7', name: 'Emma', chapter: 'Chapter A'),
    Person(id: '8', name: 'Noah', chapter: 'Chapter A'),
    Person(id: '9', name: 'Olivia', chapter: 'Chapter B'),
    Person(id: '10', name: 'Liam', chapter: 'Chapter B'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Hive'),
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
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search members, chapters, or topics...',
                  prefixIcon: Icon(Icons.search, color: Colors.brown[800]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.yellow[800]!),
                  ),
                  filled: true,
                  fillColor: Colors.yellow[50],
                ),
                onChanged: (value) {
                  setState(() {
                    // Filter logic here
                  });
                },
              ),
            ),
            
            // Honeycomb Hive Visualization
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Your Chapter Hive
                    _buildHiveSection(
                      title: 'Your Chapter',
                      members: _myChapterMembers,
                      isMainHive: true,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Connected Chapters
                    if (_connectedChapters.isNotEmpty)
                      _buildHiveSection(
                        title: 'Connected Chapters',
                        members: _connectedChapters,
                        isMainHive: false,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHiveSection({
    required String title,
    required List<Person> members,
    required bool isMainHive,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isMainHive ? Colors.brown[900] : Colors.orange[800],
            ),
          ),
        ),
        const SizedBox(height: 16),
        HoneycombGrid(
          members: members,
          isMainHive: isMainHive,
          onPersonTap: (person) {
            _showPersonDetails(person);
          },
        ),
      ],
    );
  }

  void _showPersonDetails(Person person) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.yellow[50],
        title: Text(
          person.name,
          style: TextStyle(color: Colors.brown[900]),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chapter: ${person.chapter}',
              style: TextStyle(color: Colors.brown[800]),
            ),
            if (person.isCurrentUser)
              Text(
                '(You)',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.brown[700],
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: Colors.brown[800]),
            ),
          ),
          if (!person.isCurrentUser)
            TextButton(
              onPressed: () {
                // Handle connection action
                Navigator.pop(context);
              },
              child: Text(
                'Connect',
                style: TextStyle(color: Colors.yellow[800]),
              ),
            ),
        ],
      ),
    );
  }
}

// Person Model
class Person {
  final String id;
  final String name;
  final String chapter;
  final bool isCurrentUser;

  Person({
    required this.id,
    required this.name,
    required this.chapter,
    this.isCurrentUser = false,
  });
}

// Honeycomb Grid Widget
class HoneycombGrid extends StatefulWidget {
  final List<Person> members;
  final bool isMainHive;
  final Function(Person) onPersonTap;

  const HoneycombGrid({
    super.key,
    required this.members,
    required this.isMainHive,
    required this.onPersonTap,
  });

  @override
  State<HoneycombGrid> createState() => _HoneycombGridState();
}

class _HoneycombGridState extends State<HoneycombGrid> {
  List<Offset>? _positions;
  Size? _containerSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculatePositions();
    });
  }

  void _calculatePositions() {
    if (_containerSize == null) return;
    
    final centerX = _containerSize!.width / 2;
    final centerY = _containerSize!.height / 2;
    _positions = _calculateHoneycombPositions(
      widget.members.length,
      centerX,
      centerY,
    );
    setState(() {});
  }

  List<Offset> _calculateHoneycombPositions(int count, double centerX, double centerY) {
    final positions = <Offset>[];
    
    if (count == 0) return positions;
    if (count == 1) {
      return [Offset(centerX, centerY)];
    }

    // Honeycomb pattern: center cell, then rings around it
    positions.add(Offset(centerX, centerY)); // Center

    // First ring (6 cells around center)
    final firstRingRadius = HoneycombPainter.hexRadius * 2 + HoneycombPainter.hexSpacing;
    for (int i = 1; i < count && i <= 7; i++) {
      if (i == 1) {
        positions.add(Offset(centerX, centerY - firstRingRadius));
      } else {
        final angle = (i - 1) * (2 * math.pi / 6);
        positions.add(Offset(
          centerX + firstRingRadius * math.sin(angle),
          centerY - firstRingRadius * math.cos(angle),
        ));
      }
    }

    // Second ring (12 cells)
    if (count > 7) {
      final secondRingRadius = firstRingRadius * 2;
      for (int i = 7; i < count && i <= 19; i++) {
        final angle = (i - 7) * (2 * math.pi / 12);
        positions.add(Offset(
          centerX + secondRingRadius * math.sin(angle),
          centerY - secondRingRadius * math.cos(angle),
        ));
      }
    }

    return positions;
  }

  double _calculateHeight(int memberCount) {
    // Approximate height calculation based on number of members
    if (memberCount <= 1) return 150;
    if (memberCount <= 3) return 200;
    if (memberCount <= 7) return 300;
    if (memberCount <= 12) return 400;
    return 500;
  }

  Person? _getPersonAtPosition(Offset position) {
    if (_positions == null) return null;
    
    for (int i = 0; i < _positions!.length && i < widget.members.length; i++) {
      final distance = (position - _positions![i]).distance;
      if (distance < HoneycombPainter.hexRadius) {
        return widget.members[i];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.members.isEmpty) return const SizedBox.shrink();

    final height = _calculateHeight(widget.members.length);

    return GestureDetector(
      onTapDown: (details) {
        final tappedPerson = _getPersonAtPosition(details.localPosition);
        if (tappedPerson != null) {
          widget.onPersonTap(tappedPerson);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          _containerSize = Size(constraints.maxWidth, height);
          if (_positions == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _calculatePositions();
            });
          }
          
          return CustomPaint(
            painter: HoneycombPainter(
              members: widget.members,
              isMainHive: widget.isMainHive,
              positions: _positions ?? [],
            ),
            child: Container(
              height: height,
              padding: const EdgeInsets.all(20),
            ),
          );
        },
      ),
    );
  }
}

// Custom Painter for Honeycomb
class HoneycombPainter extends CustomPainter {
  final List<Person> members;
  final bool isMainHive;
  final List<Offset> positions;

  static const double hexRadius = 30.0;
  static const double hexSpacing = 5.0;

  HoneycombPainter({
    required this.members,
    required this.isMainHive,
    required this.positions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (members.isEmpty || positions.isEmpty) return;

    for (int i = 0; i < members.length && i < positions.length; i++) {
      final position = positions[i];
      _drawHexagon(
        canvas,
        position.dx,
        position.dy,
        members[i],
        isMainHive,
      );
    }
  }

  void _drawHexagon(Canvas canvas, double x, double y, Person person, bool isMainHive) {
    // Bee-themed colors: golden yellow for main hive, lighter yellow/orange for connected
    final paint = Paint()
      ..color = isMainHive 
          ? Colors.yellow[600]!.withOpacity(0.4)
          : Colors.orange[300]!.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = isMainHive ? Colors.brown[900]! : Colors.orange[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Draw hexagon
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i;
      final hexX = x + hexRadius * math.cos(angle);
      final hexY = y + hexRadius * math.sin(angle);
      if (i == 0) {
        path.moveTo(hexX, hexY);
      } else {
        path.lineTo(hexX, hexY);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    // Draw person initial/avatar with bee-themed colors
    final textPainter = TextPainter(
      text: TextSpan(
        text: person.isCurrentUser ? '🐝' : person.name[0].toUpperCase(),
        style: TextStyle(
          color: isMainHive ? Colors.brown[900] : Colors.orange[900],
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

