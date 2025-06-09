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
        title: const Text('My Trip'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F628E),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: tripList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final trip = tripList[index];

          // Gambar lokal dari assets
          final imageAsset =
              index % 2 == 0
                  ? 'assets/images/mytrip_1.jpg'
                  : 'assets/images/mytrip_2.jpg';

          return Container(
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
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${formatDuration(trip.dateRange.duration)}   •   ${formatNights(trip.dateRange)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatDateRange(trip.dateRange),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          trip.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 14),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                trip.location,
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
          );
        },
      ),
    );
  }
}
