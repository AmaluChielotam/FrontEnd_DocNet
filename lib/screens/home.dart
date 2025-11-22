import 'package:flutter/material.dart';
import 'package:flutterprojects/model/doctor_model.dart';
import 'package:flutterprojects/screens/profile.dart';
import 'package:flutterprojects/widgets/doctor_card.dart';
import 'package:flutterprojects/widgets/speciality_chip.dart';
import 'package:flutterprojects/widgets/post_card.dart';

import 'message.dart'; // Make sure this file exists
import 'network.dart'; // Make sure this file exists

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Doctor> _topDoctors = [
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
      location: 'Rochester, MN', // Fixed location
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
      location: 'Baltimore, MD', // Fixed location
      bio: 'Neurologist with focus on migraine treatments and research',
      connections: 287,
      skills: ['EEG Interpretation', 'Migraine Management', 'Clinical Research'],
    ),
    Doctor(
      id: '3',
      name: 'Dr. Emily Watson',
      specialty: 'Pediatrics',
      hospital: 'Boston Children\'s',
      rating: 4.7,
      votes: 173,
      imageUrl: 'assets/doctor3.jpg',
      isOnline: true,
      experience: '10 years',
      isVerified: true,
      location: 'Boston, MA',
      bio: 'Pediatrician passionate about child healthcare and education',
      connections: 231,
      skills: ['Child Development', 'Vaccination', 'Parent Education'],
    ),
  ];

  final List<Post> _posts = [
    Post(
      id: '1',
      author: Doctor(
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
      content: 'Just published a new research paper on minimally invasive cardiac procedures. Excited to share that our new technique has shown 40% faster recovery times! 🎯',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      likes: 42,
      comments: 8,
      tags: ['Cardiology', 'Research', 'Innovation'],
    ),
    Post(
      id: '2',
      author: Doctor(
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
      content: 'Looking for insights on managing complex migraine cases with multiple comorbidities. Any colleagues have experience with the new CGRP inhibitors?',
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
      likes: 28,
      comments: 12,
      tags: ['Neurology', 'Migraine', 'Treatment'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: _currentIndex == 0 ? _buildHomeAppBar() : null,
      body: _buildCurrentTab(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_comment, color: Colors.white),
        backgroundColor: Color(0xFF2D5B8F),
        elevation: 2,
      ) : null,
    );
  }

  AppBar _buildHomeAppBar() {
    return AppBar(
      title: Text(
        'DoctorConnect',
        style: TextStyle(
          color: Color(0xFF2D5B8F),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Color(0xFF2D5B8F)),
          onPressed: () {},
        ),
        IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
            radius: 16,
          ),
          onPressed: () {
            setState(() {
              _currentIndex = 3; // Navigate to profile
            });
          },
        ),
      ],
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2D5B8F), Color(0xFF4CAF50)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Dr. Smith!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Connect, share, and grow with medical professionals worldwide',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Top Doctors Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated Doctors',
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

          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _topDoctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(doctor: _topDoctors[index]);
              },
            ),
          ),

          SizedBox(height: 24),

          // Specialty Filters
          Text(
            'Specialties',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D5B8F),
            ),
          ),

          SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SpecialtyChip(label: 'Cardiology', isSelected: true),
              SpecialtyChip(label: 'Neurology', isSelected: false),
              SpecialtyChip(label: 'Pediatrics', isSelected: false),
              SpecialtyChip(label: 'Surgery', isSelected: false),
              SpecialtyChip(label: 'Oncology', isSelected: false),
              SpecialtyChip(label: 'Dermatology', isSelected: false),
            ],
          ),

          SizedBox(height: 24),

          // Recent Posts
          Text(
            'Recent Posts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D5B8F),
            ),
          ),

          SizedBox(height: 16),

          Column(
            children: _posts.map((post) => PostCard(post: post)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return MessagesScreen();
      case 2:
        return NetworkScreen();
      case 3:
        return ProfileScreen();
      default:
        return _buildHomeTab();
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedItemColor: Color(0xFF2D5B8F),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          activeIcon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outlined),
          activeIcon: Icon(Icons.people),
          label: 'Network',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}