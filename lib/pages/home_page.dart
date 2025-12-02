import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu_item.dart';
import 'detail_page.dart';
import '../widgets/section_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // warna background aplikasi

      appBar: AppBar(
        title: const Text(
          "Rizora Cafe's",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange, // warna header
        centerTitle: true,
        elevation: 0, // tanpa shadow
      ),

      body: SingleChildScrollView(
        // agar halaman bisa discroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // judul section "Daftar Menu"
            const SectionTitle(title: "Daftar Menu"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: menuData.length, // jumlah item menu
                shrinkWrap: true, // agar GridView menyesuaikan height
                physics: const NeverScrollableScrollPhysics(),
                // GridView tidak scroll sendiri

                // pengaturan grid 2 kolom
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 item per baris
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.82,
                  // rasio tinggi-lebar card
                ),

                itemBuilder: (context, index) {
                  final MenuItem item = menuData[index]; // ambil item menu

                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    // animasi klik mengikuti radius card

                    onTap: () {
                      // pindah ke halaman detail menu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(menu: item),
                        ),
                      );
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            // bayangan lembut card
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // bagan foto menu
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14),
                            ),
                            child: Image.asset(
                              item.image, // gambar menu
                              height: 180, // diperbesar agar lebih penuh
                              width: double.infinity,
                              fit: BoxFit.cover,
                              // gambar memenuhi area tanpa distorsi
                            ),
                          ),

                          // nama menu
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              item.name,
                              maxLines: 2, // maksimal 2 baris
                              overflow: TextOverflow.ellipsis,
                              // membuat titik (...) kalau nama terlalu panjang
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // harga menu
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Rp ${item.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8), // jarak bawah
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
