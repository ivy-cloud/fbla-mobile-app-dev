import 'package:flutter/material.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<DocumentCategory> _categories = [
    DocumentCategory(
      title: 'Competition Guidelines',
      icon: Icons.emoji_events,
      color: Colors.amber,
      documents: [
        'FBLA Competitive Events Guidelines 2024',
        'Competition Rules and Regulations',
        'Scoring Rubrics',
        'Event Preparation Checklist',
      ],
    ),
    DocumentCategory(
      title: 'Chapter Resources',
      icon: Icons.school,
      color: Colors.blue,
      documents: [
        'Chapter Handbook',
        'Officer Responsibilities',
        'Meeting Templates',
        'Fundraising Ideas',
      ],
    ),
    DocumentCategory(
      title: 'Study Materials',
      icon: Icons.book,
      color: Colors.green,
      documents: [
        'Business Fundamentals Study Guide',
        'Economics Review Materials',
        'Marketing Concepts',
        'Financial Planning Resources',
      ],
    ),
    DocumentCategory(
      title: 'Forms & Applications',
      icon: Icons.description,
      color: Colors.orange,
      documents: [
        'Membership Application',
        'Event Registration Form',
        'Travel Request Form',
        'Expense Reimbursement',
      ],
    ),
    DocumentCategory(
      title: 'Policies & Procedures',
      icon: Icons.gavel,
      color: Colors.purple,
      documents: [
        'Code of Conduct',
        'Dress Code Policy',
        'Competition Ethics',
        'Disciplinary Procedures',
      ],
    ),
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
        title: const Text('FBLA Documents'),
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
                hintText: 'Search documents...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          
          // Document Categories
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _DocumentCategoryCard(category: _categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> documents;

  DocumentCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.documents,
  });
}

class _DocumentCategoryCard extends StatefulWidget {
  final DocumentCategory category;

  const _DocumentCategoryCard({required this.category});

  @override
  State<_DocumentCategoryCard> createState() => _DocumentCategoryCardState();
}

class _DocumentCategoryCardState extends State<_DocumentCategoryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.category.icon,
                color: widget.category.color,
              ),
            ),
            title: Text(
              widget.category.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text('${widget.category.documents.length} documents'),
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            ...widget.category.documents.map((doc) => _DocumentItem(
                  document: doc,
                  color: widget.category.color,
                )),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String document;
  final Color color;

  const _DocumentItem({
    required this.document,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle document download/view
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening: $document'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.insert_drive_file, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                document,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.download, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Downloading: $document'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

