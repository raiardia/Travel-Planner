import 'package:flutter/material.dart';

class Trip {
  final String title;
  final String location;
  final String remarks;
  final DateTimeRange dateRange;

  Trip({
    required this.title,
    required this.location,
    required this.remarks,
    required this.dateRange,
  });
}
