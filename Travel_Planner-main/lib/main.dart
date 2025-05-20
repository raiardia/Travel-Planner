import 'package:flutter/material.dart'; // Mengimpor library Material Design untuk membangun UI aplikasi Flutter.
import 'login.dart'; // Mengimpor file `login.dart`, yang kemungkinan berisi implementasi halaman login.
import 'register.dart';

void main() {
  // Fungsi utama yang menjadi titik awal eksekusi aplikasi.
  runApp(
    const MyApp(),
  ); // Menjalankan aplikasi Flutter dengan widget `MyApp` sebagai root.
}

class MyApp extends StatelessWidget {
  // Mendefinisikan kelas `MyApp`, yang merupakan widget stateless (tidak memiliki state internal yang dapat berubah).
  const MyApp({
    super.key,
  }); // Konstruktor untuk kelas `MyApp`. `super.key` meneruskan key ke konstruktor superkelas (StatelessWidget).

  @override // Meng-override metode `build` dari superkelas `StatelessWidget`. Metode ini mendefinisikan tampilan widget.
  Widget build(BuildContext context) {
    // Metode `build` menerima `BuildContext` yang berisi informasi tentang lokasi widget dalam hierarki widget.
    return MaterialApp(
      // Mengembalikan widget `MaterialApp`, yang merupakan wrapper untuk banyak fitur dasar aplikasi Material Design.
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner "Debug" yang biasanya muncul di sudut kanan atas saat dalam mode pengembangan.
      title:
          'Traveler App', // Menetapkan judul aplikasi yang mungkin ditampilkan oleh sistem operasi atau saat beralih antar aplikasi.
      home:
          const Login(), // Menetapkan widget `Login` sebagai halaman utama (halaman pertama yang ditampilkan saat aplikasi dibuka). `const` menunjukkan bahwa instance `Login` adalah konstan.
    );
  }
}
