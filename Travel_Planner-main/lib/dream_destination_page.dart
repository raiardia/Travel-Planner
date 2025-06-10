import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DreamDestinationPage extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {'image': 'assets/images/bali.png', 'name': 'BALI'},
    {'image': 'assets/images/lombok.png', 'name': 'LOMBOK'},
    {'image': 'assets/images/yogyakarta.png', 'name': 'YOGYAKARTA'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF8DC),
      body: Column(
        children: [
          SizedBox(height: 60),
          Center(
            child: Text(
              'Destinasi Impian',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF225B75),
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: PageView.builder(
              itemCount: destinations.length,
              controller: PageController(viewportFraction: 0.7),
              itemBuilder: (context, index) {
                final item = destinations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        item['name']!,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF225B75),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF225B75),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt_rounded),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/addTour');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/mytrip');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/profil');
          }
        },
      ),
    );
  }
}
