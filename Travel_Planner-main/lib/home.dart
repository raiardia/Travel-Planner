import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_tour_page.dart';
import 'trip_model.dart';
import 'add_trip_page.dart';
import 'profil.dart';
import 'mytrip_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  DateTime selectedDate = DateTime.now();
  final List<Trip> _trips = [];

  void _openAddTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => AddTripPage(
              onAddTrip: (trip) {
                setState(() {
                  _trips.add(trip);
                });
              },
            ),
      ),
    );
  }

  void _changeMonth(int offset) {
    setState(() {
      int newMonth = selectedDate.month + offset;
      int newYear = selectedDate.year;

      if (newMonth < 1) {
        newMonth = 12;
        newYear--;
      } else if (newMonth > 12) {
        newMonth = 1;
        newYear++;
      }

      selectedDate = DateTime(newYear, newMonth);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeContent(
        selectedDate: selectedDate,
        onChangeMonth: _changeMonth,
        openAddTourPage: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTourPage()),
          );
        },
      ),

      MytripPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 34, 102, 141),
        unselectedItemColor: Colors.grey,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "My Trip"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(int) onChangeMonth;
  final VoidCallback openAddTourPage;

  const HomeContent({
    super.key,
    required this.selectedDate,
    required this.onChangeMonth,
    required this.openAddTourPage,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  Widget _buildUpcomingTripCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.flight_takeoff, color: Colors.teal),
        title: const Text("Bali Getaway"),
        subtitle: const Text("12 - 15 April 2025"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildSimpleCalendar(DateTime date) {
    final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    final firstDay = DateTime(date.year, date.month, 1).weekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: daysInMonth + firstDay - 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (context, index) {
        if (index < firstDay - 1) {
          return const SizedBox();
        }

        int day = index - firstDay + 2;
        bool isToday =
            day == DateTime.now().day &&
            date.month == DateTime.now().month &&
            date.year == DateTime.now().year;

        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isToday ? const Color(0xFFf4d35e) : const Color(0xFFFFFADD),
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                isToday
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isToday ? Colors.black : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();
    String monthYear = DateFormat('MMMM yyyy').format(selectedDate);

    return Container(
      color: const Color.fromARGB(255, 34, 102, 141),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50), // Jarak atas supaya tidak terlalu mepet
          Text(
            '$greeting, Rai 👋',
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFFFFFADD),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.white54, thickness: 1, height: 1),
          const SizedBox(height: 30),
          _buildUpcomingTripCard(),
          const Divider(thickness: 1, color: Colors.grey, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthYear,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFADD),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    color: const Color(0xFFFFFADD),
                    tooltip: 'Previous Month',
                    onPressed: () => onChangeMonth(-1),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    color: const Color(0xFFFFFADD),
                    tooltip: 'Next Month',
                    onPressed: () => onChangeMonth(1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildSimpleCalendar(selectedDate)),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 34, 102, 141),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
              onPressed: openAddTourPage,
              icon: const Icon(Icons.add, size: 18, color: Color(0xFFFFFADD)),
              label: const Text(
                'Add Tour',
                style: TextStyle(
                  color: Color(0xFFFFFADD),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
