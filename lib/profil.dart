import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Page/editProfil.dart';

class SlightBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 16.5);
    final controlPoint = Offset(size.width / 2, size.height + 17);
    final endPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Raihengan";
  String phone = "+98 1245560090";
  String email = "konoha@gmail.com";
  File? _imageFile;

  void _openEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditProfilPage(
              initialName: name,
              initialPhone: phone,
              initialEmail: email,
            ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        name = result['name']!;
        phone = result['phone']!;
        email = result['email']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 102, 141),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              PhysicalShape(
                clipper: SlightBottomCurveClipper(),
                elevation: 20,
                color: const Color.fromARGB(255, 210, 227, 238),
                shadowColor: const Color(0x60000000),
                child: Container(
                  width: double.infinity,
                  height: 210,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 49,
                          left: 20,
                          right: 1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.notifications_none),
                            const Text(
                              'Profil',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _openEditPage();
                                }
                              },
                              itemBuilder:
                                  (BuildContext context) => [
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit_note, size: 23),
                                          SizedBox(width: 10),
                                          Text('Edit Profile'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuDivider(),
                                    const PopupMenuItem<String>(
                                      value: 'logout',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: Colors.red,
                                            size: 23,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Logout',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      width: 140,
                      height: 140,
                      color: Colors.grey[200],
                      child:
                          _imageFile != null
                              ? Image.file(_imageFile!, fit: BoxFit.cover)
                              : Image.asset(
                                'assets/images/profile.jpg',
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 120),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 34, 102, 141),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(icon: Icons.person, label: 'Nama', value: name),
                  const Divider(thickness: 2),
                  InfoRow(icon: Icons.phone, label: 'No. HP', value: phone),
                  const Divider(thickness: 2),
                  InfoRow(icon: Icons.email, label: 'E-Mail', value: email),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 26, color: Colors.white),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
