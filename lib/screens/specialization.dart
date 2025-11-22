import 'package:flutter/material.dart';

class ChooseSpecialtyScreen extends StatefulWidget {
  const ChooseSpecialtyScreen({super.key});

  @override
  _ChooseSpecialtyScreenState createState() => _ChooseSpecialtyScreenState();
}

class _ChooseSpecialtyScreenState extends State<ChooseSpecialtyScreen> {
  String? _selectedSpecialty;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _specialties = [
    {
      'name': 'Cardiology',
      'icon': Icons.favorite_border,
      'color': Colors.red,
    },
    {
      'name': 'Neurology',
      'icon': Icons.psychology_outlined,
      'color': Colors.purple,
    },
    {
      'name': 'Pediatrics',
      'icon': Icons.child_care_outlined,
      'color': Colors.blue,
    },
    {
      'name': 'Orthopedics',
      'icon': Icons.accessible_outlined,
      'color': Colors.orange,
    },
    {
      'name': 'Dermatology',
      'icon': Icons.spa_outlined,
      'color': Colors.pink,
    },
    {
      'name': 'Psychiatry',
      'icon': Icons.psychology_outlined,
      'color': Colors.indigo,
    },
    {
      'name': 'Surgery',
      'icon': Icons.medical_services_outlined,
      'color': Colors.redAccent,
    },
    {
      'name': 'Oncology',
      'icon': Icons.healing_outlined,
      'color': Colors.green,
    },
    {
      'name': 'Radiology',
      'icon': Icons.scanner_outlined,
      'color': Colors.blueGrey,
    },
    {
      'name': 'Emergency Medicine',
      'icon': Icons.emergency_outlined,
      'color': Colors.red,
    },
    {
      'name': 'Family Medicine',
      'icon': Icons.people_outline,
      'color': Colors.teal,
    },
    {
      'name': 'Internal Medicine',
      'icon': Icons.monitor_heart_outlined,
      'color': Colors.blue,
    },
  ];

  void _continue() async {
    if (_selectedSpecialty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select your specialty')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate to home screen
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Color(0xFF2D5B8F)),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),

              SizedBox(height: 40),

              // Choose specialty section
              Text(
                'Choose Your Specialty',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D5B8F),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Select your medical specialty to connect with relevant colleagues',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 40),

              // Specialty grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: _specialties.length,
                itemBuilder: (context, index) {
                  final specialty = _specialties[index];
                  final isSelected = _selectedSpecialty == specialty['name'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSpecialty = specialty['name'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF2D5B8F).withOpacity(0.1) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Color(0xFF2D5B8F) : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            specialty['icon'] as IconData,
                            size: 32,
                            color: isSelected ? Color(0xFF2D5B8F) : specialty['color'] as Color,
                          ),
                          SizedBox(height: 8),
                          Text(
                            specialty['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Color(0xFF2D5B8F) : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 40),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2D5B8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                      : Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}