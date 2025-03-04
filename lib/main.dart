import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isPertalite = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(); // Mulai animasi goyangan

    Future.delayed(const Duration(seconds: 2), () {
      _controller.stop(); // Hentikan goyangan lebih dulu
      setState(() {
        isPertalite = false; // Ganti ke gambar kedua
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isPertalite = true; // Kembali ke gambar pertama setelah 3 detik
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Aku Pengoplos Handal",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8), // Jarak antara teks dan emoji
            const Text(
              "💸", // Emoji uang
              style: TextStyle(fontSize: 20), // Sesuaikan ukuran emoji
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/spbu.jpg"), // Gambar latar belakang
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5), // Warna putih transparan agar lebih menyatu
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 5), // Efek bayangan agar menonjol
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: isPertalite ? _animation.value : 0, // Goyang hanya saat gambar pertama
                      child: child,
                    );
                  },
                  child: Image.asset(
                    isPertalite ? "assets/pertalite.png" : "assets/pertamax.png",
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Text("🚗", style: TextStyle(fontSize: 18)), // Ikon di kiri
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Mobil batuk-batuk? Itu bukan masalah kita",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("💰", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Yang penting cuan lancar, customer? Ah, bodo amat",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("😁", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Harga naik terus, kualitas? Rahasia perusahaan",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("🧏‍♂️", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Customer tau? Tenang, kita pura-pura budek aja",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.5), // Tombol putih
                    foregroundColor: Colors.black, // Teks hitam
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black, width: 2), // Outline hitam
                    ),
                  ),
                  child: const Text("Ketuk untuk mengoplos"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
