import 'package:flutter/material.dart'; // Mengimpor library Material Design untuk membangun UI aplikasi Flutter.

class Trip {
  // Mendefinisikan kelas `Trip`, yang kemungkinan merepresentasikan informasi tentang sebuah perjalanan.
  final String
  title; // Mendeklarasikan variabel final `title` bertipe String, yang akan menyimpan judul perjalanan.
  final String
  location; // Mendeklarasikan variabel final `location` bertipe String, yang akan menyimpan lokasi perjalanan.
  final String
  remarks; // Mendeklarasikan variabel final `remarks` bertipe String, yang akan menyimpan catatan atau keterangan tambahan tentang perjalanan.
  final DateTimeRange
  dateRange; // Mendeklarasikan variabel final `dateRange` bertipe `DateTimeRange`, yang akan menyimpan rentang tanggal perjalanan (kapan dimulai dan berakhir).

  Trip({
    // Konstruktor untuk kelas `Trip`. Digunakan untuk membuat instance dari kelas `Trip`.
    required this.title, // Parameter wajib untuk menginisialisasi variabel `title`. `required` memastikan nilai harus diberikan saat membuat objek `Trip`.
    required this.location, // Parameter wajib untuk menginisialisasi variabel `location`.
    required this.remarks, // Parameter wajib untuk menginisialisasi variabel `remarks`.
    required this.dateRange, // Parameter wajib untuk menginisialisasi variabel `dateRange`.
  });
}
