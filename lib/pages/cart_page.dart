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

  final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]+$'); // Hanya huruf & spasi

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
            onPressed: () {
              cart.clearCart();
            },
          )
        ],
      ),

      body: cart.items.isEmpty
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
                            "Qty: ${item.quantity}\nHarga: Rp ${item.totalPrice.toStringAsFixed(0)}",
                          ),
                          trailing: IconButton(
                            icon:
                                const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              cart.removeFromCart(item);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bagian bawah untuk total + input nama + meja + checkout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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

                      // 🔹 Input Nama Pemesan
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

                      // 🔹 Input Nomor Meja (hanya angka)
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

                      // CHECKOUT BUTTON
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
                        onPressed: () {
                          // Validasi Nama pemesan
                          if (nameController.text.isEmpty) {
                            _showError("Nama pemesan tidak boleh kosong.");
                            return;
                          }

                          if (!onlyLetters.hasMatch(nameController.text)) {
                            _showError("Nama hanya boleh huruf dan spasi.");
                            return;
                          }

                          // Validasi nomor meja
                          if (tableController.text.isEmpty) {
                            _showError("Nomor meja harus diisi.");
                            return;
                          }

                          if (int.tryParse(tableController.text) == null) {
                            _showError("Nomor meja hanya boleh angka.");
                            return;
                          }

                          // Pop Up Konfirmasi
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text(
                                  "Pesanan Dikirim",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  "Pesanan atas nama *${nameController.text}* untuk meja *${tableController.text}* sudah dikirim ke kasir.\n\n"
                                  "Silakan melakukan pembayaran terlebih dahulu agar pesanan dapat segera diproses."
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      cart.clearCart();
                                      nameController.clear();
                                      tableController.clear();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text("Kirim Pesanan ke Kasir"),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
