import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hotelapp/models/cart_item.dart';

import 'hotel.dart';

class Restaurant extends ChangeNotifier {
  int totalItemCount = 1;
  String? customerName;
  String? customerSurname;
  String? customerPhone;
  DateTime? rentalStartDate;
  DateTime? rentalEndDate;

  final List<Hotel> _menu = [
    Hotel(
        name: "Hotel A",
        imagePath: "lib/images/warszawa/warszawa1.jpg",
        price: 215,
        category: HotelCategory.warszawa),
    Hotel(
        name: "Hotel B",
        imagePath: "lib/images/warszawa/warszawa2.jpg",
        price: 317,
        category: HotelCategory.warszawa),
    Hotel(
        name: "Hotel C",
        imagePath: "lib/images/warszawa/warszawa3.jpg",
        price: 225,
        category: HotelCategory.warszawa),
    Hotel(
        name: "Hotel D",
        imagePath: "lib/images/warszawa/warszawa4.jpg",
        price: 120,
        category: HotelCategory.warszawa),
    Hotel(
        name: "Hotel A",
        imagePath: "lib/images/poznan/poznan1.jpg",
        price: 220,
        category: HotelCategory.poznan),
    Hotel(
        name: "Hotel B",
        imagePath: "lib/images/poznan/poznan2.jpg",
        price: 324,
        category: HotelCategory.poznan),
    Hotel(
        name: "Hotel C",
        imagePath: "lib/images/poznan/poznan3.jpg",
        price: 125,
        category: HotelCategory.poznan),
    Hotel(
        name: "Hotel D",
        imagePath: "lib/images/poznan/poznan4.jpg",
        price: 230,
        category: HotelCategory.poznan),
    Hotel(
        name: "Hotel A",
        imagePath: "lib/images/krakow/krakow1.jpg",
        price: 117,
        category: HotelCategory.krakow),
    Hotel(
        name: "Hotel B",
        imagePath: "lib/images/krakow/krakow2.jpg",
        price: 220,
        category: HotelCategory.krakow),
    Hotel(
        name: "Hotel C",
        imagePath: "lib/images/krakow/krakow3.jpg",
        price: 325,
        category: HotelCategory.krakow),
    Hotel(
        name: "Hotel A",
        imagePath: "lib/images/gdansk/gdansk1.jpg",
        price: 245,
        category: HotelCategory.gdansk),
    Hotel(
        name: "Hotel B",
        imagePath: "lib/images/gdansk/gdansk2.jpg",
        price: 285,
        category: HotelCategory.gdansk),
    Hotel(
        name: "Hotel A",
        imagePath: "lib/images/wroclaw/wroclaw1.jpg",
        price: 228,
        category: HotelCategory.wroclaw),
    Hotel(
        name: "Hotel B",
        imagePath: "lib/images/wroclaw/wroclaw2.jpg",
        price: 115,
        category: HotelCategory.wroclaw),
    Hotel(
        name: "Hotel C",
        imagePath: "lib/images/wroclaw/wroclaw3.jpg",
        price: 311,
        category: HotelCategory.wroclaw),
  ];

  List<Hotel> get menu => _menu;
  List<CartItem> get cart => _cart;

  final List<CartItem> _cart = [];

  void addToCart(Hotel hotel) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameHotel = item.hotel == hotel;

      return isSameHotel;
    });

    if (cartItem != null) {
    } else {
      _cart.add(CartItem(hotel: hotel));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartItem != 1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  void setTotalItemCount(int count) {
    totalItemCount = count;
    notifyListeners();
  }

  double getTodalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.hotel.price;
      total += itemTotal * totalItemCount;
    }
    return total;
  }

  int getTotalItemCount() {
    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  String displayCardReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Podsumowanie:");
    receipt.writeln();

    // Add personal information
    if (customerName != null && customerSurname != null) {
      receipt.writeln("Imię: $customerName");
      receipt.writeln("Nazwisko: $customerSurname");
    }
    if (customerPhone != null) {
      receipt.writeln("Numer telefonu: $customerPhone");
    }

    // Add rental dates
    if (rentalStartDate != null && rentalEndDate != null) {
      receipt.writeln(
          "Wynajem od: ${DateFormat('yyyy-MM-dd').format(rentalStartDate!)}");
      receipt.writeln(
          "Wynajem do: ${DateFormat('yyyy-MM-dd').format(rentalEndDate!)}");
    }

    receipt.writeln();
    receipt.writeln("--------------");
    receipt.writeln();

    for (final CartItem in _cart) {
      receipt.writeln(
          "${totalItemCount} dni w: ${CartItem.hotel.name} - ${_formatPrice(CartItem.hotel.price)}");
      receipt.writeln();
    }
    receipt.writeln("--------------");
    receipt.writeln();

    receipt.writeln("Cena całkowita ${_formatPrice(getTodalPrice())}");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} zł";
  }
}
