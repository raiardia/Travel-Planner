import 'package:flutter/material.dart'; // Mengimpor library Material Design untuk membangun UI aplikasi Flutter.
import 'package:intl/intl.dart'; // Mengimpor library `intl` untuk memformat tanggal dan waktu.
import 'add_tour_page.dart'; // Mengimpor file `add_tour_page.dart`, kemungkinan berisi implementasi halaman untuk menambahkan tur.
import 'trip_model.dart'; // Mengimpor file `trip_model.dart`, kemungkinan berisi definisi kelas `Trip`.
import 'add_trip_page.dart'; // Mengimpor file `add_trip_page.dart`, kemungkinan berisi implementasi halaman untuk menambahkan perjalanan.

class HomePage extends StatefulWidget {
  // Mendefinisikan kelas `HomePage`, yang merupakan widget stateful (memiliki state internal yang dapat berubah).
  const HomePage({
    super.key,
  }); // Konstruktor untuk kelas `HomePage`. `super.key` meneruskan key ke konstruktor superkelas (StatefulWidget).

  @override // Meng-override metode `createState` dari superkelas `StatefulWidget`. Metode ini membuat dan mengembalikan instance dari `_HomePageState`.
  State<HomePage> createState() => _HomePageState(); // Membuat dan mengembalikan instance dari kelas `_HomePageState`, yang mengelola state untuk widget `HomePage`.
}

class _HomePageState extends State<HomePage> {
  // Mendefinisikan kelas `_HomePageState`, yang merupakan state yang sesuai dengan widget `HomePage`.
  DateTime selectedDate =
      DateTime.now(); // Menyimpan tanggal yang saat ini dipilih, diinisialisasi dengan tanggal sekarang.

  final List<Trip> _trips =
      []; // Daftar untuk menyimpan objek `Trip`, diinisialisasi sebagai list kosong.

  void _openAddTrip() {
    // Metode untuk membuka halaman tambah perjalanan.
    Navigator.push(
      // Mendorong rute baru ke navigator, menampilkan halaman baru di atas yang saat ini.
      context, // Konteks saat ini.
      MaterialPageRoute(
        // Membuat rute Material Design yang menganimasikan transisi halaman.
        builder:
            (_) => AddTripPage(
              // Builder yang mengembalikan widget halaman yang akan ditampilkan.
              onAddTrip: (trip) {
                // Callback yang dipanggil ketika perjalanan baru ditambahkan di halaman `AddTripPage`.
                setState(() {
                  // Memanggil `setState` untuk memberi tahu Flutter framework bahwa state internal widget telah berubah.
                  _trips.add(
                    trip,
                  ); // Menambahkan objek `trip` baru ke daftar `_trips`.
                });
              },
            ),
      ),
    );
  }

  void _changeMonth(int offset) {
    // Metode untuk mengubah bulan yang ditampilkan dalam kalender.
    setState(() {
      // Memanggil `setState` untuk memperbarui tampilan kalender.
      int newMonth =
          selectedDate.month +
          offset; // Menghitung bulan baru berdasarkan offset.
      int newYear = selectedDate.year; // Menyimpan tahun saat ini.

      if (newMonth < 1) {
        // Jika bulan baru kurang dari 1 (Januari).
        newMonth = 12; // Set bulan menjadi Desember.
        newYear--; // Kurangi tahun.
      } else if (newMonth > 12) {
        // Jika bulan baru lebih dari 12 (Desember).
        newMonth = 1; // Set bulan menjadi Januari.
        newYear++; // Tambah tahun.
      }

      selectedDate = DateTime(
        newYear,
        newMonth,
      ); // Membuat objek `DateTime` baru dengan tahun dan bulan yang diperbarui.
    });
  }

  @override // Meng-override metode `build` dari superkelas `State`. Metode ini mendefinisikan tampilan widget.
  Widget build(BuildContext context) {
    // Metode `build` menerima `BuildContext` yang berisi informasi tentang lokasi widget dalam hierarki widget.
    String greeting =
        _getGreeting(); // Mendapatkan sapaan berdasarkan waktu saat ini menggunakan metode `_getGreeting()`.
    String monthYear = DateFormat('MMMM yyyy').format(
      selectedDate,
    ); // Memformat tanggal yang dipilih menjadi format "NamaBulan Tahun" (contoh: "April 2025").

    return Scaffold(
      // Mengembalikan widget `Scaffold`, yang menyediakan struktur dasar tata letak Material Design.
      appBar: AppBar(
        // Widget AppBar untuk menampilkan judul dan tindakan di bagian atas halaman.
        backgroundColor: const Color.fromARGB(
          255,
          34,
          102,
          141,
        ), // Warna latar belakang AppBar.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        toolbarHeight: 70, // Mengatur tinggi toolbar AppBar.
        leading: Padding(
          // Memberikan padding di sekitar widget leading (di kiri AppBar).
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            // Menampilkan gambar sebagai widget leading.
            'assets/images/Frame 1.png',
            height: 100,
            width: 100,
          ),
        ),
        actions: [
          // Daftar widget yang ditampilkan di sisi kanan AppBar.
          Padding(
            // Memberikan padding di sekitar tombol "Add Tour".
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              // Tombol dengan ikon dan label.
              style: ElevatedButton.styleFrom(
                // Mengatur style tombol.
                backgroundColor: const Color.fromARGB(
                  255,
                  34,
                  102,
                  141,
                ), // Warna latar belakang tombol.
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ), // Padding horizontal dan vertikal tombol.
                shape: RoundedRectangleBorder(
                  // Mengatur bentuk border tombol.
                  borderRadius: BorderRadius.circular(10), // Radius border.
                  side: const BorderSide(
                    color: Colors.white24,
                  ), // Warna dan ketebalan border.
                ),
              ),
              onPressed: () {
                // Fungsi yang dipanggil saat tombol ditekan.
                Navigator.push(
                  // Mendorong rute baru ke navigator untuk menampilkan halaman `AddTourPage`.
                  context,
                  MaterialPageRoute(builder: (context) => const AddTourPage()),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 18,
                color: Color(0xFFFFFADD),
              ), // Ikon tombol.
              label: const Text(
                // Label tombol.
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

      backgroundColor: const Color.fromARGB(
        255,
        34,
        102,
        141,
      ), // Warna latar belakang seluruh halaman.

      body: Padding(
        // Memberikan padding di sekitar konten utama halaman.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Menata child widget secara vertikal.
          crossAxisAlignment:
              CrossAxisAlignment
                  .start, // Mengatur alignment horizontal child widget ke kiri.
          children: [
            Text(
              // Menampilkan sapaan dan nama pengguna.
              '$greeting, Rai 👋',
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFFFFFADD),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Memberikan jarak vertikal.
            _buildUpcomingTripCard(), // Memanggil metode untuk membangun kartu perjalanan mendatang.
            const SizedBox(height: 20), // Memberikan jarak vertikal.
            Row(
              // Menata child widget secara horizontal untuk menampilkan bulan dan tombol navigasi bulan.
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween, // Mengatur jarak maksimum antara child widget.
              children: [
                Text(
                  // Menampilkan bulan dan tahun yang sedang ditampilkan.
                  monthYear,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFFADD),
                  ),
                ),
                Row(
                  // Menata tombol navigasi bulan secara horizontal.
                  children: [
                    IconButton(
                      // Tombol untuk pergi ke bulan sebelumnya.
                      icon: const Icon(Icons.chevron_left),
                      color: const Color(0xFFFFFADD),
                      tooltip: 'Previous Month',
                      onPressed: () {
                        _changeMonth(
                          -1,
                        ); // Memanggil metode untuk mengubah ke bulan sebelumnya.
                      },
                    ),
                    IconButton(
                      // Tombol untuk pergi ke bulan berikutnya.
                      icon: const Icon(Icons.chevron_right),
                      color: const Color(0xFFFFFADD),
                      tooltip: 'Next Month',
                      onPressed: () {
                        _changeMonth(
                          1,
                        ); // Memanggil metode untuk mengubah ke bulan berikutnya.
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10), // Memberikan jarak vertikal.
            _buildSimpleCalendar(
              selectedDate,
            ), // Memanggil metode untuk membangun tampilan kalender sederhana.
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        // Stack untuk menumpuk bottom navigation bar dengan dekorasi.
        children: [
          Container(
            // Container untuk latar belakang bottom navigation bar dengan efek bayangan dan border radius.
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                // Daftar bayangan untuk memberikan efek visual.
                BoxShadow(
                  color: Colors.black.withAlpha((255 * 0.5).round()),
                  offset: const Offset(0, -4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
                // Simulasi inner shadow
                const BoxShadow(
                  color: Color.fromARGB(255, 230, 230, 230),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: -4,
                ),
              ],
            ),
          ),
          ClipRRect(
            // Widget untuk memotong child-nya dengan BorderRadius.
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              // Widget navigasi di bagian bawah layar.
              backgroundColor:
                  Colors
                      .transparent, // Membuat latar belakang transparan agar dekorasi di bawahnya terlihat.
              selectedItemColor: Color.fromARGB(
                255,
                34,
                102,
                141,
              ), // Warna item yang dipilih.
              unselectedItemColor:
                  Colors.grey, // Warna item yang tidak dipilih.
              elevation:
                  0, // Menghilangkan bayangan di atas bottom navigation bar.
              items: const [
                // Daftar item navigasi.
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ), // Item "Home".
                BottomNavigationBarItem(
                  // Item "My Trip".
                  icon: Icon(Icons.place), // Titik kumpul
                  label: "My Trip",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ), // Item "Profile".
              ],
              currentIndex: 0, // Indeks item yang saat ini dipilih.
              onTap: (index) {
                // Callback yang dipanggil saat item navigasi ditekan.
                // navigasi antar halaman
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    // Metode untuk mendapatkan sapaan berdasarkan waktu saat ini.
    final hour = DateTime.now().hour; // Mendapatkan jam saat ini (0-23).
    if (hour < 12) {
      // Jika jam kurang dari 12 (pagi).
      return "Good Morning";
    } else if (hour < 17) {
      // Jika jam kurang dari 17 (siang/sore).
      return "Good Afternoon";
    } else {
      // Jika jam 17 atau lebih (malam).
      return "Good Evening";
    }
  }

  Widget _buildUpcomingTripCard() {
    // Metode untuk membangun kartu yang menampilkan perjalanan mendatang.
    return Card(
      // Widget Card untuk menampilkan informasi dengan latar belakang dan bayangan.
      elevation: 4, // Ketinggian bayangan kartu.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // Bentuk border kartu.
      child: ListTile(
        // Widget ListTile untuk menampilkan baris tunggal dengan leading, title, subtitle, dan trailing.
        contentPadding: const EdgeInsets.all(16), // Padding di dalam ListTile.
        leading: const Icon(
          Icons.flight_takeoff,
          color: Colors.teal,
        ), // Ikon di awal baris.
        title: const Text("Bali Getaway"), // Judul utama.
        subtitle: const Text("12 - 15 April 2025"), // Subjudul.
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ), // Ikon di akhir baris.
      ),
    );
  }

  Widget _buildSimpleCalendar(DateTime date) {
    // Metode untuk membangun tampilan kalender sederhana untuk bulan yang diberikan.
    final daysInMonth = DateUtils.getDaysInMonth(
      date.year,
      date.month,
    ); // Mendapatkan jumlah hari dalam bulan yang diberikan.
    final firstDay =
        DateTime(
          date.year,
          date.month,
          1,
        ).weekday; // Mendapatkan hari dalam seminggu untuk hari pertama bulan (1=Senin, 7=Minggu).

    return GridView.builder(
      // Widget untuk menampilkan item dalam grid.
      shrinkWrap:
          true, // Membuat GridView mengambil ruang minimum yang dibutuhkan oleh child-nya.
      physics:
          const NeverScrollableScrollPhysics(), // Mencegah GridView agar tidak dapat di-scroll.
      itemCount:
          daysInMonth +
          firstDay -
          1, // Jumlah total item dalam grid (hari dalam bulan + offset hari pertama).
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Mengatur tata letak grid dengan jumlah kolom tetap.
        crossAxisCount: 7, // Menampilkan 7 kolom (untuk hari dalam seminggu).
      ),
      itemBuilder: (context, index) {
        // Builder untuk membangun setiap item dalam grid.
        if (index < firstDay - 1) {
          // Jika indeks kurang dari hari pertama bulan (untuk mengisi hari kosong di awal).
          return const SizedBox(); // Mengembalikan widget kosong.
        }

        int day = index - firstDay + 2; // Menghitung nomor hari dalam bulan.
        return Container(
          // Container untuk setiap sel tanggal.
          margin: const EdgeInsets.all(
            4,
          ), // Margin di sekitar setiap sel tanggal.
          decoration: BoxDecoration(
            // Dekorasi latar belakang sel tanggal.
            color:
                day ==
                            DateTime.now()
                                .day && // Memeriksa apakah hari ini adalah tanggal yang sedang dibangun.
                        date.month == DateTime.now().month &&
                        date.year == DateTime.now().year
                    ? const Color(
                      0xFFf4d35e,
                    ) // Warna kuning cerah untuk hari ini.
                    : const Color(
                      0xFFFFFADD,
                    ), // Warna cream biasa untuk hari lain.
            borderRadius: BorderRadius.circular(
              8,
            ), // Radius border sel tanggal.
            boxShadow:
                day ==
                            DateTime.now()
                                .day && // Memberikan bayangan hanya pada hari ini.
                        date.month == DateTime.now().month &&
                        date.year == DateTime.now().year
                    ? [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.2).round()),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Center(
            // Memusatkan teks hari di dalam sel.
            child: Text(
              '$day',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    day == DateTime.now().day && // Warna teks untuk hari ini.
                            date.month == DateTime.now().month &&
                            date.year == DateTime.now().year
                        ? Colors.black
                        : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}
