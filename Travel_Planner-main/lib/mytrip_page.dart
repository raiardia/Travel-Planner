import 'package:flutter/material.dart';
import 'trip_model.dart';
import 'trip_data.dart';
import 'package:intl/intl.dart';

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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => EditTourPage(trip: trip)),
              // );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF86CBE9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.asset(
                      imageAsset,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${formatDuration(trip.dateRange.duration)}   •   ${formatNights(trip.dateRange)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            formatDateRange(trip.dateRange),
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            trip.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  trip.location,
                                  style: const TextStyle(fontSize: 13),
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
