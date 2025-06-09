import 'package:flutter/material.dart';
import 'package:project_travelplanner/home.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'trip_model.dart';
import 'trip_data.dart';
import 'mytrip_page.dart';

class AddTourPage extends StatefulWidget {
  final Function(Trip)? onAddTour;

  const AddTourPage({super.key, this.onAddTour});

  @override
  State<AddTourPage> createState() => _AddTourPageState();
}

class _AddTourPageState extends State<AddTourPage> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // Buat controller sebagai state supaya tidak hilang saat rebuild
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _tourAboutController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  // Inisialisasi _rangeFocusedDay supaya tidak null
  DateTime _rangeFocusedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void dispose() {
    // Jangan lupa dispose controller saat widget dihapus
    _dateController.dispose();
    _tourAboutController.dispose();
    _locationController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 102, 141),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 34, 102, 141),
        elevation: 0,
        title: const Text('Add tour reminder'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableCalendar(),
            const SizedBox(height: 20),
            _buildLabeledField('Date', null, _dateController),
            _buildLabeledField(
              "What's the tour about",
              null,
              _tourAboutController,
            ),
            _buildLabeledField('Location', Icons.search, _locationController),
            _buildLabeledField(
              'Remarks',
              null,
              _remarksController,
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 110,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_rangeStart != null && _rangeEnd != null) {
                      final newTrip = Trip(
                        title: _tourAboutController.text,
                        location: _locationController.text,
                        remarks: _remarksController.text,
                        dateRange: DateTimeRange(
                          start: _rangeStart!,
                          end: _rangeEnd!,
                        ),
                      );

                      // Tambahkan ke tripList
                      tripList.add(newTrip);

                      // Kembali ke halaman MyTrip
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => HomePage(initialTabIndex: 1,),
                        ),
                        (route) => false,
                      );
                    } else {
                      // Tampilkan snackbar kalau belum pilih tanggal
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a date range first!'),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save, color: Colors.black87),
                      SizedBox(width: 5),
                      Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF89D2E4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Custom Header with Chevron Icons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF89D2E4),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon: chevron left
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _rangeFocusedDay = DateTime(
                        _rangeFocusedDay.year,
                        _rangeFocusedDay.month - 1,
                      );
                    });
                  },
                ),

                // Label Bulan / Tahun
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _rangeFocusedDay,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDatePickerMode: DatePickerMode.year,
                    );
                    if (picked != null) {
                      setState(() {
                        _rangeFocusedDay = picked;
                      });
                    }
                  },
                  child: Text(
                    "${DateFormat.MMMM().format(_rangeFocusedDay)} / ${_rangeFocusedDay.year}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Icon: chevron right
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _rangeFocusedDay = DateTime(
                        _rangeFocusedDay.year,
                        _rangeFocusedDay.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // TableCalendar
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _rangeFocusedDay,
            calendarFormat: _calendarFormat,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (isSameDay(_rangeStart, selectedDay) && _rangeEnd == null) {
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                  _dateController.text = '';
                } else if (_rangeSelectionMode ==
                        RangeSelectionMode.toggledOn &&
                    _rangeStart != null &&
                    _rangeEnd == null &&
                    selectedDay.isAfter(_rangeStart!)) {
                  _rangeEnd = selectedDay;
                } else {
                  _rangeStart = selectedDay;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                }

                _rangeFocusedDay = focusedDay;

                _dateController.text =
                    (_rangeStart != null && _rangeEnd != null)
                        ? "${_rangeStart!.day}/${_rangeStart!.month}/${_rangeStart!.year} - ${_rangeEnd!.day}/${_rangeEnd!.month}/${_rangeEnd!.year}"
                        : (_rangeStart != null)
                        ? "${_rangeStart!.day}/${_rangeStart!.month}/${_rangeStart!.year}"
                        : "";
              });
            },
            onPageChanged: (focusedDay) {
              _rangeFocusedDay = focusedDay;
            },
            headerVisible: false,
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
              selectedTextStyle: TextStyle(color: Colors.black),
              rangeHighlightColor: Color.fromARGB(132, 255, 255, 255),
              rangeStartTextStyle: TextStyle(color: Colors.black),
              rangeStartDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              rangeEndTextStyle: TextStyle(color: Colors.black),
              rangeEndDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledField(
    String label,
    IconData? icon,
    TextEditingController? controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            style: const TextStyle(color: Color(0xFFFFFADD)),
            cursorColor: Colors.white,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon:
                  icon != null ? Icon(icon, color: Color(0xFFFFFADD)) : null,
              label: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 210, 210, 210),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFFFFADD)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFFFFADD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
