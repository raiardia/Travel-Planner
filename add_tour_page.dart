import 'package:flutter/material.dart'; // Mengimpor library Material Design untuk membangun UI aplikasi Flutter.

class AddTourPage extends StatelessWidget {
  // Mendefinisikan kelas `AddTourPage`, yang merupakan widget stateless (tampilannya tidak berubah setelah dibuat).
  const AddTourPage({
    super.key,
  }); // Konstruktor untuk kelas `AddTourPage`. `super.key` meneruskan key ke konstruktor superkelas (StatelessWidget).

  @override // Meng-override metode `build` dari superkelas `StatelessWidget`. Metode ini mendefinisikan tampilan widget.
  Widget build(BuildContext context) {
    // Metode `build` menerima `BuildContext` yang berisi informasi tentang lokasi widget dalam hierarki widget.
    return Scaffold(
      // Mengembalikan widget `Scaffold`, yang menyediakan struktur dasar tata letak Material Design.
      backgroundColor: const Color(
        0xFFFFFADD,
      ), // Menetapkan warna latar belakang halaman menjadi krem.
      appBar: AppBar(
        // Widget AppBar untuk menampilkan judul di bagian atas halaman.
        backgroundColor: const Color(
          0xFFFFFADD,
        ), // Menetapkan warna latar belakang AppBar menjadi krem (sama dengan body).
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        leading: IconButton(
          // Widget tombol ikon di sisi kiri AppBar (biasanya untuk navigasi kembali).
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ), // Ikon panah kembali dengan warna abu-abu gelap.
          onPressed:
              () => Navigator.pop(
                context,
              ), // Fungsi yang dipanggil saat tombol kembali ditekan, akan kembali ke halaman sebelumnya.
        ),
        title: const Text(
          // Widget Text untuk menampilkan judul AppBar.
          'Add tour reminder',
          style: TextStyle(
            color: Colors.black87,
          ), // Style teks judul dengan warna abu-abu gelap.
        ),
        centerTitle:
            false, // Mengatur agar judul AppBar tidak berada di tengah.
      ),
      body: SingleChildScrollView(
        // Widget yang memungkinkan konten di dalamnya di-scroll jika melebihi ukuran layar.
        padding: const EdgeInsets.all(
          16,
        ), // Memberikan padding di sekitar konten yang dapat di-scroll.
        child: Column(
          // Menata child widget secara vertikal.
          crossAxisAlignment:
              CrossAxisAlignment
                  .start, // Mengatur alignment horizontal child widget ke kiri.
          children: [
            _buildCalendar(), // Memanggil metode untuk membangun tampilan kalender.
            const SizedBox(
              height: 20,
            ), // Memberikan jarak vertikal sebesar 20 logical pixels.
            _buildLabeledField(
              'Date',
              'Jan 5 - Jan 7',
            ), // Memanggil metode untuk membangun field input dengan label "Date" dan nilai awal "Jan 5 - Jan 7".
            _buildLabeledField(
              "What's the tour about",
              'Mount Bromo Sunrise Adventure',
            ), // Memanggil metode untuk membangun field input dengan label "What's the tour about" dan nilai awal "Mount Bromo Sunrise Adventure".
            _buildLabeledFieldWithIcon(
              'Location',
              'East Java',
              Icons.search,
            ), // Memanggil metode untuk membangun field input dengan label "Location", nilai awal "East Java", dan ikon pencarian.
            _buildLabeledField(
              'Remarks', // Memanggil metode untuk membangun field input dengan label "Remarks" dan nilai awal yang panjang.
              'Bring a jacket, mask, confirm jeep 3 days before',
              maxLines: 4,
            ), // Mengatur agar field "Remarks" dapat menampilkan hingga 4 baris teks.
            const SizedBox(
              height: 20,
            ), // Memberikan jarak vertikal sebesar 20 logical pixels.
            SizedBox(
              // Widget untuk mengatur ukuran child-nya.
              width:
                  double
                      .infinity, // Membuat tombol memenuhi lebar maksimum yang tersedia.
              height: 50, // Mengatur tinggi tombol menjadi 50 logical pixels.
              child: ElevatedButton(
                // Widget tombol yang memiliki tampilan yang ditinggikan.
                style: ElevatedButton.styleFrom(
                  // Mengatur style tombol.
                  backgroundColor: const Color(
                    0xFFFFC700,
                  ), // Menetapkan warna latar belakang tombol menjadi kuning keemasan.
                  shape: RoundedRectangleBorder(
                    // Mengatur bentuk border tombol menjadi rounded.
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // Radius border sebesar 30 logical pixels.
                  ),
                ),
                onPressed:
                    () {}, // Fungsi kosong yang akan dipanggil saat tombol ditekan (belum ada aksi yang diimplementasikan).
                child: const Text(
                  // Widget Text untuk menampilkan teks pada tombol.
                  'Save',
                  style: TextStyle(
                    color: Colors.black87, // Warna teks tombol abu-abu gelap.
                    fontWeight:
                        FontWeight.bold, // Membuat teks tombol menjadi tebal.
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    // Metode untuk membangun tampilan kalender.
    return Container(
      // Widget container untuk mengatur tampilan kalender.
      padding: const EdgeInsets.all(
        16,
      ), // Memberikan padding di sekitar tampilan kalender.
      decoration: BoxDecoration(
        // Dekorasi untuk latar belakang kalender.
        color: const Color(0xFFA7D3E8), // Warna latar belakang biru muda.
        borderRadius: BorderRadius.circular(
          16,
        ), // Radius border sebesar 16 logical pixels.
      ),
      child: Column(
        // Menata elemen-elemen kalender secara vertikal.
        children: [
          Row(
            // Menata ikon navigasi bulan dan teks bulan secara horizontal.
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween, // Mengatur jarak maksimum antara elemen.
            children: const [
              Icon(
                Icons.chevron_left,
              ), // Ikon panah kiri untuk navigasi ke bulan sebelumnya.
              Text(
                // Teks yang menampilkan bulan dan tahun.
                'JANUARY, 2025',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Membuat teks tebal.
                  letterSpacing: 1.2, // Memberikan jarak antar huruf.
                ),
              ),
              Icon(
                Icons.chevron_right,
              ), // Ikon panah kanan untuk navigasi ke bulan berikutnya.
            ],
          ),
          const SizedBox(
            height: 12,
          ), // Memberikan jarak vertikal sebesar 12 logical pixels.
          Table(
            // Widget untuk menampilkan data dalam format tabel.
            children: [
              const TableRow(
                // Baris pertama tabel untuk menampilkan nama hari.
                children: [
                  Text(
                    'S',
                    textAlign: TextAlign.center,
                  ), // Teks "S" (Sunday) dengan alignment tengah.
                  Text(
                    'M',
                    textAlign: TextAlign.center,
                  ), // Teks "M" (Monday) dengan alignment tengah.
                  Text(
                    'T',
                    textAlign: TextAlign.center,
                  ), // Teks "T" (Tuesday) dengan alignment tengah.
                  Text(
                    'W',
                    textAlign: TextAlign.center,
                  ), // Teks "W" (Wednesday) dengan alignment tengah.
                  Text(
                    'T',
                    textAlign: TextAlign.center,
                  ), // Teks "T" (Thursday) dengan alignment tengah.
                  Text(
                    'F',
                    textAlign: TextAlign.center,
                  ), // Teks "F" (Friday) dengan alignment tengah.
                  Text(
                    'S',
                    textAlign: TextAlign.center,
                  ), // Teks "S" (Saturday) dengan alignment tengah.
                ],
              ),
              for (
                var week = 0;
                week < 5;
                week++
              ) // Loop untuk membuat 5 baris minggu dalam kalender.
                TableRow(
                  // Baris untuk setiap minggu.
                  children: List.generate(7, (index) {
                    // Membuat 7 elemen (hari) dalam setiap baris.
                    final day =
                        week * 7 +
                        index +
                        1; // Menghitung nomor hari dalam bulan.
                    if (day < 1 || day > 31)
                      return const SizedBox(); // Jika nomor hari di luar rentang 1-31, kembalikan widget kosong.
                    final isSelected =
                        day == 5 ||
                        day ==
                            7; // Menentukan apakah hari ini adalah tanggal yang dipilih (contoh: tanggal 5 atau 7).
                    return Padding(
                      // Memberikan padding di sekitar setiap sel tanggal.
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        // Container untuk setiap sel tanggal.
                        height: 36, // Mengatur tinggi sel tanggal.
                        width: 36, // Mengatur lebar sel tanggal.
                        decoration: BoxDecoration(
                          // Dekorasi untuk latar belakang sel tanggal yang dipilih.
                          shape: BoxShape.circle, // Membuat bentuk lingkaran.
                          color:
                              isSelected
                                  ? Colors.white.withAlpha(
                                    (255 * 0.5).round(),
                                  ) // Warna putih dengan transparansi jika dipilih.
                                  : Colors
                                      .transparent, // Transparan jika tidak dipilih.
                        ),
                        child: Center(
                          // Memusatkan nomor hari di dalam sel.
                          child: Text(
                            '$day',
                            style: const TextStyle(
                              fontSize: 14,
                            ), // Style teks nomor hari.
                          ),
                        ),
                      ),
                    );
                  }),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledField(String label, String hint, {int maxLines = 1}) {
    // Metode untuk membangun field input dengan label.
    return Padding(
      // Memberikan padding di sekitar kolom label dan field input.
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        // Menata label dan field input secara vertikal.
        crossAxisAlignment:
            CrossAxisAlignment.start, // Mengatur alignment horizontal ke kiri.
        children: [
          Text(
            label, // Menampilkan label.
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ), // Style teks label.
          const SizedBox(
            height: 6,
          ), // Memberikan jarak vertikal antara label dan field input.
          TextFormField(
            // Widget field input teks.
            initialValue: hint, // Mengatur nilai awal field input.
            maxLines:
                maxLines, // Mengatur jumlah maksimum baris yang dapat ditampilkan.
            decoration: InputDecoration(
              // Dekorasi untuk field input.
              filled: true, // Mengisi latar belakang field input.
              fillColor: const Color(0xFFFFFADD), // Warna latar belakang krem.
              border: OutlineInputBorder(
                // Menambahkan border outline.
                borderRadius: BorderRadius.circular(6), // Radius border.
                borderSide: const BorderSide(
                  color: Colors.black12,
                ), // Warna border abu-abu sangat muda.
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ), // Padding di dalam field input.
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledFieldWithIcon(
    // Metode untuk membangun field input dengan label dan ikon.
    String label,
    String hint,
    IconData icon,
  ) {
    return Padding(
      // Memberikan padding di sekitar kolom label dan field input.
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        // Menata label dan field input secara vertikal.
        crossAxisAlignment:
            CrossAxisAlignment.start, // Mengatur alignment horizontal ke kiri.
        children: [
          Text(
            label, // Menampilkan label.
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ), // Style teks label.
          const SizedBox(
            height: 6,
          ), // Memberikan jarak vertikal antara label dan field input.
          TextFormField(
            // Widget field input teks.
            initialValue: hint, // Mengatur nilai awal field input.
            decoration: InputDecoration(
              // Dekorasi untuk field input.
              prefixIcon: Icon(icon), // Menambahkan ikon di awal field input.
              filled: true, // Mengisi latar belakang field input.
              fillColor: const Color(0xFFFFFADD), // Warna latar belakang krem.
              border: OutlineInputBorder(
                // Menambahkan border outline.
                borderRadius: BorderRadius.circular(6), // Radius border.
                borderSide: const BorderSide(
                  color: Colors.black12,
                ), // Warna border abu-abu sangat muda.
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ), // Padding di dalam field input.
            ),
          ),
        ],
      ),
    );
  }
}
