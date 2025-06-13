import 'package:flutter/material.dart';
import 'trip_model.dart';
import 'trip_data.dart';
import 'package:intl/intl.dart';
import 'edit_tour_page.dart';

class MytripPage extends StatefulWidget {
  const MytripPage({super.key});

  @override
  State<MytripPage> createState() => _MytripPageState();
}

class _MytripPageState extends State<MytripPage> {
  String formatDuration(Duration duration) {
    return '${duration.inDays}D : ${(duration.inHours % 24)}H : ${(duration.inMinutes % 60)}M';
  }

  String formatDateRange(DateTimeRange range) {
    final formatter = DateFormat('MMM d');
    return '${formatter.format(range.start)} - ${formatter.format(range.end)}';
  }

  String formatNights(DateTimeRange range) {
    final days = range.duration.inDays;
    return '${days}N${days + 1}D';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F628E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F628E),
        elevation: 0,
        toolbarHeight: 80, //
        title: const Padding(
          padding: EdgeInsets.only(top: 12.0), //
          child: Text(
            'My Trip',
            style: TextStyle(
              fontSize: 26, //
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tripList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final trip = tripList[index];

          final imageAsset =
              index % 2 == 0
                  ? 'assets/images/mytrip_1.jpg'
                  : 'assets/images/mytrip_2.jpg';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTourPage(
                    trip: tripList[index],
                    tripIndex: index,
                  ),
                ),
              );
            },

            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFF86CBE9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar trip
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image.asset(
                      imageAsset,
                      width: 140,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Detail trip
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Durasi dan format hari/malam
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${formatDuration(trip.dateRange.duration)} • ${formatNights(trip.dateRange)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Rentang tanggal
                          Text(
                            formatDateRange(trip.dateRange),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Judul trip
                          Text(
                            trip.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F628E),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),

                          // Lokasi trip
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  trip.location,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
