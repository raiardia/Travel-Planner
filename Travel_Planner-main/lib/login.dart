import 'package:flutter/material.dart'; // Mengimpor library Material Design untuk membangun UI aplikasi Flutter.
import 'register.dart'; // Mengimpor file `register.dart`, yang kemungkinan berisi implementasi halaman registrasi.
import 'home.dart'; // Mengimpor file `home.dart`, yang kemungkinan berisi implementasi halaman utama aplikasi.

class Login extends StatefulWidget {
  // Mendefinisikan kelas `Login`, yang merupakan widget stateful (memiliki state internal yang dapat berubah).
  const Login({
    super.key,
  }); // Konstruktor untuk kelas `Login`. `super.key` meneruskan key ke konstruktor superkelas (StatefulWidget).

  @override // Meng-override metode `createState` dari superkelas `StatefulWidget`. Metode ini membuat dan mengembalikan instance dari `_LoginState`.
  State<Login> createState() => _LoginState(); // Membuat dan mengembalikan instance dari kelas `_LoginState`, yang mengelola state untuk widget `Login`.
}

class _LoginState extends State<Login> {
  // Mendefinisikan kelas `_LoginState`, yang merupakan state yang sesuai dengan widget `Login`.
  bool _obscureText =
      true; // Variabel untuk mengontrol visibilitas teks password (true: disembunyikan, false: ditampilkan).
  bool _rememberMe =
      false; // Variabel untuk menyimpan status "Remember Me" checkbox.

  final TextEditingController _emailController =
      TextEditingController(); // Controller untuk mengambil teks dari field input email.
  final TextEditingController _passwordController =
      TextEditingController(); // Controller untuk mengambil teks dari field input password.

  void _handleLogin() {
    // Metode untuk menangani logika login.
    String email =
        _emailController.text; // Mendapatkan teks dari field input email.
    String password =
        _passwordController.text; // Mendapatkan teks dari field input password.

    print('Email: $email'); // Mencetak email ke konsol (untuk debugging).
    print(
      'Password: $password',
    ); // Mencetak password ke konsol (untuk debugging).

    // Tutup dialog login dulu
    Navigator.of(
      context,
    ).pop(); // Menutup dialog login (jika login ditampilkan dalam dialog).

    // Setelah itu, arahkan ke HomePage
    Future.delayed(const Duration(milliseconds: 300), () {
      // Menunda navigasi ke HomePage selama 300 milidetik.
      Navigator.pushReplacement(
        // Menavigasi ke HomePage dan mengganti halaman login saat ini.
        context, // Konteks saat ini.
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ), // Rute ke HomePage.
      );
    });
  }

  @override // Meng-override metode `build` dari superkelas `State`. Metode ini mendefinisikan tampilan widget.
  Widget build(BuildContext context) {
    // Metode `build` menerima `BuildContext` yang berisi informasi tentang lokasi widget dalam hierarki widget.
    return Scaffold(
      // Mengembalikan widget `Scaffold`, yang menyediakan struktur dasar tata letak Material Design.
      body: Center(
        // Memusatkan child widget di dalam Scaffold.
        child: Container(
          // Container untuk mengatur ukuran, warna, dan tata letak child widget.
          width:
              double
                  .infinity, // Membuat container memenuhi lebar maksimum yang tersedia.
          height:
              double
                  .infinity, // Membuat container memenuhi tinggi maksimum yang tersedia.
          color: const Color.fromARGB(
            255,
            34,
            102,
            141,
          ), // Menetapkan warna latar belakang container.
          child: Column(
            // Menata child widget secara vertikal.
            mainAxisAlignment:
                MainAxisAlignment
                    .center, // Memusatkan child widget secara vertikal di dalam Column.
            children: [
              // Daftar widget yang akan ditampilkan di dalam Column.
              Image.asset('assets/images/Logo.png'), // Menampilkan gambar logo.
              const SizedBox(height: 15), // Memberikan jarak vertikal.
              const SizedBox(
                // Container untuk mengatur lebar teks.
                width: 235, // Menetapkan lebar container.
                child: Text(
                  // Menampilkan teks deskripsi.
                  'Plan your tour travel and forget your burden, we will remind you in advance!', // Teks deskripsi.
                  textAlign: TextAlign.center, // Memusatkan teks.
                  style: TextStyle(
                    color: Colors.white,
                  ), // Menetapkan warna teks.
                ),
              ),
              Image.asset('assets/images/image 1.png'), // Menampilkan gambar.
              const SizedBox(height: 20), // Memberikan jarak vertikal.
              ElevatedButton(
                // Tombol "Get Started".
                style: ElevatedButton.styleFrom(
                  // Mengatur style tombol.
                  backgroundColor: const Color.fromARGB(
                    255,
                    193,
                    203,
                    156,
                  ), // Warna latar belakang tombol.
                  minimumSize: const Size(300, 46), // Ukuran minimum tombol.
                ),
                onPressed: () {
                  // Fungsi yang dipanggil saat tombol ditekan.
                  showDialog(
                    // Menampilkan dialog.
                    context: context, // Konteks saat ini.
                    builder: (context) {
                      // Builder untuk membangun konten dialog.
                      return StatefulBuilder(
                        // Memungkinkan perubahan state di dalam dialog.
                        builder: (context, setStateDialog) {
                          // Builder untuk membangun konten dialog dengan setState.
                          return Dialog(
                            // Widget Dialog.
                            shape: RoundedRectangleBorder(
                              // Mengatur bentuk border dialog.
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Radius border.
                            ),
                            child: SingleChildScrollView(
                              // Memungkinkan konten dialog di-scroll.
                              child: Container(
                                // Container untuk konten dialog.
                                width: 500, // Lebar container.
                                padding: const EdgeInsets.all(
                                  20,
                                ), // Padding container.
                                child: Column(
                                  // Menata konten dialog secara vertikal.
                                  mainAxisSize:
                                      MainAxisSize
                                          .min, // Mengatur ukuran kolom sesuai konten.
                                  children: [
                                    // Daftar widget di dalam kolom.
                                    Container(
                                      // Container untuk gambar.
                                      width: 100, // Lebar container.
                                      height: 100, // Tinggi container.
                                      decoration: BoxDecoration(
                                        // Dekorasi container.
                                        color: const Color.fromARGB(
                                          // Warna latar belakang container.
                                          255,
                                          34,
                                          102,
                                          141,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          13,
                                        ), // Radius border container.
                                      ),
                                      child: Image.asset(
                                        // Menampilkan gambar.
                                        'assets/images/Frame 1.png',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ), // Memberikan jarak vertikal.
                                    // Tombol login sosial
                                    socialLoginButton(
                                      // Tombol login sosial.
                                      'Login With Google', // Teks tombol.
                                      'assets/images/google.png', // Path gambar.
                                    ),
                                    SizedBox(height: 2), // Spasi vertikal.
                                    socialLoginButton(
                                      // Tombol login sosial.
                                      'Login With Facebook', // Teks tombol.
                                      'assets/images/facebook.png', // Path gambar.
                                    ),

                                    const Divider(), // Garis pembatas.
                                    // Input Email
                                    inputField(
                                      // Field input email.
                                      icon: Icons.email, // Ikon.
                                      label: 'Email :', // Label.
                                      hintText:
                                          'example@gmail.com', // Hint text.
                                      controller:
                                          _emailController, // Controller.
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ), // Memberikan jarak vertikal.
                                    // Input Password
                                    inputField(
                                      // Field input password.
                                      icon: Icons.key, // Ikon.
                                      label: 'Password :', // Label.
                                      hintText:
                                          'Masukkan Password', // Hint text.
                                      controller:
                                          _passwordController, // Controller.
                                      isPassword:
                                          true, // Menandakan ini field password.
                                      obscureText:
                                          _obscureText, // Mengontrol visibilitas teks.
                                      toggleObscure: () {
                                        // Fungsi untuk mengubah visibilitas teks.
                                        setStateDialog(() {
                                          // Memanggil setState di dalam dialog.
                                          _obscureText =
                                              !_obscureText; // Membalik nilai visibilitas.
                                        });
                                      },
                                    ),

                                    Row(
                                      // Baris untuk "Forgot Password?".
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .end, // Mengatur tata letak ke kanan.
                                      children: [
                                        // Daftar widget di dalam baris.
                                        GestureDetector(
                                          // Widget yang mendeteksi gestur.
                                          onTap:
                                              () {}, // Fungsi yang dipanggil saat ditekan.
                                          child: const Text(
                                            // Teks "Forgot Password?".
                                            'Forgot Password?',
                                            style: TextStyle(
                                              // Style teks.
                                              color: Color.fromARGB(
                                                255,
                                                114,
                                                33,
                                                243,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Theme(
                                      // Widget untuk menerapkan tema.
                                      data: Theme.of(context).copyWith(
                                        // Membuat salinan tema saat ini.
                                        checkboxTheme: CheckboxThemeData(
                                          // Tema untuk checkbox.
                                          shape:
                                              const CircleBorder(), // Bentuk checkbox.
                                          visualDensity: const VisualDensity(
                                            // Kepadatan visual checkbox.
                                            horizontal: -4.0,
                                            vertical: -4.0,
                                          ),
                                        ),
                                      ),
                                      child: CheckboxListTile(
                                        // Checkbox dengan label.
                                        title: const Text(
                                          // Label checkbox.
                                          'Remember Me',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        value: _rememberMe, // Nilai checkbox.
                                        onChanged: (value) {
                                          // Fungsi yang dipanggil saat nilai checkbox berubah.
                                          setStateDialog(() {
                                            // Memanggil setState di dalam dialog.
                                            _rememberMe =
                                                value!; // Mengubah nilai _rememberMe.
                                          });
                                        },
                                        controlAffinity: // Posisi checkbox relatif terhadap label.
                                            ListTileControlAffinity.leading,
                                        contentPadding:
                                            EdgeInsets
                                                .zero, // Padding konten checkbox.
                                        dense:
                                            true, // Membuat checkbox lebih padat.
                                        visualDensity: const VisualDensity(
                                          // Kepadatan visual checkbox.
                                          horizontal: -4.0,
                                          vertical: -4.0,
                                        ),
                                      ),
                                    ),

                                    // Tombol Login
                                    ElevatedButton(
                                      // Tombol Login.
                                      style: ElevatedButton.styleFrom(
                                        // Style tombol.
                                        backgroundColor: const Color.fromARGB(
                                          // Warna latar belakang tombol.
                                          255,
                                          99,
                                          88,
                                          220,
                                        ),
                                        minimumSize: const Size(
                                          300,
                                          35,
                                        ), // Ukuran minimum tombol.
                                        shape: RoundedRectangleBorder(
                                          // Bentuk border tombol.
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          _handleLogin, // Fungsi yang dipanggil saat tombol ditekan.
                                      child: const Text(
                                        // Teks tombol.
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    Row(
                                      // Baris untuk "Don't have an account?".
                                      mainAxisAlignment: // Tata letak baris.
                                          MainAxisAlignment.center,
                                      children: [
                                        // Daftar widget di dalam baris.
                                        const Text(
                                          "Don't have an account? ",
                                        ), // Teks.
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Register(),
                                            );
                                          },
                                          child: Text(
                                            'Register Account',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                114,
                                                33,
                                                243,
                                              ),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text(
                  // Teks tombol "Get Started".
                  'Get Started !',
                  style: TextStyle(
                    // Style teks.
                    color: Color.fromARGB(255, 34, 102, 141),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialLoginButton(String text, String imagePath) {
    // Widget untuk tombol login sosial.
    return ElevatedButton(
      // Tombol.
      style: ElevatedButton.styleFrom(
        // Style tombol.
        minimumSize: const Size(300, 33), // Ukuran minimum tombol.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Bentuk border tombol.
      ),
      onPressed: () {}, // Fungsi yang dipanggil saat tombol ditekan.
      child: Row(
        // Baris untuk ikon dan teks.
        mainAxisAlignment: MainAxisAlignment.center, // Memusatkan konten.
        children: [
          // Daftar widget di dalam baris.
          Image.asset(imagePath, width: 17), // Ikon.
          const SizedBox(width: 10), // Spasi.
          Text(text, style: const TextStyle(color: Colors.black)), // Teks.
        ],
      ),
    );
  }

  Widget inputField({
    // Widget untuk field input.
    required IconData icon, // Ikon.
    required String label, // Label.
    required String hintText, // Hint text.
    required TextEditingController controller, // Controller.
    bool isPassword = false, // Menandakan ini field password.
    bool obscureText = false, // Mengontrol visibilitas teks.
    VoidCallback? toggleObscure, // Fungsi untuk mengubah visibilitas teks.
  }) {
    return Container(
      // Container untuk field input.
      width: double.infinity, // Lebar container.
      height: 35, // Tinggi container.
      decoration: BoxDecoration(
        // Dekorasi container.
        color: const Color.fromARGB(
          255,
          206,
          206,
          206,
        ), // Warna latar belakang container.
        borderRadius: BorderRadius.circular(10), // Radius border container.
      ),
      child: Row(
        // Baris untuk ikon, label, dan text field.
        children: [
          // Daftar widget di dalam baris.
          const SizedBox(width: 15), // Spasi.
          Icon(icon), // Ikon.
          const SizedBox(width: 15), // Spasi.
          Text(label), // Label.
          Expanded(
            // Memenuhi sisa ruang yang tersedia.
            child: TextField(
              // Field input.
              controller: controller, // Controller.
              obscureText:
                  isPassword
                      ? obscureText
                      : false, // Mengontrol visibilitas teks.
              keyboardType: // Tipe keyboard.
                  isPassword
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ), // Style teks.
              decoration: InputDecoration(
                // Dekorasi field input.
                hintText: hintText, // Hint text.
                border: InputBorder.none, // Tidak ada border.
                contentPadding: const EdgeInsets.symmetric(
                  // Padding konten.
                  horizontal: 8,
                  vertical: 9,
                ),
                suffixIcon: // Ikon di akhir field input.
                    isPassword &&
                            toggleObscure !=
                                null // Jika ini field password dan ada fungsi toggle.
                        ? IconButton(
                          // Tombol untuk mengubah visibilitas.
                          onPressed:
                              toggleObscure, // Fungsi yang dipanggil saat ditekan.
                          icon: Icon(
                            // Ikon visibilitas.
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )
                        : null, // Jika tidak, tidak ada ikon.
              ),
            ),
          ),
        ],
      ),
    );
  }
}
