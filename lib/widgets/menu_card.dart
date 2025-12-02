import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;        // data menu
  final VoidCallback onTap;   // aksi saat diklik

  const MenuCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // klik card pindah ke detail
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // background card
          borderRadius: BorderRadius.circular(14), // sudut melengkung
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08), // bayangan lembut
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        // isi card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // gambar menu
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Image.asset(
                item.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover, // gambar penuh
              ),
            ),

            // teks nama & harga
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown, // warna teks
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Rp ${item.price.toStringAsFixed(0)}", // harga
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
