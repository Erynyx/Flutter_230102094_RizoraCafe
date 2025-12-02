import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../controllers/cart_controller.dart';

class DetailPage extends StatefulWidget {
  final MenuItem menu;

  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.menu.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: Center(
        child: SizedBox(
          width: 600, // Batas MAKS biar tidak strech saat di laptop/pc
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderImage(),

              const SizedBox(height: 20),

              // Nama makanan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.menu.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: Colors.grey.shade300),
              ),

              // Deskripsi makanan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.menu.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Jumlah
              _buildQuantitySelector(),

              const Spacer(),

              _buildOrderButton(context),
            ],
          ),
        ),
      ),
    );
  }

  //  BAGIAN GAMBAR ATAS
  Widget _buildHeaderImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AspectRatio(
            aspectRatio: 3 / 2, // Responsif & Tidak Overflow
            child: Image.asset(
              widget.menu.image,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradasi bawah
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.45),
                ],
              ),
            ),
          ),
        ),

        // Harga pojok kanan
        Positioned(
          right: 16,
          bottom: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Rp ${widget.menu.price}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //  PILIH JUMLAH
  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            "Jumlah:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          Row(
            children: [
              _quantityButton(
                icon: Icons.remove_circle,
                onTap: () {
                  if (quantity > 1) setState(() => quantity--);
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "$quantity",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              _quantityButton(
                icon: Icons.add_circle,
                onTap: () => setState(() => quantity++),
              ),
            ],
          )
        ],
      ),
    );
  }

  // BUTTON TAMBAH / KURANG
  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Icon(
        icon,
        size: 28,
        color: Colors.orange,
      ),
    );
  }

  // TOMBOL PESAN
  Widget _buildOrderButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        onPressed: () {
          final cart = Provider.of<CartController>(context, listen: false);
          cart.addToCart(widget.menu, quantity);

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text("Pesanan Masuk!"),
              content: const Text("Pesanan sudah masuk ke keranjang."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                )
              ],
            ),
          );
        },

        child: Text(
          "Pesan Sekarang (Rp ${widget.menu.price * quantity})",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
