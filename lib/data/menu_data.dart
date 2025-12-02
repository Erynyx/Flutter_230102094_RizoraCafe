import '../models/menu_item.dart';

// List menu utama yang akan ditampilkan di aplikasi
final List<MenuItem> menuData = [

  // 🍽️ Menu makanan
  MenuItem(
    name: "Nasi Goreng Spesial",                 // Nama menu
    image: "assets/images/nasigoreng.jpg",       // Lokasi gambar
    price: 18000,                                // Harga
    description:
        "Nasi goreng dengan bumbu spesial, telur, sayuran, dan topping pilihan.",
    isDrink: false,                               // false = kategori makanan
  ),

  MenuItem(
    name: "Mie Goreng Pedas",
    image: "assets/images/miegoreng.jpg",
    price: 15000,
    description: "Mie goreng pedas dengan tambahan sayuran dan bumbu rempah.",
    isDrink: false,
  ),

  MenuItem(
    name: "Mie Kuah",
    image: "assets/images/miekuah.jpg",
    price: 16000,
    description: "Mie kuah gurih, cocok disajikan saat cuaca dingin.",
    isDrink: false,
  ),

  MenuItem(
    name: "Ramen Jepang",
    image: "assets/images/ramen.jpg",
    price: 25000,
    description:
        "Ramen dengan kuah gurih dan topping telur, sayuran, serta daging.",
    isDrink: false,
  ),

  // 🧋 Menu minuman
  MenuItem(
    name: "Teh Manis",
    image: "assets/images/esteh.jpg",
    price: 7000,
    description: "Teh manis segar yang cocok diminum kapan saja.",
    isDrink: true,
  ),

  MenuItem(
    name: "Teh Hijau",
    image: "assets/images/estehhijau.jpg",
    price: 8000,
    description: "Teh hijau menyegarkan dengan aroma teh pilihan.",
    isDrink: true,
  ),

  MenuItem(
    name: "Kopi Hitam",
    image: "assets/images/kopi.jpg",
    price: 10000,
    description: "Kopi hitam panas dengan aroma khas, tanpa gula.",
    isDrink: true,
  ),

  MenuItem(
    name: "Cappuccino",
    image: "assets/images/cappuccino.jpg",
    price: 15000,
    description: "Cappuccino creamy dengan taburan bubuk coklat.",
    isDrink: true,
  ),

  MenuItem(
    name: "Kopi Gula Aren",
    image: "assets/images/kopigulaaren.jpg",
    price: 14000,
    description:
        "Kopi susu creamy dengan campuran gula aren premium yang wangi.",
    isDrink: true,
  ),

  MenuItem(
    name: "Air Mineral",
    image: "assets/images/airputih.jpg",
    price: 5000,
    description: "Air mineral dingin yang menyegarkan.",
    isDrink: true,
  ),
];
