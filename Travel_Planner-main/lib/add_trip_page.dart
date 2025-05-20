import 'package:flutter/material.dart'; // Mengimpor library Material Design untuk membangun UI aplikasi Flutter.
import 'package:intl/intl.dart'; // Mengimpor library `intl` untuk memformat tanggal.
import 'trip_model.dart'; // Mengimpor file `trip_model.dart` yang berisi definisi kelas `Trip`.

class AddTripPage extends StatefulWidget {
  // Mendefinisikan kelas `AddTripPage`, yang merupakan widget stateful (memiliki state internal yang dapat berubah).
  final Function(Trip)
  onAddTrip; // Mendeklarasikan variabel final `onAddTrip` yang merupakan sebuah fungsi. Fungsi ini menerima objek `Trip` sebagai argumen dan tidak mengembalikan nilai (void). Ini digunakan untuk mengirim data perjalanan baru kembali ke halaman sebelumnya.

  const AddTripPage({
    super.key,
    required this.onAddTrip,
  }); // Konstruktor untuk kelas `AddTripPage`. `super.key` meneruskan key ke konstruktor superkelas (StatefulWidget). `required this.onAddTrip` menandakan bahwa fungsi `onAddTrip` harus diberikan saat membuat instance dari `AddTripPage`.

  @override // Meng-override metode `createState` dari superkelas `StatefulWidget`. Metode ini membuat dan mengembalikan instance dari `_AddTripPageState`.
  State<AddTripPage> createState() => _AddTripPageState(); // Membuat dan mengembalikan instance dari kelas `_AddTripPageState`, yang mengelola state untuk widget `AddTripPage`.
}

class _AddTripPageState extends State<AddTripPage> {
  // Mendefinisikan kelas `_AddTripPageState`, yang merupakan state yang sesuai dengan widget `AddTripPage`.
  final _formKey =
      GlobalKey<
        FormState
      >(); // Membuat kunci global untuk mengelola state dari widget `Form`. Ini digunakan untuk validasi form.
  final _titleController =
      TextEditingController(); // Membuat controller untuk mengambil teks dari field input judul.
  final _locationController =
      TextEditingController(); // Membuat controller untuk mengambil teks dari field input lokasi.
  final _remarksController =
      TextEditingController(); // Membuat controller untuk mengambil teks dari field input catatan.
  DateTimeRange?
  _selectedDateRange; // Mendeklarasikan variabel nullable `_selectedDateRange` bertipe `DateTimeRange` untuk menyimpan rentang tanggal yang dipilih. Awalnya tidak ada tanggal yang dipilih (null).

  Future<void> _pickDateRange() async {
    // Metode asynchronous untuk menampilkan dialog pemilih rentang tanggal. `async` menandakan bahwa metode ini dapat ditangguhkan.
    final now = DateTime.now(); // Mendapatkan tanggal dan waktu saat ini.
    final picked = await showDateRangePicker(
      // Menampilkan dialog pemilih rentang tanggal dan menunggu hasilnya. `await` menandakan bahwa eksekusi akan ditangguhkan sampai dialog ditutup dan mengembalikan nilai.
      context: context, // Konteks saat ini.
      firstDate: DateTime(
        now.year - 1,
      ), // Tanggal pertama yang dapat dipilih (satu tahun sebelum sekarang).
      lastDate: DateTime(
        now.year + 2,
      ), // Tanggal terakhir yang dapat dipilih (dua tahun setelah sekarang).
      initialDateRange: DateTimeRange(
        start: now,
        end: now.add(const Duration(days: 3)),
      ), // Rentang tanggal awal yang ditampilkan saat dialog dibuka (dari sekarang hingga 3 hari ke depan).
    );

    if (picked != null) {
      // Memeriksa apakah pengguna memilih rentang tanggal (tidak membatalkan dialog).
      setState(() {
        // Memanggil `setState` untuk memberi tahu Flutter framework bahwa state internal widget telah berubah.
        _selectedDateRange =
            picked; // Mengupdate `_selectedDateRange` dengan rentang tanggal yang dipilih oleh pengguna.
      });
    }
  }

  void _saveTrip() {
    // Metode untuk menyimpan data perjalanan.
    if (_formKey.currentState!.validate() && _selectedDateRange != null) {
      // Memeriksa apakah form valid dan rentang tanggal telah dipilih. `_formKey.currentState!.validate()` memanggil validator untuk semua `FormField` di dalam `Form`.
      final newTrip = Trip(
        // Membuat objek `Trip` baru dengan data dari form.
        title: _titleController.text, // Mengambil teks dari controller judul.
        location:
            _locationController.text, // Mengambil teks dari controller lokasi.
        remarks:
            _remarksController.text, // Mengambil teks dari controller catatan.
        dateRange:
            _selectedDateRange!, // Menggunakan rentang tanggal yang dipilih (karena sudah dipastikan tidak null).
      );

      widget.onAddTrip(
        newTrip,
      ); // Memanggil fungsi `onAddTrip` yang diteruskan dari halaman sebelumnya (HomePage) untuk mengirim data perjalanan baru.
      Navigator.pop(
        context,
      ); // Menutup halaman saat ini (AddTripPage) dan kembali ke halaman sebelumnya.
    } else if (_selectedDateRange == null) {
      // Jika rentang tanggal belum dipilih.
      ScaffoldMessenger.of(context).showSnackBar(
        // Menampilkan `SnackBar` (pesan singkat di bagian bawah layar) untuk memberi tahu pengguna.
        const SnackBar(
          content: Text("Please select a date range"),
        ), // Konten dari `SnackBar`.
      );
    }
  }

  @override // Meng-override metode `build` dari superkelas `State`. Metode ini mendefinisikan tampilan widget.
  Widget build(BuildContext context) {
    // Metode `build` menerima `BuildContext` yang berisi informasi tentang lokasi widget dalam hierarki widget.
    return Scaffold(
      // Mengembalikan widget `Scaffold`, yang menyediakan struktur dasar tata letak Material Design.
      backgroundColor: const Color(
        0xFFFFFADD,
      ), // Menetapkan warna latar belakang halaman.
      appBar: AppBar(
        // Widget AppBar untuk menampilkan judul di bagian atas halaman.
        title: const Text('Add Tour Reminder'), // Teks judul AppBar.
        backgroundColor: const Color(
          0xFFFFFADD,
        ), // Warna latar belakang AppBar.
        foregroundColor: Colors.black, // Warna teks dan ikon di AppBar.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        leading: const BackButton(), // Widget tombol kembali bawaan.
      ),
      body: Form(
        // Widget `Form` untuk mengelompokkan input fields dan mengelola validasi.
        key:
            _formKey, // Menghubungkan kunci global `_formKey` dengan widget `Form`.
        child: ListView(
          // Widget yang dapat di-scroll yang menampilkan child-nya secara linear.
          padding: const EdgeInsets.all(
            16,
          ), // Memberikan padding di sekitar konten list view.
          children: [
            // Date Picker
            InkWell(
              // Widget yang merespons sentuhan. Digunakan untuk membuat area yang dapat diklik untuk memilih rentang tanggal.
              onTap:
                  _pickDateRange, // Memanggil metode `_pickDateRange` saat area ini diketuk.
              child: Container(
                // Container untuk menampilkan informasi rentang tanggal yang dipilih.
                padding: const EdgeInsets.all(
                  16,
                ), // Padding di dalam container.
                decoration: BoxDecoration(
                  // Dekorasi container (border dan border radius).
                  border: Border.all(
                    color: Colors.grey,
                  ), // Menambahkan border berwarna abu-abu.
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Menambahkan border radius.
                ),
                child: Text(
                  // Menampilkan teks rentang tanggal yang dipilih atau pesan default jika belum dipilih.
                  _selectedDateRange == null
                      ? 'Pick date range'
                      : '${DateFormat.yMMMd().format(_selectedDateRange!.start)} - ${DateFormat.yMMMd().format(_selectedDateRange!.end)}', // Memformat tanggal menjadi format "MMM d, y" (contoh: "Jan 1, 2023").
                ),
              ),
            ),
            const SizedBox(height: 16), // Memberikan jarak vertikal.
            // Title
            TextFormField(
              // Field input teks untuk judul.
              controller:
                  _titleController, // Menghubungkan controller judul dengan field input.
              decoration: const InputDecoration(
                labelText: "What's the tour about",
              ), // Dekorasi untuk label field input.
              validator:
                  (value) => // Fungsi validator untuk field judul.
                      value == null || value.isEmpty
                          ? 'Please enter a title'
                          : null, // Mengembalikan pesan error jika nilai null atau kosong, jika tidak mengembalikan null (valid).
            ),
            const SizedBox(height: 16), // Memberikan jarak vertikal.
            // Location
            TextFormField(
              // Field input teks untuk lokasi.
              controller:
                  _locationController, // Menghubungkan controller lokasi dengan field input.
              decoration: const InputDecoration(
                labelText: "Location",
              ), // Dekorasi untuk label field input.
              validator:
                  (value) => // Fungsi validator untuk field lokasi.
                      value == null || value.isEmpty
                          ? 'Please enter a location'
                          : null, // Mengembalikan pesan error jika nilai null atau kosong, jika tidak mengembalikan null (valid).
            ),
            const SizedBox(height: 16), // Memberikan jarak vertikal.
            // Remarks
            TextFormField(
              // Field input teks untuk catatan.
              controller:
                  _remarksController, // Menghubungkan controller catatan dengan field input.
              decoration: const InputDecoration(
                labelText: "Remarks",
              ), // Dekorasi untuk label field input.
              maxLines:
                  3, // Mengatur jumlah maksimum baris yang dapat ditampilkan dalam field catatan.
            ),
            const SizedBox(height: 24), // Memberikan jarak vertikal.
            // Save button
            ElevatedButton(
              // Tombol untuk menyimpan perjalanan.
              onPressed:
                  _saveTrip, // Memanggil metode `_saveTrip` saat tombol ditekan.
              style: ElevatedButton.styleFrom(
                // Mengatur style tombol.
                backgroundColor: Colors.amber, // Warna latar belakang tombol.
                shape: RoundedRectangleBorder(
                  // Mengatur bentuk border tombol.
                  borderRadius: BorderRadius.circular(20),
                ), // Border radius tombol.
              ),
              child: const Padding(
                // Memberikan padding di sekitar teks tombol.
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ), // Teks tombol dengan warna hitam.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
