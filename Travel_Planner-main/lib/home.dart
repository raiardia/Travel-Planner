import 'package:flutter/material.dart';
import 'package:project_travelplanner/trip_data.dart';
import 'add_tour_page.dart';
import 'profil.dart';
import 'mytrip_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dream_destination_page.dart';
import 'trip_data.dart';
import 'tour_detail_page.dart';

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
        openAddTourPage: () async {
          final newTrip = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTourPage()),
          );

          if (newTrip != null) {
            setState(() {
              tripList.add(newTrip);
            });
          }
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
                      : const Icon(Icons.home_outlined, size: 27),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 1
                      ? _buildSelectedIcon(Icons.public, 'Destination')
                      : const Icon(Icons.public, size: 27),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 2
                      ? _buildSelectedIcon(Icons.place, 'My Trip')
                      : const Icon(Icons.place_outlined, size: 27),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 3
                      ? _buildSelectedIcon(Icons.person, 'Profile')
                      : const Icon(Icons.person_outline, size: 27),
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 102, 141),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 9.6),
          ),
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
    final now = DateTime.now();
    final upcomingTrips =
        tripList.where((trip) => trip.dateRange.start.isAfter(now)).toList();

    // Sort berdasarkan tanggal paling awal
    upcomingTrips.sort(
      (a, b) => a.dateRange.start.compareTo(b.dateRange.start),
    );

    final bool hasUpcoming = upcomingTrips.isNotEmpty;
    final nearestTrip = hasUpcoming ? upcomingTrips.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 5),
          child: Text(
            "Upcoming Trip",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.flight_takeoff, color: Colors.teal),
              title: Text(
                hasUpcoming
                    ? nearestTrip!.location
                    : "No upcoming trips found.",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle:
                  hasUpcoming
                      ? Text(
                        DateFormat(
                              'd MMMM y',
                            ).format(nearestTrip!.dateRange.start) +
                            ' - ' +
                            DateFormat(
                              'd MMMM y',
                            ).format(nearestTrip.dateRange.end),
                      )
                      : null,
              trailing:
                  hasUpcoming
                      ? const Icon(Icons.arrow_forward_ios, size: 16)
                      : null,
              onTap:
                  hasUpcoming
                      ? () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:
                              (_) => TourDetailSheet(
                                trip: nearestTrip!,
                                tripIndex: tripList.indexOf(nearestTrip),
                              ),
                        );
                      }
                      : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableCalendar(DateTime selectedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 5),
          child: Text(
            "Trip Calendar",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF89D2E4),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,

              // Tambahkan ini:
              eventLoader: (day) {
                return tripList
                    .where((trip) {
                      return !day.isBefore(trip.dateRange.start) &&
                          !day.isAfter(trip.dateRange.end);
                    })
                    .map((trip) => trip.location)
                    .toList();
              },

              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return const SizedBox();

                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ), // posisi bawah angka tanggal
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          events.map((e) {
                            return Container(
                              // Gunakan constraints agar tidak melebihi lebar sel
                              constraints: const BoxConstraints(
                                maxWidth: 50, // Sesuaikan jika terlalu sempit
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.card_travel,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 3),
                                  Flexible(
                                    child: Text(
                                      e.toString(),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  );
                },
              ),

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
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF89D2E4),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                titleTextFormatter:
                    (date, locale) =>
                        DateFormat('MMMM / y', locale).format(date),
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
          ),
        ),
      ],
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
          const Divider(thickness: 1, color: Colors.white54, height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _buildTableCalendar(widget.selectedDate),
          ),
          const SizedBox(height: 5),
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
