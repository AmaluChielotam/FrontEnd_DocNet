import 'package:flutter/material.dart';
import 'package:flutterprojects/model/doctor_model.dart';
import 'package:flutterprojects/widgets/doctor_card.dart';

class NetworkScreen extends StatefulWidget {
  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  final List<Doctor> _suggestedDoctors = [
    Doctor(
      id: '4',
      name: 'Dr. James Wilson',
      specialty: 'Orthopedic Surgery',
      hospital: 'Hospital for Special Surgery',
      rating: 4.8,
      votes: 215,
      imageUrl: 'assets/doctor4.jpg',
      isOnline: true,
      experience: '14 years',
      isVerified: true,
      location: 'New York, NY',
      bio: 'Orthopedic surgeon specializing in sports medicine and joint replacement',
      connections: 189,
      skills: ['Arthroscopy', 'Joint Replacement', 'Sports Medicine'],
    ),
    Doctor(
      id: '5',
      name: 'Dr. Lisa Park',
      specialty: 'Dermatology',
      hospital: 'Cleveland Clinic',
      rating: 4.7,
      votes: 167,
      imageUrl: 'assets/doctor5.jpg',
      isOnline: false,
      experience: '9 years',
      isVerified: true,
      location: 'Cleveland, OH',
      bio: 'Dermatologist focused on skin cancer prevention and cosmetic dermatology',
      connections: 156,
      skills: ['Skin Cancer Screening', 'Cosmetic Procedures', 'Medical Dermatology'],
    ),
    Doctor(
      id: '6',
      name: 'Dr. Robert Brown',
      specialty: 'Psychiatry',
      hospital: 'Massachusetts General',
      rating: 4.6,
      votes: 142,
      imageUrl: 'assets/doctor6.jpg',
      isOnline: true,
      experience: '11 years',
      isVerified: true,
      location: 'Boston, MA',
      bio: 'Psychiatrist specializing in anxiety disorders and cognitive behavioral therapy',
      connections: 203,
      skills: ['CBT', 'Anxiety Disorders', 'Psychopharmacology'],
    ),
  ];

  final List<Doctor> _myConnections = [
    Doctor(
      id: '1',
      name: 'Dr. Sarah Chen',
      specialty: 'Cardiology',
      hospital: 'Mayo Clinic',
      rating: 4.9,
      votes: 284,
      imageUrl: 'assets/doctor1.jpg',
      isOnline: true,
      experience: '15 years',
      isVerified: true,
      location: 'Rochester, MN',
      bio: 'Cardiologist specializing in minimally invasive procedures',
      connections: 342,
      skills: ['Echocardiography', 'Cardiac Catheterization', 'Patient Care'],
    ),
    Doctor(
      id: '2',
      name: 'Dr. Michael Rodriguez',
      specialty: 'Neurology',
      hospital: 'Johns Hopkins',
      rating: 4.8,
      votes: 196,
      imageUrl: 'assets/doctor2.jpg',
      isOnline: false,
      experience: '12 years',
      isVerified: true,
      location: 'Baltimore, MD',
      bio: 'Neurologist with focus on migraine treatments and research',
      connections: 287,
      skills: ['EEG Interpretation', 'Migraine Management', 'Clinical Research'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'My Network',
          style: TextStyle(
            color: Color(0xFF2D5B8F),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF2D5B8F)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_add, color: Color(0xFF2D5B8F)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Stats
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Connections', '47'),
                  _buildStatItem('Pending', '3'),
                  _buildStatItem('Groups', '5'),
                  _buildStatItem('Events', '2'),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Suggested Connections
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suggested for You',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5B8F),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(color: Color(0xFF4CAF50)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            ..._suggestedDoctors.map((doctor) => _buildConnectionCard(doctor, false)).toList(),

            SizedBox(height: 24),

            // My Connections
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Connections',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5B8F),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(color: Color(0xFF4CAF50)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            ..._myConnections.map((doctor) => _buildConnectionCard(doctor, true)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5B8F),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionCard(Doctor doctor, bool isConnected) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${doctor.id}'),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          doctor.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF2D5B8F),
                          ),
                        ),
                        SizedBox(width: 4),
                        if (doctor.isVerified)
                          Icon(Icons.verified, color: Color(0xFF4CAF50), size: 16),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${doctor.specialty} • ${doctor.hospital}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      doctor.location,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.people, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '${doctor.connections} connections',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Skills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: doctor.skills.take(3).map((skill) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF2D5B8F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  color: Color(0xFF2D5B8F),
                  fontSize: 12,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF2D5B8F),
                    side: BorderSide(color: Color(0xFF2D5B8F)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(isConnected ? 'Message' : 'Connect'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2D5B8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(isConnected ? 'Connected' : 'Connect'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}