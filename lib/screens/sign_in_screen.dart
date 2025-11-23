import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final Function(String) onSignIn;

  const SignInScreen({super.key, required this.onSignIn});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _selectedChapter;

  final List<String> _fblaChapters = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
    'District of Columbia',
    'Puerto Rico',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // FBLA Logo/Title with bee theme
                Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.yellow[700],
                ),
                const SizedBox(height: 16),
                Text(
                  'FBLA Mobile App',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[900],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Future Business Leaders of America',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.brown[700],
                      ),
                ),
                const SizedBox(height: 48),
                
                // Chapter Selection
                Text(
                  'Select Your FBLA Chapter',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[900],
                      ),
                ),
                const SizedBox(height: 16),
                
                // Dropdown for chapter selection
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow[800]!),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.yellow[50],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Choose your chapter',
                        style: TextStyle(color: Colors.brown[700]),
                      ),
                      value: _selectedChapter,
                      items: _fblaChapters.map((chapter) {
                        return DropdownMenuItem<String>(
                          value: chapter,
                          child: Text(
                            chapter,
                            style: TextStyle(color: Colors.brown[900]),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedChapter = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Sign In Button
                ElevatedButton(
                  onPressed: _selectedChapter == null
                      ? null
                      : () {
                          widget.onSignIn(_selectedChapter!);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.brown[900],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

