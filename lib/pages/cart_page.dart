import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController tableController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]+$');

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Pesanan"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: cart.clearCart,
          )
        ],
      ),

      body: Center(   // RESPONSIVE WRAPPER
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: cart.items.isEmpty
              ? const Center(
                  child: Text(
                    "Keranjang masih kosong",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  item.menu.image,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(item.menu.name),
                              subtitle: Text(
                                "Harga per item: Rp ${item.menu.price.toStringAsFixed(0)}",
                              ),

                              // TOMBOL + - UNTUK QUANTITY
                              trailing: SizedBox(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.red),
                                      onPressed: () {
                                        cart.decreaseQuantity(item);
                                      },
                                    ),
                                    Text(
                                      "${item.quantity}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle,
                                          color: Colors.green),
                                      onPressed: () {
                                        cart.increaseQuantity(item);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // BAGIAN CHECKOUT
                    _buildCheckoutSection(cart),
                  ],
                ),
        ),
      ),
    );
  }

  // BAGIAN CHECKOUT DIBAWAH
  Widget _buildCheckoutSection(CartController cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOTAL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Rp ${cart.totalPrice.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // INPUT NAMA
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Nama Pemesan",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // INPUT MEJA
          TextField(
            controller: tableController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Nomor Meja",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // TOMBOL CHECKOUT
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () => _checkout(cart),
            child: const Text("Kirim Pesanan ke Kasir"),
          ),
        ],
      ),
    );
  }

  // LOGIC CHECKOUT
  void _checkout(CartController cart) {
    // Validasi
    if (nameController.text.isEmpty) {
      _showError("Nama pemesan tidak boleh kosong.");
      return;
    }
    if (!onlyLetters.hasMatch(nameController.text)) {
      _showError("Nama hanya boleh huruf & spasi.");
      return;
    }
    if (tableController.text.isEmpty ||
        int.tryParse(tableController.text) == null) {
      _showError("Nomor meja harus angka.");
      return;
    }

    // 🔹 BUAT STRUK PESANAN
    String detailPesanan = "";
    for (var item in cart.items) {
      detailPesanan +=
          "- ${item.menu.name} x${item.quantity}: Rp ${item.totalPrice.toStringAsFixed(0)}\n";
    }

    // POPUP STRUK
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Struk Pemesanan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Nama: ${nameController.text}\n"
            "Meja: ${tableController.text}\n\n"
            "Detail Pesanan:\n$detailPesanan\n"
            "Total Pembayaran: Rp ${cart.totalPrice.toStringAsFixed(0)}\n\n"
            "Silakan bayar ke kasir agar pesanan segera diproses.",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                cart.clearCart();
                nameController.clear();
                tableController.clear();
              },
            )
          ],
        );
      },
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
