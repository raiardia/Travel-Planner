import 'package:flutter/material.dart';
import 'add_tour_page.dart';
import 'profil.dart';
import 'mytrip_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dream_destination_page.dart';

class HomePage extends StatefulWidget {
  final int initialTabIndex;
  const HomePage({super.key, this.initialTabIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
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
    final pages = [
      HomeContent(
        selectedDate: selectedDate,
        onChangeMonth: _changeMonth,
        openAddTourPage: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTourPage()),
          );
        },
      ),
      DreamDestinationPage(),
      MytripPage(),
      ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,
      body: pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 34, 102, 141),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 0
                      ? _buildSelectedIcon(Icons.home, 'Home')
                      : const Icon(Icons.home_outlined, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 1
                      ? _buildSelectedIcon(Icons.place, 'My Trip')
                      : const Icon(Icons.place_outlined, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 2
                      ? _buildSelectedIcon(Icons.person, 'Profile')
                      : const Icon(Icons.person_outline, size: 30),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildSelectedIcon(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 102, 141),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(int) onChangeMonth;
  final VoidCallback openAddTourPage;

  const HomeContent({
    super.key,
    required this.selectedDate,
    required this.onChangeMonth,
    required this.openAddTourPage,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

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

  Widget _buildTableCalendar(DateTime selectedDate) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF89D2E4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
          decoration: BoxDecoration(
            color: Color(0xFF89D2E4),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // Tambahkan custom builder untuk title
          titleTextFormatter:
              (date, locale) => DateFormat('MMMM / y', locale).format(date),
        ),

        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black,
          ),
          weekendStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(color: Colors.black, fontSize: 16),
          weekendTextStyle: TextStyle(color: Colors.black, fontSize: 16),
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 34, 102, 141),
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(color: Colors.white),
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();

    return Container(
      color: const Color.fromARGB(255, 34, 102, 141),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/Frame 1.png', height: 60),
                Text(
                  '$greeting, Rai',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color(0xFFFFFADD),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white54, thickness: 1, height: 1),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 6),
            child: _buildUpcomingTripCard(),
          ),
          const Divider(thickness: 1, color: Colors.grey, height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _buildTableCalendar(widget.selectedDate),
          ),
          const SizedBox(height: 20),
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
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFFFFADD)),
                ),
              ),
              onPressed: widget.openAddTourPage,
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
